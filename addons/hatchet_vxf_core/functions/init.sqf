["vehicle", {[ace_player, vehicle ace_player] call vxf_core_fnc_vehicleChanged}, true] call CBA_fnc_addPlayerEventHandler;

vxf_interaction_vehicleSwitchedEH = ["turret", {
  [ace_player, vehicle ace_player] call vxf_core_fnc_vehicleChanged;
}, true] call CBA_fnc_addPlayerEventHandler;

vxf_paused = false;
