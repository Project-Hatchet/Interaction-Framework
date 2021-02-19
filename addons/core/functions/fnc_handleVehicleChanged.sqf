#include "script_component.hpp"
/*
 * hatchet_core_fnc_handleVehicleChanged
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
if !(_caller isEqualTo ace_player) exitWith {};

if (!(isNil QGVAR(vehicle))) then {
	[GVAR(vehicle)] call FUNC(shutDownAll);
};

private _isVxfSetup = [_newVehicle] call FUNC(getVehicleConfig);

//end the function if the vehicle isn't compatible
if !(_isVxfSetup) exitWith {
  _newVehicle setVariable [QGVAR(modules), nil];
};

[_newVehicle] call FUNC(loadAll);
[_newVehicle] call FUNC(startLoops);
GVAR(vehicle) = _newVehicle;

GVAR(vehicleSwitchedEH) = _newVehicle addEventHandler ["SeatSwitched", {
  if (_this # 1 == ace_player) then {
	  [ace_player, vehicle ace_player] call FUNC(handleVehicleChanged);
	};
}];
