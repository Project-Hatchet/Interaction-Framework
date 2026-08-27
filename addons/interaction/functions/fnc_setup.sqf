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
  hct_drawHandler = addMissionEventHandler ["Draw3D",hct_interaction_fnc_Draw3D];
};

hct_animating_keys = [];
hct_interaction_cursorPos = [0.5,0.5];

hct_akn_use = actionKeysNames "hct_interaction_use";
hct_akn_prev = actionKeysNames "prevAction";
hct_akn_next = actionKeysNames "nextAction";

if (isNil {_vehicle getVariable "hct_interaction_redrawActionID"}) then {
  // extremely low priority so this sorts to the very bottom of the scroll wheel
  // action menu, below anything else on the vehicle
  private _redrawActionID = _vehicle addAction [
    "Redraw Interactions",
    {[_this select 0] call hct_interaction_fnc_redraw;},
    nil,
    -1000000,
    false,
    true,
    "",
    "true"
  ];
  _vehicle setVariable ["hct_interaction_redrawActionID", _redrawActionID];
};

true
