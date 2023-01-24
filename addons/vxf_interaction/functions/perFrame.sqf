/*
 * vxf_interaction_fnc_perFrame
 *
 * Runs per frame for interaction, handles button holding code
 *
 * Params: array[(object) vehicle, (scalar) frame time]
 */

#include "interactDefines.hpp"

params ["_vehicle", "_frameTime"];

if (!isNil "vxf_interaction_buttonHoldCode") then {
  _this call vxf_interaction_buttonHoldCode;
};

vxf_interaction_buttonRadius = (call cba_fnc_getFov # 1);
