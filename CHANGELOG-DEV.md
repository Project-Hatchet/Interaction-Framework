# Development branch changelog

Entries are written in batches, in a changelog PR of their own, after a set of
PRs has merged or before a stable release - never inside feature PRs. The
devbuild branch stacks every PR labeled `Ready for Testing` on top of `main`,
and two PRs that both add a block at the top of this file cannot be stacked:
the second one is skipped from the build. Dev build Workshop notes come from
the labeled PR list (`tools/push_dev.py --note-from-prs`), not from this file.

Write entries in player language - what changed for the player, not how - and
end each one with its PR number, like the H-60's changelog. A push that uses
`--note-from-changelog` renders the top block as its Workshop note; keep that
block titled **Unreleased** until the push stamps it with the version shipped.

**0.3.3.2**

- Fixed: severe display-loop error introduced in 0.3.3.1 that could spam errors or freeze the game when entering framework vehicles (caught before wide testing - if you downloaded 0.3.3.1, please update)

**0.3.3.1**

- Fixed: knobs now respond to their keybinds on the first use in a session (#63)
- Fixed: the "Enable debug messages" option in Addon Options now works (#60)
- Fixed: hidden repeating background errors while sitting in framework vehicles (#61)
- Fixed: hidden errors when pressing the countermeasure or zoom keys on foot or in normal vehicles (#62)
- Fixed: turning a vehicle module on from a script now works (#59)
- Fixed: switches and knobs no longer move while their conditions disable them (#56)
- Fixed: a held button now always releases cleanly, even if its condition changed mid-hold (#56)
- Fixed: holding the previous/next setting keybind no longer re-triggers a knob every frame (#56)
- Fixed: the interaction display now heals itself if it breaks after network hiccups (#58)
- Added: a "Redraw Interactions" scroll-wheel action to manually rebuild a stuck interaction display (#58)
- Fixed: repeated background errors on the Steam profiling branch when entering vehicles with knobs (#58)
