#include "script_component.hpp"
/*
 * Author: Ampersand
 * Change optics mode of turret
 *
 * Arguments:
 * 0: Turret <ARRAY>
 * 1: Increment <NUMBER>
 * 2: Vehicle <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [[0], 1] call hct_util_fnc_zoomTurret // Main Turret zoom in 1 step
 */

params [["_turret", [0]], ["_increment", 0], ["_vehicle", hct_vehicle]];

if (isNil _vehicle || {isNull _vehicle}) exitWith {};

if (_turret isEqualTo [-1]) exitWith {
    _vehicle setPilotCameraOpticsMode ((getPilotCameraOpticsMode _vehicle) + _increment);
};

_vehicle setTurretOpticsMode [_turret, (_vehicle getTurretOpticsMode _turret) + _increment];
