/*
 * hct_interaction_fnc_Draw3D
 *
 * runs the Draw3D eventhandler code to check for interaction
 *
 */

#include "script_component.hpp"

private _vehicle = vehicle hct_player;

if (isGamePaused || {!isGameFocused}) exitWith {};
if (cameraView != "INTERNAL") exitWith {
  with uiNamespace do {
    ctrlDelete	hct_cursor_ctrl;
    hct_cursor_ctrl = nil;
  };
};
if (!isNull curatorCamera) exitWith {};
if (!isNil {uiNamespace getVariable "BIS_fnc_camera_display"}) exitWith {};

if (uiNamespace getVariable ["hct_interaction_mouseBlocker", false]) then {
  _this call hct_interaction_fnc_handleMouseBlocker;
};

if (hct_interaction_updateIndex >= hct_interaction_updateEvery && !hct_interaction_dragging && !hct_interaction_buttonHolding) then {
  hct_interaction_updateIndex = 0;
  private _result = nil;
  { // forEach (_vehicle getVariable ["hct_interaction", []])
    _result = _x call hct_interaction_fnc_checkInteraction;
    if (!isNil "_result") exitWith {};
  } forEach (_vehicle getVariable ["hct_interaction", []]);

  hct_interaction_currentButton = _result;
};
hct_interaction_updateIndex = hct_interaction_updateIndex + 1;

_this call hct_interaction_fnc_drawLabel;

if (hct_interaction_pointStart) then {
  [_vehicle] call hct_interaction_fnc_pointCalculate;
};
[_vehicle] call hct_interaction_fnc_pointDraw;

if (!isNil "hct_interaction_knobHolding" && !hct_interaction_dragging) then {
  hct_interaction_knobHolding PARAMS;
  _knobConfig params KNOBPARAMS;
  private _animationPhase = _vehicle animationPhase _animation;
  private _animationEnd =_vehicle getVariable ["knob_" + _animation, _animationPhase];
  if (
    (_animationPhase > _animationEnd - 0.02) &&
    (_animationPhase < _animationEnd + 0.02)
  ) then {
    hct_interaction_knobHolding = nil;
    [_vehicle, _animationPhase] call _dragStop;
    _vehicle setVariable [("knob_" + _animation), nil];
    hct_animating_keys deleteAt (hct_animating_keys find _animation);
  } else {
    [_vehicle, _animationPhase] call _dragging;
  };
};

private ["_func"];
{ //forEach vehicle hct_modules
  if (_x # 1) then {
    _func = missionNamespace getVariable (_x # 6);
    if (!isNil {_func}) then {[_vehicle, _frameTime] call _func;};
  };
} forEach (_vehicle getVariable ["hct_modules", []]);
