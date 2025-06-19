[
  "hct_interaction_updateEvery",
  "SLIDER",
  "Label update rates(frames between)",
  "Hatchet Vehicle Framework",
  [0,10,5,0],
  nil,
  {}
] call CBA_Settings_fnc_init;

[
  "hct_interaction_pointing",
  "checkbox",
  "Enable pointing system(uses remoteCall)",
  "Hatchet Vehicle Framework",
  [true],
  nil,
  {}
] call CBA_Settings_fnc_init;
/*
[
    "hct_interaction_cursor_shape",
    "EDITBOX",
    ["STR_HCT_INTERACTION_CursorShape", "STR_HCT_INTERACTION_CursorShape_Description"],
    "Hatchet Vehicle Framework",
    ["\A3\ui_f\data\igui\cfg\cursors\iconComplex_ca.paa"],
    nil,
    {if !(fileExists hct_interaction_cursor_shape) then {hct_interaction_cursor_shape = "\A3\ui_f\data\igui\cfg\cursors\iconComplex_ca.paa";};}
] call CBA_Settings_fnc_init;
*/
[
    "hct_interaction_trackIR_interaction_cursor",
    "CHECKBOX",
    ["STR_HCT_INTERACTION_Cursor", "STR_HCT_INTERACTION_Cursor_Description"],
    "Hatchet Vehicle Framework",
    [false],
    nil,
    {if !hct_interaction_trackIR_interaction_cursor then {hct_interaction_cursorPos = [0.5,0.5];}; uiNamespace setVariable ["hct_interaction_trackIR_interaction_cursor", hct_interaction_trackIR_interaction_cursor];}
] call CBA_Settings_fnc_init;

[
    "hct_interaction_trackIR_interaction_cursor_invert",
    "CHECKBOX",
    ["STR_HCT_INTERACTION_CursorInvert", "STR_HCT_INTERACTION_CursorInvert_Description"],
    "Hatchet Vehicle Framework",
    [false],
    nil,
    {}
] call CBA_Settings_fnc_init;

[
    "hct_interaction_trackIR_interaction_cursorSensitivity",
    "SLIDER",
    ["STR_HCT_INTERACTION_DetachedCursorSensitivity", "STR_HCT_INTERACTION_Cursor_Description"],
    "Hatchet Vehicle Framework",
    [1,10,2.5,1],
    nil,
    {}
] call CBA_Settings_fnc_init;

[
  "hct_interaction_autoclose_actionmenu",
  "checkbox",
  "Automatically close action menu (experimental)",
  "Hatchet Vehicle Framework",
  [false],
  nil,
  {}
] call CBA_Settings_fnc_init;

[
  "hct_interaction_cursorText",
  "LIST",
  [
    "Cursor Shape",
    "Select what the interaction cursor looks like."
  ],
  "Hatchet Vehicle Framework",
  [
    ["·","•","×","+","-"],
    ["·","•","×","+","-"],
    2
  ],
  false, // isGlobal
  {uiNamespace setVariable ["hct_interaction_cursorText", hct_interaction_cursorText];}, // callback,
  false // needRestart
] call CBA_fnc_addSetting;

[
    "hct_interaction_cursorColor", "COLOR",
    ["Cursor Color", "Colour of the interaction cursor."],
    "Hatchet Vehicle Framework",
    ["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet, // default value
    false, // isGlobal
    {uiNamespace setVariable ["hct_interaction_cursorColor", hct_interaction_cursorColor call BIS_fnc_colorRGBAtoHTML];}, // callback,
    false // needRestart
] call CBA_settings_fnc_init;

[
  "hct_interaction_showLabels",
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
  "hct_interaction_showDebugMessages",
  "checkbox",
  "str_hct_interaction_enable_debugmessages",
  "Hatchet Vehicle Framework",
  [false],
  nil,
  {}
] call CBA_Settings_fnc_init;

hct_alternative_scroll_up = false;
hct_alternative_scroll_down = false;

uiNamespace setVariable [
  "hct_interaction_mouseBlocker",
  false
];
