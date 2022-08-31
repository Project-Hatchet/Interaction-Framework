#include "script_component.hpp"
/*
 * vxf_interaction_fnc_removeActions
 */

{
  vxf_player removeAction _x;
} forEach GVAR(actionIds);

GVAR(actionIds) = [];
GVAR(actionIgnore) = [];
