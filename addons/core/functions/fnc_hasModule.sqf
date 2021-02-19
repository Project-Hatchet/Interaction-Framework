#include "script_component.hpp"
/*
 * hatchet_core_fnc_hasModule
 *
 * Checks if a module exists
 *
 * Params: array[array[(object) vehicle, (string) module name, (optional, string) classname]
 * Returns: (boolean) has module
 *
 * Author: Yax
 */

params ["_vehicle", "_moduleName", ["_className", nil]];

private _vehicleModuleArray = _vehicle getVariable [QGVAR(modules), []];
private _isClass = if (!isNil "_className") then [{_vehicle isKindOf _className}, {true}];
private _hasModule = false;
{ // forEach _vehicleModuleArray
  _name = _x # 0;
  if (_moduleName == _name) exitWith {
    _hasModule = true;
  };
} forEach _vehicleModuleArray;

(_hasModule && _isClass)
