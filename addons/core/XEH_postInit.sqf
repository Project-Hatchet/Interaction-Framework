#include "script_component.hpp"

["unit", {
  vxf_player = (_this select 0);
}, true] call CBA_fnc_addPlayerEventHandler;

["vehicle", FUNC(handleVehicleChanged), true] call CBA_fnc_addPlayerEventHandler;
["turret", {
  [vxf_player, vehicle vxf_player] call FUNC(handleVehicleChanged)
}, true] call CBA_fnc_addPlayerEventHandler;
