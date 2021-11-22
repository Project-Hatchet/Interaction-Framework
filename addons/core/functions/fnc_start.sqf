#include "script_component.hpp"
/*
 * htf_core_fnc_start
 *
 * Starts a loaded module
 *
 * Params: array[array[(object) vehicle, (string) module name]
 * Returns: nothing
 *
 * Author: Yax
 */

params ["_vehicle", "_moduleName", ["_parameters", nil]];

private _vehicleModuleArray = _vehicle getVariable [QGVAR(modules), []];

private ["_moduleName", "_running", "_setup"];
{ // forEach _vehicleModuleArray
  _module = _x;
  _name = _module # 0;
  if (_moduleName == _name) exitWith {
    _running = _module # 1;
    _setup = _module # 2;
    if (!_running) then {
      private _func = (missionNameSpace getVariable _setup);
      if (!isNil "_func" && typeName _func == "CODE") then {
        _running = ([_vehicle, _parameters] call _func);
      };
    };
    _module set [1, _running];
    _vehicleModuleArray set [_forEachIndex, _module];
  };
} forEach _vehicleModuleArray;
