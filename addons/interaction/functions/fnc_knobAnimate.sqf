/*
 * hct_interaction_fnc_knobAnimate
 *
 * interaction button animate knob scrollwheel functionality
 */

#include "script_component.hpp"

params ["_vehicle", "_animDirection", "_knobConfig"];
_knobConfig params KNOBPARAMS;

if (isNil{_vehicle getVariable "hct_interaction"}) exitWith {false};
// lazy second operand: knobHolding is nil until a knob has been used this
// session, and non-lazy && evaluated the index anyway (script error on the
// first keybind-driven knob use)
// element 11 of a held button is its knob config, whose first entry is the
// animation name (element 0 is the interaction's class name)
if (!isNil "hct_interaction_knobHolding" && {((hct_interaction_knobHolding param [11, []]) param [0, ""]) != _animation}) exitWith {false};

hct_interaction_currentButton PARAMS;

if (_animation in hct_animating_keys) exitWith {false};
if(!(_vehicle call compile _interactCondition)) exitWith {};

private _animationPhase = (_vehicle animationPhase _animation);
private _base = _vehicle getVariable [("knob_" + _animation), _animationPhase];
private _endPoint = _base + (_scrollIncrement * _animDirection);
_endPoint = _endPoint min (_animLimits # 1) max (_animLimits # 0);
_vehicle setVariable [("knob_" + _animation), _endPoint];
_vehicle animateSource [_animation, _endPoint, _animSpeed];
hct_interaction_knobHolding = hct_interaction_currentButton;

[] call hct_interaction_fnc_attemptCloseActionMenu;

[_vehicle] call _dragStart;
[_vehicle, _position, 1, name hct_player] call hct_interaction_fnc_pointNetSend;
hct_animating_keys pushBack _animation;
