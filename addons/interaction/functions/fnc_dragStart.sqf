#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_dragStart
 *
 * interaction button knob drag
 */

params ["_vehicle"];

GVAR(currentButton) PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: drag start %1", _name, time];

if (isNil{_vehicle getVariable "vxf_interaction"}) exitWith {false};
if (!isNil QGVAR(knobHolding) && { GVAR(knobHolding) # 0 != _animation }) exitWith {false};

GVAR(knobHolding) = GVAR(currentButton);
GVAR(dragging) = true;
GVAR(dragging_startAnimPhase) = _vehicle animationPhase _animation;
GVAR(dragging_lastDragDistance) = 0;
[_vehicle, GVAR(dragging_startAnimPhase)] call _dragStart;
