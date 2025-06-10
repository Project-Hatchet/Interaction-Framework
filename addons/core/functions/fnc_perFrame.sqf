/*
 * hct_core_fnc_perFrame
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
  (vehicle hct_player != _vehicle) ||
  (!alive hct_player) ||
  (!alive _vehicle)
) exitWith {
  [hct_vehicle] call hct_core_fnc_shutDownAll;
  [_pfhId] call CBA_fnc_removePerFrameHandler;
  hct_perFrameHandler = nil;
  if (!isNil {hct_drawHandler}) then {
    removeMissionEventHandler ["Draw3D",hct_drawHandler];
    hct_drawHandler = nil;
  };
};

if (cba_missionTime == _lastFrameTime) exitWith {hct_paused = true;};
_args set [1, cba_missionTime];
if (hct_paused) then {
  // unpause
  ["hct_unPause", []] call CBA_fnc_localEvent;
};
hct_paused = false;

//frame time will be passed on to modules
private _frameTime = (cba_missionTime - _lastFrameTime);
//skip a frame when unpausing so time between frames stays normal
if (_frameTime > 1) exitWith {};

private ["_func"];
{ //forEach vehicle hct_modules
  if (_x # 1) then {
    _func = missionNamespace getVariable (_x # 3);
    if (!isNil {_func}) then {[_vehicle, _frameTime] call _func;};
  };
} forEach (_vehicle getVariable ["hct_modules", []]);
