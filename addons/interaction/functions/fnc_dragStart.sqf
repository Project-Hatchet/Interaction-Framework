/*
 * hct_interaction_fnc_dragStart
 *
 * interaction button knob drag
 */

#include "script_component.hpp"

params ["_vehicle"];

hct_interaction_currentButton PARAMS;
_knobConfig params KNOBPARAMS;

if (isNil{_vehicle getVariable "hct_interaction"}) exitWith {false};
// lazy second operand: knobHolding is nil until a knob has been used this
// session (see fnc_knobAnimate)
if (!isNil "hct_interaction_knobHolding" && {hct_interaction_knobHolding # 0 != _animation}) exitWith {false};

hct_interaction_knobHolding = hct_interaction_currentButton;
hct_interaction_dragging = true;
hct_interaction_dragging_startAnimPhase = _vehicle animationPhase _animation;
hct_interaction_dragging_startAnimPhaseH = _vehicle animationPhase _animationH;
hct_interaction_dragging_lastDragDistance = 0;
hct_interaction_dragging_lastDragDistanceH = 0;
[_vehicle, hct_interaction_dragging_startAnimPhase, hct_interaction_dragging_startAnimPhaseH] call _dragStart;
