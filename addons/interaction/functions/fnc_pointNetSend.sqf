#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_pointNetSend
 *
 * sends pointing positions
 *
 * params (array)[(object) vehicle, (positionModel) pointPos, (SCALAR) icon index, (string) label]
 */

params ["_vehicle", "_pointPos", "_iconIndex", "_label"];

if (vxf_uh60_interaction_pointing) then {
  [_pointPos, _iconIndex, _label] remoteExecCall [QFUNC(pointNetReceive), crew _vehicle];
};
