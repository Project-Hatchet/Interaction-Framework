/*
 * hct_interaction_fnc_dragStop
 */

#include "script_component.hpp"

params ["_vehicle"];

hct_interaction_currentButton PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: drag stop %1", _name, time];

hct_interaction_dragging = false;
hct_interaction_knobHolding = nil;
[_vehicle, _vehicle animationPhase _animation] call _dragStop;
