#include "script_component.hpp"
/*
 * hct_interaction_fnc_redraw
 *
 * rebuilds the interaction display and resets stuck interaction state, so
 * players can recover if the interaction UI gets stuck or misplaced.
 * triggered by the "Redraw Interactions" keybind (hct_interaction_redraw).
 *
 * params (array)[(optional, object) vehicle - defaults to the current hct vehicle]
 */

params [["_vehicle", objNull]];

// the keybind can be pressed anywhere: hct_vehicle is nil on foot or in
// vehicles without hct config
if (isNil "hct_vehicle") exitWith {};
if (isNull _vehicle) then {_vehicle = hct_vehicle;};

with uiNamespace do {
  ctrlDelete hct_cursor_ctrl;
  hct_cursor_ctrl = nil;
};

[_vehicle] call hct_interaction_fnc_loadAll;

hct_interaction_currentButton = nil;
hct_interaction_buttonHoldCode = nil;
hct_interaction_buttonHolding = false;
hct_interaction_knobHolding = nil;
hct_interaction_dragging = false;
hct_animating_keys = [];
hct_interaction_updateIndex = hct_interaction_updateEvery;
hct_point_icons = [];
