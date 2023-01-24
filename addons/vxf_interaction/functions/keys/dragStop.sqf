/*
 * vxf_interaction_fnc_dragStop
 */

#include "../interactDefines.hpp"

params ["_vehicle"];

vxf_interaction_currentButton PARAMS;
_knobConfig params KNOBPARAMS;
diag_log format ["%2: drag stop %1", _name, time];

vxf_interaction_dragging = false;
vxf_interaction_knobHolding = nil;
[_vehicle, _vehicle animationPhase _animation] call _dragStop;
