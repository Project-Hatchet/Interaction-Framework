/*
 * vxf_core_fnc_setup
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

vxf_perFrameHandler call CBA_fnc_removePerFrameHandler;
vxf_perSecondHandler call CBA_fnc_removePerFrameHandler;
if (!isNil "vxf_drawHandler") then {
  removeMissionEventHandler ["Draw3d",vxf_drawHandler];
};
vxf_perFrameHandler = nil;
vxf_perSecondHandler = nil;
vxf_drawHandler = nil;

private ["_func"];
{ //forEach vehicle vxf_modules
  if (_x # 1) then {
    _func = missionNameSpace getVariable (_x # 5);
    if (!isNil {_func}) then {[_vehicle] call _func;};
  };
  _x set [1, false];
} forEach (_vehicle getVariable ["vxf_modules", []]);

//["turret", vxf_interaction_vehicleSwitchedEH] call CBA_fnc_removePlayerEventHandler;
vxf_vehicle = nil;
