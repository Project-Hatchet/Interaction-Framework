# Development branch changelog

Top block is the next dev push's change note (rendered to the Workshop by
`tools/push_dev.py --note-from-changelog`). Write entries in player language -
what changed for the player, not how. Keep the top block titled **Unreleased**
between pushes; the push script stamps it with the version it ships.

**Unreleased**

- Fixed: knobs now respond to their keybinds on the first use in a session (#63)
- Fixed: the "Enable debug messages" option in Addon Options now works (#60)
- Fixed: hidden repeating background errors while sitting in framework vehicles (#61)
- Fixed: hidden errors when pressing the countermeasure or zoom keys on foot or in normal vehicles (#62)
- Fixed: turning a vehicle module on from a script now works (#59)
