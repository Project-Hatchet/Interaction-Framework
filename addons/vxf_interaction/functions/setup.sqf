/*
 * vxf_interaction_fnc_setup
 *
 * starts the interaction system
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

_this call vxf_interaction_fnc_loadAll;

if (isNil{vxf_drawHandler}) then {
  vxf_drawHandler = addmissioneventhandler ["Draw3d",vxf_interaction_fnc_draw3D];
};

private _vehicleConfig = _vehicle getVariable "vxf_config";
vxf_interaction_crosshair =  (getNumber (_vehicleConfig >> "interaction" >> "crossHair") == 1);

vxf_animating_keys = [];
vxf_interaction_cursorPos = [0.5,0.5];

true
