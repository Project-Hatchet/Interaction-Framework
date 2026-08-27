#include "script_component.hpp"
/*
 * hct_interaction_fnc_redraw
 * triggered via the "Redraw Interactions" scroll wheel action added to any vehicle running the interaction module (see fnc_setup.sqf/fnc_shutDown.sqf),
 * so players can recover from the interaction UI getting stuck tiny/misplaced after bad network desync.
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

with uiNamespace do {
  ctrlDelete hct_cursor_ctrl;
  hct_cursor_ctrl = nil;
};

[_vehicle] call hct_interaction_fnc_loadAll;

hct_interaction_currentButton = nil;
hct_interaction_buttonHoldCode = nil;
hct_interaction_buttonHolding = false;
hct_interaction_knobHolding = nil;
hct_interaction_updateIndex = hct_interaction_updateEvery;
hct_point_icons = [];

[] call hct_interaction_fnc_attemptCloseActionMenu;
