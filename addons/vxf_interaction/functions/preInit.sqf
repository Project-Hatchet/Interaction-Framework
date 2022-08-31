[
  "Hatchet Vehicle Framework",
  "vxf_interaction",
  "Vehicle Interaction",
  {[vehicle player, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonDown},
  {[vehicle player, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonUp},
  [33, [false, false, false]],
  false
] call CBA_fnc_addKeybind;

[
  "vxf_interaction_updateEvery",
  "SLIDER",
  "Label update rates(frames between)",
  "Hatchet Vehicle Framework",
  [0,10,5,0],
  nil,
  {}
] call CBA_Settings_fnc_init;

[
  "vxf_uh60_interaction_pointing",
  "checkbox",
  "Enable pointing system(uses remoteCall)",
  "Hatchet Vehicle Framework",
  [true],
  nil,
  {}
] call CBA_Settings_fnc_init;

