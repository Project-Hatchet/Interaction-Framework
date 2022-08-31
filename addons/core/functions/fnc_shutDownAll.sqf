#include "script_component.hpp"
/*
 * vxf_core_fnc_shutDownAll
 *
 * Reads out relevant vehicle modules from config and stores them in vehicle variables
 *
 * Params: array[array[(object) vehicle]
 * Returns: nothing
 *
 * Author: Yax
 */

params ["_vehicle"];

if (isNil "_vehicle") then {_vehicle = vxf_vehicle};

[GVAR(perFrameHandler)] call CBA_fnc_removePerFrameHandler;
[GVAR(perSecondHandler)] call CBA_fnc_removePerFrameHandler;

if !(isNil QGVAR(drawHandler)) then {
  removeMissionEventHandler ["Draw3d", GVAR(drawHandler)];
};

GVAR(perFrameHandler) = nil;
GVAR(perSecondHandler) = nil;
GVAR(drawHandler) = nil;

private ["_func"];
{ //forEach vehicle vxf_core_modules
  if (_x # 1) then {
    _func = missionNameSpace getVariable (_x # 5);
    if (!isNil {_func}) then {[_vehicle] call _func;};
  };
  _x set [1, false];
} forEach (_vehicle getVariable [QGVAR(modules), []]);

vxf_vehicle = nil;
