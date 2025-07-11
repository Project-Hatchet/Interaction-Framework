/*
 * hct_interaction_fnc_pointNetSend
 *
 * sends pointing positions
 *
 * params (array)[(object) vehicle, (positionModel) pointPos, (SCALAR) icon index, (string) label]
 */

params ["_vehicle", "_pointPos", "_iconIndex", "_label"];

if(hct_interaction_pointing) then {
  [_pointPos, _iconIndex, _label] remoteExecCall ["hct_interaction_fnc_pointNetReceive", crew _vehicle];
};
