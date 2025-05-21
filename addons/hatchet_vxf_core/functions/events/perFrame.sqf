/*
 * vxf_core_fnc_perFrame
 *
 * Function will run relevante modules' per frame functions
 *
 * Params: array[array[(object) vehicle, (scalar) last frame time], (scalar)pfhId]
 * Returns: nothing
 *
 * Author: Yax
 */
params ["_args", "_pfhId"];
_args params ["_vehicle", "_lastFrameTime"];

//shutdown conditions
if (
  (vehicle ace_player != _vehicle) ||
  (!alive ace_player) ||
  (!alive _vehicle)
) exitWith {
  [vxf_vehicle] call vxf_core_fnc_shutDownAll;
  [_pfhId] call CBA_fnc_removePerFrameHandler;
  vxf_perFrameHandler = nil;
  if (!isNil {vxf_drawHandler}) then {
    removeMissionEventHandler ["Draw3d",vxf_drawHandler];
    vxf_drawHandler = nil;
  };
};

if (cba_missionTime == _lastFrameTime) exitWith {vxf_paused = true;};
_args set [1, cba_missionTime];
if (vxf_paused) then {
  // unpause
  ["vxf_unPause", []] call CBA_fnc_localEvent;
};
vxf_paused = false;

//frame time will be passed on to modules
private _frameTime = (cba_missionTime - _lastFrameTime);
//skip a frame when unpausing so time between frames stays normal
if (_frameTime > 1) exitWith {};

private ["_func"];
{ //forEach vehicle vxf_modules
  if (_x # 1) then {
    _func = missionNameSpace getVariable (_x # 3);
    if (!isNil {_func}) then {[_vehicle, _frameTime] call _func;};
  };
} forEach (_vehicle getVariable ["vxf_modules", []]);
