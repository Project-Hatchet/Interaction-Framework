#include "script_component.hpp"
/*
 * vxf_interaction_fnc_perFrame
 *
 * Runs per frame for interaction, handles button holding code
 *
 * Params: array[(object) vehicle, (scalar) frame time]
 */

params ["_vehicle", "_frameTime"];

if !(isNil QGVAR(buttonHoldCode)) then {
  _this call GVAR(buttonHoldCode);
};

GVAR(buttonRadius) = (call cba_fnc_getFov # 1);
