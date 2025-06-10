/*
 * hct_core_fnc_vehicleChanged
 *
 * Function is triggered by cba vehicleChanged eventhandler
 * when called, it will check if the vehicle has any hct config,
 * and if relevant, set up the functions for it
 *
 * Params: Array[(object) caller, (object) newVehicle]
 * Returns: nil
 *
 * Author: Yax
 */

params ["_caller", "_newVehicle"];

if (isNil "_caller" || isNil "_newVehicle") exitWith {};
if (_caller != hct_player) exitWith {};
if (!(isNil "hct_vehicle")) then {[hct_vehicle] call hct_core_fnc_shutDownAll;};

private _isHCTSetup = [_newVehicle] call hct_core_fnc_getVehicleConfig;

//end the function if the vehicle isn't compatible
if (!_isHCTSetup) exitWith {
  _newVehicle setVariable ["hct_modules", nil];
};

[_newVehicle] call hct_core_fnc_loadAll;
[_newVehicle] call hct_core_fnc_startLoops;
hct_vehicle = _newVehicle;

/*hct_interaction_vehicleSwitchedEH = ["turret", {
  [hct_player, vehicle hct_player] call hct_core_fnc_vehicleChanged;
}, true] call CBA_fnc_addPlayerEventHandler; */
