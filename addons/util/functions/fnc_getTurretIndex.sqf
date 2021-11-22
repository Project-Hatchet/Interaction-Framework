#include "script_component.hpp"
/*
 * Author: commy2
 * Get the turret index of a units current turret.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Turret Index <ARRAY>
 *
 * Example:
 * [htf_player] call htf_util_fnc_getTurretIndex
 *
 * Public: Yes
 */

params [["_unit", objNull, [objNull]]];

private _vehicle = vehicle _unit;
if (_unit == _vehicle) exitWith {[]};

scopeName "main";

{
    if (_unit == (_vehicle turretUnit _x)) then {_x breakOut "main"};
    nil
} count allTurrets [_vehicle, true];

[]
