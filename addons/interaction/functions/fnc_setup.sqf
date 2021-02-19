#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_setup
 *
 * starts the interaction system
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

_this call FUNC(loadAll);

if (isNil {GVAR(drawHandler)}) then {
  GVAR(drawHandler) = addmissioneventhandler ["Draw3d", FUNC(draw3D)];
};

private _vehicleConfig = _vehicle getVariable EGVAR(core,config);
QGVAR(crosshair) = (getNumber (_vehicleConfig >> "interaction" >> "crossHair") == 1);

vxf_animating_keys = [];
GVAR(cursorPos) = [0.5,0.5];

true
