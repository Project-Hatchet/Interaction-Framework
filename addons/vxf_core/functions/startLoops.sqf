/*
 * vxf_core_fnc_startLoops
 *
 * starts the per per frameHandlers and the draw3D eventHandler
 *
 * Params: ARRAY[(object) vehicle]
 * Returns: nil
 *
 * Author: Yax
 */

params ["_vehicle"];

private _vehicleConfig = _vehicle getVariable "vxf_config";

//set up draw3D handler
if (isClass (_vehicleConfig >> "interaction")) then {
  [_vehicle, "interaction"] call vxf_core_fnc_load;
};

//set up perFrameHandler
if (isNil "vxf_perFrameHandler") then {
  vxf_perFrameHandler = [vxf_core_fnc_perFrame, 0, [_vehicle, cba_missionTime]] call CBA_fnc_addPerFrameHandler;
};

//set up perSecondHandler for once per second
if (isNil "vxf_perSecondHandler") then {
  vxf_perSecondHandler = [vxf_core_fnc_perSecond, 1, [_vehicle]] call CBA_fnc_addPerFrameHandler;
};
