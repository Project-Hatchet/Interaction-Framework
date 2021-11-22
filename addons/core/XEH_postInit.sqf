#include "script_component.hpp"

["unit", {
  htf_player = (_this select 0);
}, true] call CBA_fnc_addPlayerEventHandler;

["vehicle", FUNC(handleVehicleChanged), true] call CBA_fnc_addPlayerEventHandler;
["turret", {
  [htf_player, vehicle htf_player] call FUNC(handleVehicleChanged)
}, true] call CBA_fnc_addPlayerEventHandler;
