/*
 * hct_interaction_fnc_drag
 *
 * interaction button knob drag
 */

#include "script_component.hpp"

params ["_vehicle"];

hct_interaction_currentButton PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: dragging %1", _name, time];

if (_positionType == "anim") then {
 _position = _vehicle selectionPosition _position;
};
private _positionWorld = _vehicle modelToWorldVisual _position;
private _screenPos = worldToScreen _positionWorld;
// make sure the position is on the screen
if (count _screenPos != 2) exitWith {};

if (_animation != "") then {
  private _verticalDistance = 0.5 - (_screenPos # 1);
  //systemchat str (_verticalDistance / _dragRange) * _animRange;
  //systemChat str [abs _verticalDistance, abs hct_interaction_dragging_lastDragDistance, abs (abs hct_interaction_dragging_lastDragDistance - abs _verticalDistance)];
  if(abs (abs hct_interaction_dragging_lastDragDistance - abs _verticalDistance) > 0.02) then {
    if (hct_interactionShowDebugMessages) then {systemChat str _verticalDistance;};
    private _animRange = (_animLimits # 0) - (_animLimits # 1);
    hct_interaction_dragging_lastDragDistance = _verticalDistance;
    private _dragEndPoint = hct_interaction_dragging_startAnimPhase + ((_verticalDistance / _dragRange) * _animRange);
    _dragEndPoint = _dragEndPoint min (_animLimits # 1) max (_animLimits # 0);
    _vehicle animateSource [_animation, _dragEndPoint, 10];
    [_vehicle, _animation] call _dragging;
  };
};

if (_animationH != "") then {
  private _horizontalDistance = 0.5 - (_screenPos # 0);
  if(abs (abs hct_interaction_dragging_lastDragDistanceH - abs _horizontalDistance) > 0.02) then {
    if (hct_interactionShowDebugMessages) then {systemChat str _horizontalDistance;};
    private _animRange = (_animLimitsH # 0) - (_animLimitsH # 1);
    hct_interaction_dragging_lastDragDistanceH = _horizontalDistance;
    private _dragEndPoint = hct_interaction_dragging_startAnimPhaseH + ((_horizontalDistance / _dragRange) * _animRange);
    _dragEndPoint = _dragEndPoint min (_animLimitsH # 1) max (_animLimitsH # 0);
    _vehicle animateSource [_animationH, _dragEndPoint, 10];
    [_vehicle, _animationH] call _dragging;
  };
};
