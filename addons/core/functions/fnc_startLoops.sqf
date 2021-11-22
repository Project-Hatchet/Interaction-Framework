#include "script_component.hpp"
/*
 * htf_core_fnc_startLoops
 *
 * starts the per per frameHandlers and the draw3D eventHandler
 *
 * Params: ARRAY[(object) vehicle]
 * Returns: nil
 *
 * Author: Yax
 */

params ["_vehicle"];

private _vehicleConfig = _vehicle getVariable QRVAR(config);

// set up draw3D handler
if (isClass (_vehicleConfig >> "interaction")) then {
  [_vehicle, "interaction"] call FUNC(load);
};

// set up perFrameHandler
if (isNil QGVAR(perFrameHandler)) then {
  GVAR(perFrameHandler) = [FUNC(perFrame), 0, [_vehicle, cba_missionTime]] call CBA_fnc_addPerFrameHandler;
};

// set up perSecondHandler for once per second
if (isNil QGVAR(perSecondHandler)) then {
  GVAR(perSecondHandler) = [FUNC(perSecond), 1, [_vehicle]] call CBA_fnc_addPerFrameHandler;
};
