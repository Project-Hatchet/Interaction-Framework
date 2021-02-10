/*
 * vxf_core_fnc_perSecond
 *
 * Function will run relevante modules' per second functions
 *
 * Params: array[array[(object) vehicle], (scalar)pfhId]
 * Returns: nothing
 *
 * Author: Yax
 */
params ["_args", "_pfhId"];
_args params ["_vehicle"];

//shutdown conditions
if (
  (vehicle player != _vehicle) ||
  (!alive player) ||
  (!alive _vehicle)
) exitWith {
  [_pfhId] call CBA_fnc_removePerFrameHandler;
  vxf_perSecondHandler = nil;
};

if (vxf_paused) exitWith {};

private _modules = (_vehicle getVariable ["vxf_modules", []]);
[_vehicle, _modules] spawn {
  params ["_vehicle", "_modules"];
  private _moduleDelay = 1 / ((count _modules) + 1);
  private ["_func"];
  { //forEach vehicle vxf_modules
    sleep _moduleDelay;
    if (_x # 1) then {
      _func = missionNameSpace getVariable (_x # 4);
      if (!isNil {_func}) then {[_vehicle] call _func;};
    };
  } forEach _modules;
};
