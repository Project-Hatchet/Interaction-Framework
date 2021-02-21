#include "script_component.hpp"
/*
 * hatchet_core_fnc_load
 *
 * Loads a single module with default paths
 *
 * Params: array[array[(object) vehicle, (string) module name]
 * Returns: nothing
 *
 * Author: Yax
 */

params ["_vehicle", "_moduleName"];

private _vehicleModuleArray = _vehicle getVariable [QGVAR(modules), []];
private _startUp = true;

#define HANDLEDEFAULT(VAR,MODULENAME,PATH) private VAR = format[PATH, MODULENAME];
HANDLEDEFAULT(_setup,_moduleName,"hatchet_%1_fnc_setup")
HANDLEDEFAULT(_perFrame,_moduleName,"hatchet_%1_fnc_perFrame")
HANDLEDEFAULT(_perSecond,_moduleName,"hatchet_%1_fnc_perSecond")
HANDLEDEFAULT(_shutDown,_moduleName,"hatchet_%1_fnc_shutDown")

if (_startUp && {_setup != ""}) then {
  private _func = missionNameSpace getVariable _setup;
  if (!isNil "_func" && {typeName _func == "CODE"}) then {
    _result = [_vehicle] call _func;
    if (typeName _result == "BOOL" && {!_result}) then {
      _startUp = false;
    };
  };
};

_vehicleModuleArray pushBack [
  _moduleName,
  _startUp,
  _setup,
  _perFrame,
  _perSecond,
  _shutDown
];

_vehicle setVariable [QGVAR(modules), _vehicleModuleArray];
