#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_removeActions
 */

{
  hatchet_player removeAction _x;
} forEach GVAR(actionIds);

GVAR(actionIds) = [];
GVAR(actionIgnore) = [];
