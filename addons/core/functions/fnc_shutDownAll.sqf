#include "script_component.hpp"
/*
 * hct_core_fnc_shutDownAll
 *
 * Stops the loops and the Draw3D handler and shuts down every running module
 *
 * Params: array[array[(object) vehicle]
 * Returns: nothing
 *
 * Author: Yax
 */
params ["_vehicle"];

// both can be nil when a loop shuts itself down after the vehicle change
// handler already ran (death, destroyed vehicle)
if (isNil "_vehicle") then {_vehicle = missionNamespace getVariable ["hct_vehicle", objNull];};

if (!isNil "hct_perFrameHandler") then {hct_perFrameHandler call CBA_fnc_removePerFrameHandler;};
if (!isNil "hct_perSecondHandler") then {hct_perSecondHandler call CBA_fnc_removePerFrameHandler;};
if (!isNil "hct_perFixedHandler") then {hct_perFixedHandler call CBA_fnc_removePerFrameHandler;};
if (!isNil "hct_drawHandler") then {
  removeMissionEventHandler ["Draw3D",hct_drawHandler];
};
hct_perFrameHandler = nil;
hct_perSecondHandler = nil;
hct_perFixedHandler = nil;
hct_drawHandler = nil;

with uiNamespace do {
  ctrlDelete	hct_cursor_ctrl;
  hct_cursor_ctrl = nil;
};


private ["_func"];
{ //forEach vehicle hct_modules
  if (_x # MODULEINDEX_STARTUP) then {
    _func = missionNamespace getVariable (_x # MODULEINDEX_SHUTDOWN);
    if (!isNil {_func}) then {[_vehicle] call _func;};
  };
  _x set [1, false];
} forEach (_vehicle getVariable ["hct_modules", []]);

//["turret", hct_interaction_vehicleSwitchedEH] call CBA_fnc_removePlayerEventHandler;
hct_vehicle = nil;
