/*
 * hct_core_fnc_startLoops
 *
 * starts the per per frameHandlers and the draw3D eventHandler
 *
 * Params: ARRAY[(object) vehicle]
 * Returns: nil
 *
 * Author: Yax
 */

params ["_vehicle"];

private _vehicleConfig = _vehicle getVariable "hct_config";

//set up draw3D handler
if (isClass (_vehicleConfig >> "interaction")) then {
  [_vehicle, "interaction"] call hct_core_fnc_load;
};

//set up perFrameHandler
if (isNil "hct_perFrameHandler") then {
  hct_perFrameHandler = [hct_core_fnc_perFrame, 0, [_vehicle, cba_missionTime]] call CBA_fnc_addPerFrameHandler;
};

//set up perSecondHandler for once per second
if (isNil "hct_perSecondHandler") then {
  hct_perSecondHandler = [hct_core_fnc_perSecond, 1, [_vehicle]] call CBA_fnc_addPerFrameHandler;
};

//set up perFixedHandler for once per fixed interval
if (isNil "hct_perFixedHandler") then {
  hct_perFixedHandler = [hct_core_fnc_perFixed, 0.2, [_vehicle]] call CBA_fnc_addPerFrameHandler;
};
