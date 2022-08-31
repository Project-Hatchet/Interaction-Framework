#include "script_component.hpp"
/*
 * vxf_interaction_fnc_drag
 *
 * interaction button knob drag
 */

params ["_vehicle"];

GVAR(currentButton) PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: dragging %1", _name, time];

if (_positionType isEqualTo "anim") then {
 _position = _vehicle selectionPosition _position;
};
private _positionWorld = _vehicle modelToWorldVisual _position;
private _screenPos = worldToScreen _positionWorld;
// make sure the position is on the screen
if (count _screenPos == 2) then {
 private _verticalDistance = 0.5 - (_screenPos # 1);
 //systemchat str (_verticalDistance / _dragRange) * _animRange;
 //systemChat str [abs _verticalDistance, abs GVAR(dragging_lastDragDistance), abs (abs GVAR(dragging_lastDragDistance) - abs _verticalDistance)];
 if (abs (abs GVAR(dragging_lastDragDistance) - abs _verticalDistance) > 0.02) then {
   systemChat str _verticalDistance;
   private _animRange = (_animLimits # 0) - (_animLimits # 1);
   GVAR(dragging_lastDragDistance) = _verticalDistance;
   private _dragEndPoint = GVAR(dragging_startAnimPhase) + ((_verticalDistance / _dragRange) * _animRange);
   _dragEndPoint = _dragEndPoint min (_animLimits # 1) max (_animLimits # 0);
   _vehicle animateSource [_animation, _dragEndPoint, 10];
   [_vehicle, _animation] call _dragging;
 };
};
