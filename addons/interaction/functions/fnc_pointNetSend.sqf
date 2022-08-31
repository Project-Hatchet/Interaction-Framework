#include "script_component.hpp"
/*
 * vxf_interaction_fnc_pointNetSend
 *
 * sends pointing positions
 *
 * params (array)[(object) vehicle, (positionModel) pointPos, (SCALAR) icon index, (string) label]
 */

params ["_vehicle", "_pointPos", "_iconIndex", "_label"];

if (GVAR(pointingEnabled)) then {
  [_pointPos, _iconIndex, _label] remoteExecCall [QFUNC(pointNetReceive), crew _vehicle];
};
