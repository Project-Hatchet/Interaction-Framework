[
  "VXF Interaction",
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
  "VXF Interaction",
  [0,10,5,0],
  nil,
  {}
] call CBA_Settings_fnc_init;

[
  "vxf_uh60_interaction_pointing",
  "checkbox",
  "Enable pointing system(uses remoteCall)",
  "VXF Interaction",
  [true],
  nil,
  {}
] call CBA_Settings_fnc_init;

["vtx_uh60m_enabled_jvmf","CHECKBOX","(DEBUG) Enable JVMF","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_fms","CHECKBOX","(DEBUG) Enable FMS","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_mfd","CHECKBOX","(DEBUG) Enable MFD","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_fd","CHECKBOX","(DEBUG) Enable FD","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_cas","CHECKBOX","(DEBUG) Enable CAS","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_aar","CHECKBOX","(DEBUG) Enable AAR","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_flir","CHECKBOX","(DEBUG) Enable FLIR","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
["vtx_uh60m_enabled_engine","CHECKBOX","(DEBUG) Enable ENGINE","UH-60M",[true],nil,{}] call CBA_Settings_fnc_init;
