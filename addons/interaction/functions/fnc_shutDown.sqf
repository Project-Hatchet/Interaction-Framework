/*
 * hct_interaction_fnc_shutDown
 *
 * stops the interaction system for the vehicle
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

private _redrawActionID = _vehicle getVariable ["hct_interaction_redrawActionID", -1];
if (_redrawActionID != -1) then {
  _vehicle removeAction _redrawActionID;
  _vehicle setVariable ["hct_interaction_redrawActionID", nil];
};
