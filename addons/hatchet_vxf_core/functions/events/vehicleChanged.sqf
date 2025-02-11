/*
 * vxf_core_fnc_vehicleChanged
 *
 * Function is triggered by cba vehicleChanged eventhandler
 * when called, it will check if the vehicle has any vxf config,
 * and if relevant, set up the functions for it
 *
 * Params: Array[(object) caller, (object) newVehicle]
 * Returns: nil
 *
 * Author: Yax
 */

params ["_caller", "_newVehicle"];

if (isNil "_caller" || isNil "_newVehicle") exitWith {};
if (_caller !=player) exitWith {};
if (!(isNil "vxf_vehicle")) then {[vxf_vehicle] call vxf_core_fnc_shutDownAll;};

private _isVxfSetup = [_newVehicle] call vxf_core_fnc_getVehicleConfig;

//end the function if the vehicle isn't compatible
if (!_isVxfSetup) exitWith {
  _newVehicle setVariable ["vxf_modules", nil];
};

[_newVehicle] call vxf_core_fnc_loadAll;
[_newVehicle] call vxf_core_fnc_startLoops;
vxf_vehicle = _newVehicle;

/*vxf_interaction_vehicleSwitchedEH = ["turret", {
  [player, vehicle player] call vxf_core_fnc_vehicleChanged;
}, true] call CBA_fnc_addPlayerEventHandler; */