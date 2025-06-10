["vehicle", {[ace_player, vehicle ace_player] call hct_core_fnc_vehicleChanged}, true] call CBA_fnc_addPlayerEventHandler;

hct_interaction_vehicleSwitchedEH = ["turret", {
  [ace_player, vehicle ace_player] call hct_core_fnc_vehicleChanged;
}, true] call CBA_fnc_addPlayerEventHandler;

hct_paused = false;
