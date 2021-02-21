#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_loadAll
 *
 * loads interaction from config
 *
 * params: (array)[(object) vehicle]
 */

params ["_vehicle"];

private _vehicleInteraction = [];

private _vehicleConfig = _vehicle getVariable QRVAR(config);
private _interaction = "true" configClasses (_vehicleConfig >> "interaction");

{ // forEach _interaction
  _vehicleInteraction pushBack ([_vehicle, _x] call FUNC(loadItem));
} forEach _interaction;

_vehicle setVariable [QGVAR(points), _vehicleInteraction];
