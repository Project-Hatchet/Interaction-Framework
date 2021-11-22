#include "script_component.hpp"
/*
 * htf_util_fnc_pidReset
 *
 * Resets a PiD controller
 *
 * params: (array)[(SCALAR) proportional, (SCALAR) integral, (SCALAR) derivative]
 *
 * returns: (bool) success
 */

params ["_vehicle", "_name"];

if (isNil "_vehicle" || _name == "") exitWith {};

private _pid = _vehicle getVariable [PID(_name), nil];
if (isNil "_pid") exitWith {};

_pid set [3, 0];
_pid set [4, 0];
_vehicle setVariable [PID(_name), _pid];
