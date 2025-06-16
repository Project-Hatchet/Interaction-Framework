/*
 * hct_interaction_fnc_loadAll
 *
 * loads interaction from config
 *
 * params: (array)[(object) vehicle]
 */

params ["_vehicle"];

private _vehicleInteraction = [];

private _vehicleConfig = _vehicle getVariable "hct_config";
private _interaction = "true" configClasses (_vehicleConfig >> "interaction");

{ // forEach _interaction
  _vehicleInteraction pushBack ([_vehicle, _x] call hct_interaction_fnc_loadItem);
} forEach _interaction;

_vehicle setVariable ["hct_interaction", _vehicleInteraction];
