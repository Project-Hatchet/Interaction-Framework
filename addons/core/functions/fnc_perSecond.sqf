#include "script_component.hpp"
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
  (vehicle hct_player != _vehicle) ||
  (!alive hct_player) ||
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
    if (_x # MODULEINDEX_STARTUP) then {
      _func = missionNamespace getVariable (_x # MODULEINDEX_PERSECOND);
      if (!isNil {_func}) then {[_vehicle] call _func;};
    };
  } forEach _modules;
};
