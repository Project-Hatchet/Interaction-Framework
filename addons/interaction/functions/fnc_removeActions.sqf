#include "script_component.hpp"
/*
 * htf_interaction_fnc_removeActions
 */

{
  htf_player removeAction _x;
} forEach GVAR(actionIds);

GVAR(actionIds) = [];
GVAR(actionIgnore) = [];
