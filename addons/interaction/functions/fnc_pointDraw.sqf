#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_pointDraw
 *
 * draws pointing positions
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

{
  if (cba_missionTime > (_x # 1) + GVAR(point_lifetime)) then {
    GVAR(point_icons) deleteAt  _forEachIndex;
  } else {
    private _drawPos = if (typeName (_x # 0) == "STRING") then {_vehicle selectionPosition (_x # 0)} else {(_x # 0)};
    drawIcon3D [_x # 2, [1,0,0,1], _vehicle modelToWorldVisual _drawPos, 2, 2, 0, (_x # 3)];
  };
} forEach GVAR(point_icons);
