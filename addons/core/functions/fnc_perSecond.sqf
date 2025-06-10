/*
 * hct_core_fnc_perSecond
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
  (vehicle ace_player != _vehicle) ||
  (!alive ace_player) ||
  (!alive _vehicle)
) exitWith {
  [_pfhId] call CBA_fnc_removePerFrameHandler;
  hct_perSecondHandler = nil;
};

if (hct_paused) exitWith {};

private _modules = (_vehicle getVariable ["hct_modules", []]);
[_vehicle, _modules] spawn {
  params ["_vehicle", "_modules"];
  private _moduleDelay = 1 / ((count _modules) + 1);
  private ["_func"];
  { //forEach vehicle hct_modules
    sleep _moduleDelay;
    if (_x # 1) then {
      _func = missionNamespace getVariable (_x # 4);
      if (!isNil {_func}) then {[_vehicle] call _func;};
    };
  } forEach _modules;
};
