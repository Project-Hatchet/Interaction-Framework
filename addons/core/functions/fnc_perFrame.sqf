#include "script_component.hpp"
/*
 * htf_core_fnc_perFrame
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
  !((vehicle htf_player) isEqualTo _vehicle) ||
  !(alive htf_player) ||
  !(alive _vehicle)
) exitWith {
  [GVAR(vehicle)] call FUNC(shutDownAll);
  [_pfhId] call CBA_fnc_removePerFrameHandler;
  GVAR(perFrameHandler) = nil;
  if (!isNil {GVAR(drawHandler)}) then {
    removeMissionEventHandler ["Draw3d", GVAR(drawHandler)];
    GVAR(drawHandler) = nil;
  };
};

if (cba_missionTime == _lastFrameTime) exitWith {GVAR(paused) = true;};
_args set [1, cba_missionTime];
if (GVAR(paused)) then {
  // unpause
  [QGVAR(unPause), []] call CBA_fnc_localEvent;
};
GVAR(paused) = false;

//frame time will be passed on to modules
private _frameTime = (cba_missionTime - _lastFrameTime);
//skip a frame when unpausing so time between frames stays normal
if (_frameTime > 1) exitWith {};

{ //forEach vehicle htf_core_modules
  if (_x # 1) then {
    private _func = missionNameSpace getVariable (_x # 3);
    if (!isNil {_func}) then {[_vehicle, _frameTime] call _func;};
  };
} forEach (_vehicle getVariable [QGVAR(modules), []]);
