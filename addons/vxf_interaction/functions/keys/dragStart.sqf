/*
 * vxf_interaction_fnc_dragStart
 *
 * interaction button knob drag
 */

#include "../interactDefines.hpp"

params ["_vehicle"];

vxf_interaction_currentButton PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: drag start %1", _name, time];

if (isNil{_vehicle getVariable "vxf_interaction"}) exitWith {false};
if (!isNil "vxf_interaction_knobHolding" && vxf_interaction_knobHolding # 0 != _animation) exitWith {false};

vxf_interaction_knobHolding = vxf_interaction_currentButton;
vxf_interaction_dragging = true;
vxf_interaction_dragging_startAnimPhase = _vehicle animationPhase _animation;
vxf_interaction_dragging_lastDragDistance = 0;
[_vehicle, vxf_interaction_dragging_startAnimPhase] call _dragStart;
