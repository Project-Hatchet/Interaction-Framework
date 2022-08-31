#include "script_component.hpp"
/*
 * vxf_interaction_fnc_draw3D
 *
 * runs the draw3D eventhandler code to check for interaction
 *
 */

private _vehicle = vehicle vxf_player;

if !(cameraView isEqualTo "INTERNAL") exitWith {};
if !(isNull curatorCamera) exitWith {};

if (GVAR(updateIndex) >= GVAR(updateEvery) && !GVAR(dragging) && !GVAR(buttonHolding)) then {
  GVAR(updateIndex) = 0;
  private _result = nil;
  { // forEach (_vehicle getVariable [QGVAR(points), []])
    _result = _x call FUNC(checkInteraction);
    if (!isNil "_result") exitWith {};
  } forEach (_vehicle getVariable [QGVAR(points), []]);

  GVAR(currentButton) = _result;
};
GVAR(updateIndex) = GVAR(updateIndex) + 1;

_this call FUNC(drawLabel);

if (GVAR(crosshair)) then {
  ["<t color='#bae5bb' size = '.5'>+</t>",-1, 0.485, 1, 0, 0, 794] spawn BIS_fnc_dynamicText;
};

if (GVAR(pointStart)) then {
  [_vehicle] call FUNC(pointCalculate);
};
[_vehicle] call FUNC(pointDraw);

if (!isNil QGVAR(knobHolding) && !GVAR(dragging)) then {
  GVAR(knobHolding) PARAMS;
  _knobConfig params KNOBPARAMS;
  private _animationPhase = _vehicle animationPhase _animation;
  private _animationEnd =_vehicle getVariable ["knob_" + _animation, _animationPhase];
  if (
    (_animationPhase > _animationEnd - 0.02) &&
    (_animationPhase < _animationEnd + 0.02)
  ) then {
    GVAR(knobHolding) = nil;
    [_vehicle, _animationPhase] call _dragStop;
    _vehicle setVariable [("knob_" + _animation), nil];
    vxf_animating_keys deleteAt (vxf_animating_keys find _animation);
  } else {
    [_vehicle, _animationPhase] call _dragging;
  };
};
