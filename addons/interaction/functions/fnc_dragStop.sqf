#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_dragStop
 */

params ["_vehicle"];

GVAR(currentButton) PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: drag stop %1", _name, time];

GVAR(dragging) = false;
GVAR(knobHolding) = nil;
[_vehicle, _vehicle animationPhase _animation] call _dragStop;
