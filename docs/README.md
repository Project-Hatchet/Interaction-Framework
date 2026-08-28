# Interaction Framework documentation

| Path | What it is |
|---|---|
| `Framework_Readthrough_2026-08-27.pdf` | The full-repo code readthrough that seeded the current tracker: 19 findings ranked High/Medium/Low with file/line references and a suggested order of attack. The High findings shipped in dev build 0.3.3.1; the rest live as tracker issues. Start here for context on why each punch-list issue exists. |
| `API.md` | (planned - issue #74) The authoritative reference for the config schema and every script callback with its exact arguments. Until it exists, the README at the repo root is the closest thing, and it is known to have drifted (#75). |

Work is organized by **tracker milestone** rather than phases - the framework is small
enough that a punch list beats a phased plan:

| Milestone | Scope |
|---|---|
| [Correctness punch list](https://github.com/Project-Hatchet/Interaction-Framework/milestone/3) | Bug fixes from the readthrough plus open bug reports. One branch and PR each. |
| [API and docs stewardship](https://github.com/Project-Hatchet/Interaction-Framework/milestone/4) | Callback contracts, README/Examples accuracy, `API.md`, changelog discipline. |
| [Seat-policy migration](https://github.com/Project-Hatchet/Interaction-Framework/milestone/5) | Remove the global countermeasure/zoom key hooks in coordination with the H-60 improvement plan item 5.8. |

As a milestone accumulates design documents of its own, it gets a folder here
(`punch-list/`, `api-stewardship/`, `seat-policy/`) holding the `SCREAMING_SNAKE_CASE.md`
source and any rendered PDF copy - the same convention as the H-60 and H-1 repos.

## Conventions

- `*.md` files are the in-repo references; a matching `*.pdf` is the rendered reader copy.
  When one changes, re-render the other.
- The framework is a **dependency with external consumers** (H-60 and third-party mods),
  so every change that touches what a config key means or what a callback receives is an
  API change: it gets called out in review, documented in `API.md`, and flagged in the
  changelog.
- `CHANGELOG-DEV.md` at the repo root is the development-branch changelog
  (player language; rendered to the Workshop dev item by `tools/push_dev.py`).
  `CHANGELOG.md` tracks stable releases.
- Dev builds ship unsigned from the dev Workshop item via `tools/push_dev.py`;
  stable pushes and signing are done manually.
