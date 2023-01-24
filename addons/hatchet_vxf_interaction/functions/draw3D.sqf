/*
 * vxf_interaction_fnc_draw3D
 *
 * runs the draw3D eventhandler code to check for interaction
 *
 */

#include "interactDefines.hpp"

private _vehicle = vehicle player;

if (cameraView != "INTERNAL") exitWith {};
if (!isNull curatorCamera) exitWith {};
if (!isNil {uinamespace getVariable "BIS_fnc_camera_display"}) exitWith {};

if (uiNamespace getVariable ["vxf_interaction_mouseBlocker", false]) then {
  _this call vxf_interaction_fnc_handleMouseBlocker;
};



if (vxf_interaction_updateIndex >= vxf_interaction_updateEvery && !vxf_interaction_dragging && !vxf_interaction_buttonHolding) then {
  vxf_interaction_updateIndex = 0;
  private _result = nil;
  { // forEach (_vehicle getVariable ["vxf_interaction", []])
    _result = _x call vxf_interaction_fnc_checkInteraction;
    if (!isNil "_result") exitWith {};
  } forEach (_vehicle getVariable ["vxf_interaction", []]);

  vxf_interaction_currentButton = _result;
};
vxf_interaction_updateIndex = vxf_interaction_updateIndex + 1;

_this call vxf_interaction_fnc_drawLabel;

if (vxf_interaction_crosshair) then {
  ["<t color='#bae5bb' size = '.5'>+</t>",-1,0.485,1,0,0, 794] spawn BIS_fnc_dynamicText;
};

if (vxf_interaction_pointStart) then {
  [_vehicle] call vxf_interaction_fnc_pointCalculate;
};
[_vehicle] call vxf_interaction_fnc_pointDraw;

if (!isNil "vxf_interaction_knobHolding" && !vxf_interaction_dragging) then {
  vxf_interaction_knobHolding PARAMS;
  _knobConfig params KNOBPARAMS;
  private _animationPhase = _vehicle animationPhase _animation;
  private _animationEnd =_vehicle getVariable ["knob_" + _animation, _animationPhase];
  if (
    (_animationPhase > _animationEnd - 0.02) &&
    (_animationPhase < _animationEnd + 0.02)
  ) then {
    vxf_interaction_knobHolding = nil;
    [_vehicle, _animationPhase] call _dragStop;
    _vehicle setVariable [("knob_" + _animation), nil];
    vxf_animating_keys deleteAt (vxf_animating_keys find _animation);
  } else {
    [_vehicle, _animationPhase] call _dragging;
  };
};
