#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_knobAnimate
 *
 * interaction button animate knob scrollwheel functionality
 */

params ["_vehicle", "_animDirection", "_knobConfig"];
_knobConfig params KNOBPARAMS;
diag_log format ["%2: knob animate %1", _name, time];

if (isNil {_vehicle getVariable "vxf_interaction"}) exitWith {false};
if (!isNil QGVAR(knobHolding) && { GVAR(knobHolding) # 0 != _animation }) exitWith {false};

private _animationPhase = (_vehicle animationPhase _animation);
private _base = _vehicle getVariable [("knob_" + _animation), _animationPhase];
private _endPoint = _base + (_scrollIncrement * _animDirection);
_endPoint = _endPoint min (_animLimits # 1) max (_animLimits # 0);
_vehicle setVariable [("knob_" + _animation), _endPoint];
_vehicle animateSource [_animation, _endPoint, _animSpeed];
GVAR(knobHolding) = GVAR(currentButton);

GVAR(currentButton) PARAMS;

//[] spawn {
//  showCommandingMenu "RscMainMenu";
//  showCommandingMenu "";
//};

if !(_vehicle call compile _interactCondition) exitWith {};
if (_animation in vxf_animating_keys) exitWith {false};

[_vehicle] call _dragStart;
[_vehicle, _position, 1, name ace_player] call FUNC(pointNetSend);
vxf_animating_keys pushBack _animation;
