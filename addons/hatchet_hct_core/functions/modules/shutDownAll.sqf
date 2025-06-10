/*
 * hct_core_fnc_setup
 *
 * Reads out relevant vehicle modules from config and stores them in vehicle variables
 *
 * Params: array[array[(object) vehicle]
 * Returns: nothing
 *
 * Author: Yax
 */
params ["_vehicle"];

if (isNil "_vehicle") then {_vehicle = hct_vehicle};

hct_perFrameHandler call CBA_fnc_removePerFrameHandler;
hct_perSecondHandler call CBA_fnc_removePerFrameHandler;
hct_perFixedHandler call CBA_fnc_removePerFrameHandler;
if (!isNil "hct_drawHandler") then {
  removeMissionEventHandler ["Draw3d",hct_drawHandler];
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
  if (_x # 1) then {
    _func = missionNameSpace getVariable (_x # 5);
    if (!isNil {_func}) then {[_vehicle] call _func;};
  };
  _x set [1, false];
} forEach (_vehicle getVariable ["hct_modules", []]);

//["turret", hct_interaction_vehicleSwitchedEH] call CBA_fnc_removePlayerEventHandler;
hct_vehicle = nil;
