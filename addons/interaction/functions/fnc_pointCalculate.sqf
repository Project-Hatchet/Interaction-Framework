#include "script_component.hpp"
/*
 * vxf_interaction_fnc_pointCalculate
 *
 * calculates pointing position and sends it to other crew
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

GVAR(pointStart) = false;

private _eye = eyePos vxf_player;
private _visualDiff = getPosVisual vxf_player vectorDiff getPos vxf_player;
_eye = _eye vectorAdd _visualDiff;
private _beginVec = (vectorNormalized (getCameraViewDirection vxf_player)) vectorMultiply 0.5;
private _begin = _eye vectorAdd _beginVec;
private _endVec = (vectorNormalized (getCameraViewDirection vxf_player)) vectorMultiply 5;
private _end = _eye vectorAdd _endVec;
private _intersections = lineIntersectsSurfaces [_begin, _end, vxf_player, objNull, true, 1, "FIRE", "VIEW"];
private _keyDownPos = if (count _intersections > 0) then {
  _intersections # 0 # 0
} else {
  (eyePos vxf_player vectorAdd _endVec)
};

if !(isNil {_keyDownPos}) then {
  private _pointPos = _vehicle worldToModelVisual ASLtoAGL _keyDownPos;
  [_vehicle, _pointPos, 0, name vxf_player] call FUNC(pointNetSend);
};
