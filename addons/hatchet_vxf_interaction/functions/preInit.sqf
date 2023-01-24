[
  "Hatchet Vehicle Framework",
  "vxf_interaction_scrollUpAlt",
  "Scroll Up Alternative",
  {vxf_alternative_scroll_up = true;},
  {vxf_alternative_scroll_up = false;},
  [16, [false, true, false]],
  false
] call CBA_fnc_addKeybind;
[
  "Hatchet Vehicle Framework",
  "vxf_interaction_scrollDownAlt",
  "Scroll Down Alternative",
  {vxf_alternative_scroll_down = true;},
  {vxf_alternative_scroll_down = false;},
  [18, [false, true, false]],
  false
] call CBA_fnc_addKeybind;

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
  "Hatchet Vehicle Framework",
  "vxf_interaction_alternative",
  "Vehicle Interaction Alternative (adds alt+F by default)",
  {[vehicle player, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonDown},
  {[vehicle player, vxf_interaction_currentButton] call vxf_interaction_fnc_buttonUp},
  [33, [false, false, true]],
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

[
  "Hatchet Vehicle Framework",
  "vxf_cursor_hold",
  "Show Interaction Cursor",
  {
    if (isNil "vxf_vehicle") exitWith {};
    vxf_interaction_cursor_mouseDown = false;
    (findDisplay 46) createDisplay "vxf_interaction_mouseBlocker";
    (finddisplay 86005) displayAddEventHandler ["KeyUp", {[_this,'keyup'] call CBA_events_fnc_keyHandler}];
    setMousePosition [0.5, 0.5];
  },
  {
    if (isNil "vxf_vehicle") exitWith {};
    if (uiNamespace getVariable ["vxf_interaction_mouseBlocker", false]) then {
      (findDisplay 86005) closeDisplay 0;
    };
  },
  [220, [false, false, false]],
  false
] call CBA_fnc_addKeybind;

[
  "vxf_uh60_interaction_autoclose_actionmenu",
  "checkbox",
  "Automatically close action menu (experimental)",
  "Hatchet Vehicle Framework",
  [false],
  nil,
  {}
] call CBA_Settings_fnc_init;


vtx_uh60m_enabled_jvmf = true;
vtx_uh60m_enabled_fms = true;
vtx_uh60m_enabled_mfd = true;
vtx_uh60m_enabled_fd = true;
vtx_uh60m_enabled_cas = true;
vtx_uh60m_enabled_aar = true;
vtx_uh60m_enabled_flir = true;
vtx_uh60m_enabled_engine = true;
vxf_alternative_scroll_up = false;
vxf_alternative_scroll_down = false;