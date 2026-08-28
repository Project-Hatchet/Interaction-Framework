# Development branch changelog

Top block is the next dev push's change note (rendered to the Workshop by
`tools/push_dev.py --note-from-changelog`). Write entries in player language -
what changed for the player, not how. Keep the top block titled **Unreleased**
between pushes; the push script stamps it with the version it ships.

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
