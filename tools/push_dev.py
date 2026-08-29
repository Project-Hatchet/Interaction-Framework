"""
push_dev.py - build the framework from a named git ref with HEMTT and upload
it to the Steam Workshop DEVELOPMENT item.

    python tools/push_dev.py --branch <ref> --note "what changed"
    python tools/push_dev.py --branch <ref> --note-file notes.txt
    python tools/push_dev.py --branch <ref> --note-from-changelog --bump             # usual dev push: 0.3.3.1 -> 0.3.3.2
    python tools/push_dev.py --branch <ref> --note-from-changelog --version 0.3.3.1  # first push of a new cycle
    python tools/push_dev.py --branch <ref> --note-from-changelog --bump --preview-note  # print the note and exit
    python tools/push_dev.py --branch <ref> --note "..." --dry-run                   # build + verify, no upload

What it does, in order:
  1. refuses to run on a dirty working tree
  2. checks out <ref> (and returns to the previous checkout afterwards)
  3. with --bump/--version: stamps the new version into
     addons/main/script_version.hpp, retitles the **Unreleased** block at
     the top of CHANGELOG-DEV.md to that version, and commits both on <ref>
     - so the in-game version, the changelog and the Workshop note agree
  4. runs `hemtt build`, stages .hemttout/build into release/@HCT-dev with a
     Development-branch mod.cpp, and verifies every addon produced a fresh PBO
  5. shows a summary and asks for confirmation (skip with --yes)
  6. uploads release/@HCT-dev with PublisherCmd, which uses the Steam client
     already logged in on this machine - no credentials are stored anywhere

Versioning follows the H-60 scheme: Stable is X.Y.Z; Dev builds carry the
NEXT Stable's number with the build digit counting up per push. Start a
cycle with --version, continue it with --bump. Promotion to Stable is manual.

Deliberately DEV-ONLY: the public framework item is not known to this script.

First-time setup: create the Workshop item once (Arma 3 Tools > Publisher,
any placeholder upload), set its visibility on its Workshop page, then put
its numeric id in DEV_WORKSHOP_ID below.
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
import winreg
from pathlib import Path

DEV_WORKSHOP_ID = "2403978406"  # Hatchet Interaction Framework - Development branch (Project Hatchet account)
ISSUE_URL = "https://github.com/Project-Hatchet/Interaction-Framework/issues/"
MOD_FOLDER = Path("release") / "@HCT-dev"
HEMTT_OUT = Path(".hemttout") / "build"
PBO_PREFIX = "hct_"
VERSION_FILE = "addons/main/script_version.hpp"
CHANGELOG = "CHANGELOG-DEV.md"
DEV_MOD_CPP = """name = "Hatchet Interaction Framework - Development branch";
picture = "logo_hatchet_ca.paa";
actionName = "GitHub";
action = "https://github.com/Project-Hatchet/Interaction-Framework";
description = "Hatchet Interaction Framework - Development branch";
logo = "logo_hatchet_ca.paa";
logoOver = "logo_hatchet_ca.paa";
tooltip = "Hatchet Interaction Framework - Development branch";
tooltipOwned = "Hatchet Interaction Framework - Development branch";
overview = "Hatchet Interaction Framework - Development branch";
author = "Hatchet Team";
dlcColor[] = {1, 0.0, 0.86, 1};
"""

REPO = Path(__file__).resolve().parent.parent


def die(msg, code=1):
    print(f"\npush_dev: {msg}", file=sys.stderr)
    sys.exit(code)


def run(cmd, **kw):
    return subprocess.run(cmd, cwd=REPO, text=True, capture_output=True, **kw)


def git(*args):
    r = run(["git", *args])
    if r.returncode != 0:
        die(f"git {' '.join(args)} failed:\n{r.stderr.strip()}")
    return r.stdout.strip()


def a3tools_path():
    with winreg.OpenKey(winreg.HKEY_CURRENT_USER, r"SOFTWARE\Bohemia Interactive\Arma 3 Tools") as key:
        return Path(winreg.QueryValueEx(key, "path")[0])


def publisher_cmd():
    exe = a3tools_path() / "Publisher" / "PublisherCmd.exe"
    if not exe.exists():
        die(f"PublisherCmd.exe not found at {exe}")
    return exe


# --- change note -----------------------------------------------------------

def show_file(ref, path):
    """Contents of a file at a git ref, without checking it out."""
    r = run(["git", "show", f"{ref}:{path}"])
    if r.returncode != 0:
        die(f"{path} not found at {ref}")
    return r.stdout


def linkify(text):
    """#123 -> BBCode link to the GitHub issue/PR."""
    return re.sub(r"#(\d{1,5})\b", lambda m: f"[url={ISSUE_URL}{m.group(1)}]#{m.group(1)}[/url]", text)


HEADER_RE = re.compile(r"^\s*\*\*(.+?)\*\*\s*$")
BULLET_RE = re.compile(r"^\s*-\s+(.*\S)")


def top_block(changelog_text):
    """(header, [bullets]) of the first version block in CHANGELOG-DEV.md."""
    header, items = None, []
    for line in changelog_text.splitlines():
        h = HEADER_RE.match(line)
        if h:
            if header is not None:
                break
            header = h.group(1).strip()
            continue
        b = BULLET_RE.match(line)
        if b and header is not None:
            items.append(b.group(1).strip())
    if header is None or not items:
        die(f"could not find a version block with bullets at the top of {CHANGELOG}")
    return header, items


def parse_version(hpp_text):
    nums = {k: int(v) for k, v in re.findall(r"#define\s+(MAJOR|MINOR|PATCH|BUILD)\s+(\d+)", hpp_text)}
    if len(nums) != 4:
        die(f"{VERSION_FILE} does not define MAJOR/MINOR/PATCH/BUILD")
    return (nums["MAJOR"], nums["MINOR"], nums["PATCH"], nums["BUILD"])


def fmt_version(v):
    return ".".join(str(n) for n in v)


def target_version(ref, args):
    """The version this push will carry: explicit --version, --bump of the ref's version, or the ref's version as-is."""
    current = parse_version(show_file(ref, VERSION_FILE))
    if args.version:
        parts = args.version.split(".")
        if len(parts) != 4 or not all(p.isdigit() for p in parts):
            die("--version must look like 0.3.3.1")
        return tuple(int(p) for p in parts), True
    if args.bump:
        return (*current[:3], current[3] + 1), True
    return current, False


def changelog_note(ref, version):
    """Top block of CHANGELOG-DEV.md at <ref>, rendered as a Steam BBCode change note under <version>."""
    header, items = top_block(show_file(ref, CHANGELOG))
    if header.lower() == "unreleased" and version is None:
        die("the top changelog block is **Unreleased** - pass --bump or --version to stamp it, "
            "or --note to bypass the changelog")
    label = fmt_version(version) if version else header
    out = [
        f"[h1]Dev build {label}[/h1]",
        f"[i]{ref}[/i]",
        "[list]",
        *[f"[*]{linkify(item)}" for item in items],
        "[/list]",
    ]
    return "\n".join(out)


def add_build_code(note, ref, sha):
    """Append the build code to the note's branch stamp line, so the Workshop
    note identifies the exact commit that was built (a --bump/--version stamp
    commit moves the branch, so this must run AFTER stamping)."""
    return note.replace(f"[i]{ref}[/i]", f"[i]{ref} @ {sha}[/i]", 1)


def stamp_version(version):
    """On the checked-out branch: write the version, retitle the Unreleased block, commit both."""
    label = fmt_version(version)
    hpp = REPO / VERSION_FILE
    hpp_text = hpp.read_text(encoding="utf-8")
    nl = "\r\n" if "\r\n" in hpp_text else "\n"
    hpp.write_text(nl.join([f"#define MAJOR {version[0]}", f"#define MINOR {version[1]}",
                            f"#define PATCH {version[2]}", f"#define BUILD {version[3]}", ""]), encoding="utf-8")

    cl = REPO / CHANGELOG
    text = cl.read_text(encoding="utf-8")
    header, _ = top_block(text)
    if header.lower() == "unreleased":
        text = re.sub(r"^(\s*)\*\*Unreleased\*\*", lambda m: f"{m.group(1)}**{label}**", text, count=1, flags=re.M | re.I)
        cl.write_text(text, encoding="utf-8")
    elif header != label:
        die(f"top changelog block is **{header}**, expected **Unreleased** (or **{label}** to re-push)")

    if git("status", "--porcelain"):
        git("add", VERSION_FILE, CHANGELOG)
        git("commit", "-q", "-m", f"Dev build {label}")
        print(f"  stamped {label} into {VERSION_FILE} and {CHANGELOG} (committed on the branch)")
    else:
        print(f"  {label} already stamped, nothing to commit")


# --- build -----------------------------------------------------------------

def build():
    addons_dir = REPO / "addons"
    expected = sorted(p.name for p in addons_dir.iterdir() if p.is_dir())

    started = time.time()
    print(f"  building {len(expected)} addons with hemtt...")
    r = subprocess.run(["hemtt", "build"], cwd=REPO, text=True, capture_output=True, shell=True)
    if r.returncode != 0:
        print(r.stdout[-3000:])
        die(f"hemtt build failed:\n{r.stderr[-2000:]}")

    src = REPO / HEMTT_OUT
    if not src.exists():
        die(f"hemtt output not found at {src}")

    # stage the finished mod folder: hemtt output + Development-branch mod.cpp
    dest = REPO / MOD_FOLDER
    if dest.exists():
        shutil.rmtree(dest)
    shutil.copytree(src, dest)
    (dest / "mod.cpp").write_text(DEV_MOD_CPP, encoding="utf-8")

    out = dest / "addons"
    problems = []
    total = 0
    for name in expected:
        pbo = out / f"{PBO_PREFIX}{name}.pbo"
        if not pbo.exists():
            problems.append(f"missing {pbo.name}")
        elif pbo.stat().st_mtime < started:
            problems.append(f"stale {pbo.name} (not rebuilt)")
        elif pbo.stat().st_size == 0:
            problems.append(f"empty {pbo.name}")
        else:
            total += pbo.stat().st_size
    if problems:
        die("build verification failed:\n  " + "\n  ".join(problems))
    return len(expected), total


# --- main ------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--branch", required=True, help="git ref to build (branch, tag, or sha)")
    note = ap.add_mutually_exclusive_group(required=True)
    note.add_argument("--note", help="Workshop change note text")
    note.add_argument("--note-file", help="file containing the change note")
    note.add_argument("--note-from-changelog", action="store_true",
                      help="build the note from the top version block of CHANGELOG-DEV.md at <ref>")
    ver = ap.add_mutually_exclusive_group()
    ver.add_argument("--bump", action="store_true", help="increment the build digit of the version on <ref> and stamp it")
    ver.add_argument("--version", help="stamp this exact version (e.g. 0.3.3.1) - use for the first push of a cycle")
    ap.add_argument("--preview-note", action="store_true", help="print the change note and exit (no build, no upload)")
    ap.add_argument("--dry-run", action="store_true", help="build and verify, skip the upload")
    ap.add_argument("--yes", action="store_true", help="skip the confirmation prompt")
    ap.add_argument("--skip-build", action="store_true", help="upload whatever is in release/@HCT-dev (no checkout/build)")
    args = ap.parse_args()

    if not DEV_WORKSHOP_ID and not (args.dry_run or args.preview_note):
        die("DEV_WORKSHOP_ID is not set - create the Dev Workshop item once "
            "(Arma 3 Tools > Publisher), then put its numeric id at the top of this script")

    git("rev-parse", "--verify", f"{args.branch}^{{commit}}")
    version, stamp = target_version(args.branch, args)
    if stamp and args.skip_build:
        die("--bump/--version need a checkout to stamp the branch; drop --skip-build")

    if args.note_from_changelog:
        note_text = changelog_note(args.branch, version if stamp else None)
    elif args.note is not None:
        note_text = args.note
    else:
        note_text = Path(args.note_file).read_text(encoding="utf-8")
    if not note_text.strip():
        die("the change note is empty - describe what changed")
    if args.preview_note:
        # pre-stamp preview: shows the ref's current tip; a --bump/--version
        # push will show the stamp commit's code instead
        print(add_build_code(note_text, args.branch, git("rev-parse", "--short", args.branch)))
        return

    if not args.skip_build:
        if git("status", "--porcelain"):
            die("working tree is not clean - commit or stash first")
        previous = git("rev-parse", "--abbrev-ref", "HEAD")
        if previous == "HEAD":
            previous = git("rev-parse", "HEAD")
        print(f"checking out {args.branch} (will return to {previous})")
        git("checkout", "-q", args.branch)
        try:
            if stamp:
                stamp_version(version)
            sha = git("rev-parse", "--short", "HEAD")
            count, total = build()
        finally:
            git("checkout", "-q", previous)
    else:
        sha = "(skip-build)"
        out = REPO / MOD_FOLDER / "addons"
        pbos = list(out.glob(f"{PBO_PREFIX}*.pbo"))
        count, total = len(pbos), sum(p.stat().st_size for p in pbos)

    note_sha = sha if sha != "(skip-build)" else git("rev-parse", "--short", args.branch)
    note_text = add_build_code(note_text, args.branch, note_sha)

    print("\n=== Framework Dev push summary ===")
    print(f"  ref:      {args.branch} @ {sha}")
    print(f"  version:  {fmt_version(version)}{'  (stamped)' if stamp else ''}")
    print(f"  content:  {REPO / MOD_FOLDER}  ({count} PBOs, {total / 1e6:,.1f} MB)")
    print(f"  item:     https://steamcommunity.com/sharedfiles/filedetails/?id={DEV_WORKSHOP_ID}")
    print("  note:")
    for line in note_text.strip().splitlines():
        print(f"    {line}")

    if args.dry_run:
        print("\ndry run - build verified, nothing uploaded.")
        return

    if not args.yes:
        answer = input("\nUpload to the framework Dev Workshop item? [y/N] ").strip().lower()
        if answer != "y":
            die("aborted, nothing uploaded", 0)

    exe = publisher_cmd()
    with tempfile.NamedTemporaryFile("w", suffix=".txt", delete=False, encoding="utf-8") as tmp:
        tmp.write(note_text)
        note_path = tmp.name
    try:
        r = subprocess.run(
            [str(exe), "update", f"/id:{DEV_WORKSHOP_ID}", f"/changeNoteFile:{note_path}",
             f"/path:{REPO / MOD_FOLDER}", "/nologo"],
            cwd=REPO, text=True, capture_output=True,
        )
    finally:
        os.unlink(note_path)
    print(r.stdout)
    if r.returncode != 0:
        die(f"PublisherCmd failed (exit {r.returncode}):\n{r.stderr}")

    log = REPO / "release" / "push_dev.log"
    log.parent.mkdir(exist_ok=True)
    with log.open("a", encoding="utf-8") as f:
        f.write(f"{time.strftime('%Y-%m-%d %H:%M')}  {args.branch}@{sha}  {count} PBOs  {note_text.strip().splitlines()[0]}\n")
    print("uploaded to the framework Dev Workshop item.")


if __name__ == "__main__":
    main()
