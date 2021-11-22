#include "script_component.hpp"
/*
 * htf_interaction_fnc_pointStart
 *
 * used to point at something inside a vehicle, will draw a marker for other crew
 * this function only starts pointing, actual pointing code is handled inside draw3D
 *
 */

private _vehicle = vehicle htf_player;
if (isNil{_vehicle getVariable QGVAR(points)}) exitWith {false};

GVAR(pointStart) = true;
true
