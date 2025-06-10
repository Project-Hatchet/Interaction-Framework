/*
 * hct_interaction_fnc_setup
 *
 * starts the interaction system
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

_this call hct_interaction_fnc_loadAll;

if (isNil{hct_drawHandler}) then {
  hct_drawHandler = addmissioneventhandler ["Draw3d",hct_interaction_fnc_draw3D];
};

hct_animating_keys = [];
hct_interaction_cursorPos = [0.5,0.5];

hct_akn_use = actionKeysNames "hct_interaction_use";
hct_akn_prev = actionKeysNames "prevAction";
hct_akn_next = actionKeysNames "nextAction";

true
