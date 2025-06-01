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

if (vxf_interaction_trackIR_interaction_cursor) then {
    private _y = (inputAction "aimDown") - (inputAction "aimUp");
    private _x = (inputAction "aimRight") - (inputAction "aimLeft");

    vxf_interaction_cursorPos params ["_curX", "_curY"];
    if (abs _x < 0.02) then { _x = 0; };
    if (abs _y < 0.02) then { _y = 0; };
    vxf_interaction_cursorPos = [
        (_curX + (_x * vxf_interaction_trackIR_interaction_cursorSensitivity * (_frameTime / 4))) max safeZoneX min (safeZoneX + safeZoneW),
        (_curY + (_y * vxf_interaction_trackIR_interaction_cursorSensitivity * (_frameTime / 4))) max safeZoneY min (safeZoneY + safeZoneH)
    ];
};

// Draw cursor
drawIcon3D [
  vxf_interaction_cursor_shape,
  [1,1,1,1],
  positionCameraToWorld [0,0,0] vectorAdd (screenToWorldDirection vxf_interaction_cursorPos),
  1,1,0,
  ""
];
