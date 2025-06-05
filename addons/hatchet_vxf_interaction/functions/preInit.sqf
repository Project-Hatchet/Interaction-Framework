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
  "vxf_interaction_pointing",
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
    "vxf_interaction_cursor_shape",
    "EDITBOX",
    ["STR_VXF_INTERACTION_CursorShape", "STR_VXF_INTERACTION_CursorShape_Description"],
    "Hatchet Vehicle Framework",
    ["\A3\ui_f\data\igui\cfg\cursors\iconComplex_ca.paa"],
    nil,
    {if !(fileExists vxf_interaction_cursor_shape) then {vxf_interaction_cursor_shape = "\A3\ui_f\data\igui\cfg\cursors\iconComplex_ca.paa";};}
] call CBA_Settings_fnc_init;

[
    "vxf_interaction_trackIR_interaction_cursor",
    "CHECKBOX",
    ["STR_VXF_INTERACTION_Cursor", "STR_VXF_INTERACTION_Cursor_Description"],
    "Hatchet Vehicle Framework",
    [false],
    nil,
    {if !vxf_interaction_trackIR_interaction_cursor then {vxf_interaction_cursorPos = [0.5,0.5];};}
] call CBA_Settings_fnc_init;

[
    "vxf_interaction_trackIR_interaction_cursor_invert",
    "CHECKBOX",
    ["STR_VXF_INTERACTION_CursorInvert", "STR_VXF_INTERACTION_CursorInvert_Description"],
    "Hatchet Vehicle Framework",
    [false],
    nil,
    {}
] call CBA_Settings_fnc_init;

[
    "vxf_interaction_trackIR_interaction_cursorSensitivity",
    "SLIDER",
    ["STR_VXF_INTERACTION_DetachedCursorSensitivity", "STR_VXF_INTERACTION_Cursor_Description"],
    "Hatchet Vehicle Framework",
    [1,10,2.5,1],
    nil,
    {}
] call CBA_Settings_fnc_init;

[
  "vxf_interaction_autoclose_actionmenu",
  "checkbox",
  "Automatically close action menu (experimental)",
  "Hatchet Vehicle Framework",
  [false],
  nil,
  {}
] call CBA_Settings_fnc_init;

[
  "vxf_interaction_showLabels",
  "LIST",
  [
    "Label Text",
    "Select what format of interaction labels to show."
  ],
  "Hatchet Vehicle Framework",
  [
    [0, 1, 2],
    ["No Labels","Interaction Name", "Interaction Name + Keybinds"],
    2
  ]
] call CBA_fnc_addSetting;

[
  "vxf_interaction_labelsMode",
  "LIST",
  [
    "Label Draw Method",
    "Test which method is better performance."
  ],
  "Hatchet Vehicle Framework",
  [
    [0, 1, 2],
    ["dynamicText","drawIcon3D", "UI"],
    0
  ], 0,{
    with uiNamespace do {
      ctrlDelete	vtx_cursor_ctrl;
      vtx_cursor_ctrl = nil;
    };
  }
] call CBA_fnc_addSetting;
vxf_interaction_fnc_drawLabel0 = compile preprocessFileLineNumbers "hatchet_vxf_interaction\functions\drawLabel0.sqf";
vxf_interaction_fnc_drawLabel1 = compile preprocessFileLineNumbers "hatchet_vxf_interaction\functions\drawLabel1.sqf";
vxf_interaction_fnc_drawLabel2 = compile preprocessFileLineNumbers "hatchet_vxf_interaction\functions\drawLabel2.sqf";
vxf_interaction_fnc_drawLabel2_set = {
  params ["_prev", "_next"];
  uiNamespace setVariable ["vxf_interaction_drawLabel2_text_prev", _prev];
  uiNamespace setVariable ["vxf_interaction_drawLabel2_text_next", _next];
  with uiNamespace do {
    vtx_cursor_ctrl ctrlSetStructuredText parseText format [
      "<t size='1' align='center'>%1<br/><br/>%2<br/><br/><br/>%3</t>",
      vxf_interaction_drawLabel2_text_prev,
      ".",
      vxf_interaction_drawLabel2_text_next
    ];
    vtx_cursor_ctrl ctrlSetPosition [(-safeZoneX)+(vxf_interaction_cursorPos # 0) - (safeZoneW / 2),((vxf_interaction_cursorPos # 1) - 0.1),1,1];
    vtx_cursor_ctrl ctrlCommit 0;
  };
};

[
  "vxf_interaction_showDebugMessages",
  "checkbox",
  "Enable debug messages",
  "Hatchet Vehicle Framework",
  [false],
  nil,
  {}
] call CBA_Settings_fnc_init;

vxf_alternative_scroll_up = false;
vxf_alternative_scroll_down = false;
