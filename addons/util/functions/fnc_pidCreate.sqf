#include "script_component.hpp"
/*
 * vxf_util_fnc_pidCreate
 *
 * Creates a new PiD controller
 *
 * params: (array)[(SCALAR) proportional, (SCALAR) integral, (SCALAR) derivative]
 *
 * returns: (bool) success
 */

params ["_vehicle", "_name", "_kp", "_ki", "_kd"];

if (isNil "_vehicle" || _name == "") exitWith {false};

_vehicle setVariable [PID(_name), [_kp, _ki, _kd, 0, 0]];

true
