/*
 * hct_interaction_fnc_perFrame
 *
 * Runs per frame for interaction, handles button holding code
 *
 * Params: array[(object) vehicle, (scalar) frame time]
 */

#include "interactDefines.hpp"

params ["_vehicle", "_frameTime"];

if (!isNil "hct_interaction_buttonHoldCode") then {
  _this call hct_interaction_buttonHoldCode;
};

hct_interaction_buttonRadius = (call cba_fnc_getFov # 1);

if (hct_interaction_trackIR_interaction_cursor) then {
    private _y = (inputAction "aimDown") - (inputAction "aimUp");
    private _x = (inputAction "aimRight") - (inputAction "aimLeft");
    if (hct_interaction_trackIR_interaction_cursor_invert) then {
      _y = -_y;
    };

    hct_interaction_cursorPos params ["_curX", "_curY"];
    if (abs _x < 0.02) then { _x = 0; };
    if (abs _y < 0.02) then { _y = 0; };
    hct_interaction_cursorPos = [
        (_curX + (_x * hct_interaction_trackIR_interaction_cursorSensitivity * (_frameTime / 4))) max safeZoneX min (safeZoneX + safeZoneW),
        (_curY + (_y * hct_interaction_trackIR_interaction_cursorSensitivity * (_frameTime / 4))) max safeZoneY min (safeZoneY + safeZoneH)
    ];
};
