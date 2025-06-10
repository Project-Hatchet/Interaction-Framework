/*
 * hct_util_fnc_pidReset
 *
 * Resets a PiD controller
 *
 * params: (array)[(SCALAR) proportional, (SCALAR) integral, (SCALAR) derivative]
 *
 * returns: (bool) success
 */

params ["_vehicle", "_name"];

if (isNil "_vehicle" || _name == "") exitWith {};

private _pid = _vehicle getVariable [format ["hct_pid_%1", _name], nil];
if (isNil "_pid") exitWith {};

_pid set [3, 0];
_pid set [4, 0];
_vehicle setVariable [format ["hct_pid_%1", _name], _pid];
