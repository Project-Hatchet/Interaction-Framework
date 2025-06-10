/*
 * hct_interaction_fnc_pointCalculate
 *
 * calculates pointing position and sends it to other crew
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

hct_interaction_pointStart = false;

private _eye = eyePos hct_player;
private _visualDiff = getPosVisual hct_player vectorDiff getPos hct_player;
_eye = _eye vectorAdd _visualDiff;
private _beginVec = (vectorNormalized (getCameraViewDirection hct_player)) vectorMultiply 0.5;
private _begin = _eye vectorAdd _beginVec;
private _endVec = (vectorNormalized (getCameraViewDirection hct_player)) vectorMultiply 5;
private _end = _eye vectorAdd _endVec;
private _intersections = lineIntersectsSurfaces [_begin, _end, hct_player, objNull, true, 1, "FIRE", "VIEW"];
private _keyDownPos = if(count _intersections > 0) then {
  _intersections # 0 # 0
} else {
  (eyePos hct_player vectorAdd _endVec)
};

if(!isNil {_keyDownPos}) then {
  private _pointPos = _vehicle worldToModelVisual ASLToAGL _keyDownPos;
  [_vehicle, _pointPos, 0, name hct_player] call hct_interaction_fnc_pointNetSend;
};
