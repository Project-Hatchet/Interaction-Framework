/*
 * vxf_interaction_fnc_pointStart
 *
 * used to point at something inside a vehicle, will draw a marker for other crew
 * this function only starts pointing, actual pointing code is handled inside draw3D
 *
 */

private _vehicle = vehicle player;
if (isNil{_vehicle getVariable "vxf_interaction"}) exitWith {false};

vxf_interaction_pointStart = true;
true
