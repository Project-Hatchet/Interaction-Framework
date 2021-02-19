#include "script_component.hpp"
/*
 * hatchet_util_fnc_pidRun
 *
 * Runs a pid controller update
 *
 * params: (array)[(object) vehicle, (string) name, (SCALAR) frameTime, (SCALAR) desired value, (SCALAR) actual value]
 *
 */

params ["_vehicle", "_name", "_frameTime", "_desiredValue", "_actualValue"];

private _pid = _vehicle getVariable [PID(_name), nil];
if (isNil "_pid") exitWith {0};

_pid params ["_kp", "_ki", "_kd", "_priorError", "_integral"];

private _error = _desiredValue - _actualValue;
_integral = _integral + (_error * _frameTime);
private _derivative = (_error - _priorError) / _frameTime;
private _output = _kp * _error + _ki * _integral + _kd * _derivative;
_priorError = _error;

_vehicle setVariable [PID(_name), [_kp, _ki, _kd, _priorError, _integral]];

_output
