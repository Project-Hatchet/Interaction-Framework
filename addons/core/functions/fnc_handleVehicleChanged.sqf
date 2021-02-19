#include "script_component.hpp"
/*
 * hatchet_core_fnc_handleVehicleChanged
 *
 * Function is triggered by cba vehicleChanged eventhandler
 * when called, it will check if the vehicle has any Hatchet config,
 * and if relevant, set up the functions for it
 *
 * Params: Array[(object) caller, (object) newVehicle]
 * Returns: nil
 *
 * Author: Yax
 */

params ["_caller", "_newVehicle"];

if (isNil "_caller" || isNil "_newVehicle") exitWith {};
if !(_caller isEqualTo hatchet_player) exitWith {};

if !(isNil QGVAR(vehicle)) then {
	[GVAR(vehicle)] call FUNC(shutDownAll);
};

private _isHatchetSetup = [_newVehicle] call FUNC(getVehicleConfig);

//end the function if the vehicle isn't compatible
if !(_isHatchetSetup) exitWith {
  _newVehicle setVariable [QGVAR(modules), nil];
};

[_newVehicle] call FUNC(loadAll);
[_newVehicle] call FUNC(startLoops);
GVAR(vehicle) = _newVehicle;

GVAR(vehicleSwitchedEH) = _newVehicle addEventHandler ["SeatSwitched", {
  if ((_this # 1) isEqualTo hatchet_player) then {
	  [hatchet_player, vehicle hatchet_player] call FUNC(handleVehicleChanged);
	};
}];
