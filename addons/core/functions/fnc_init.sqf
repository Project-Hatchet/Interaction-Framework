["vehicle", {[hct_player, vehicle hct_player] call hct_core_fnc_vehicleChanged}, true] call CBA_fnc_addPlayerEventHandler;

hct_interaction_vehicleSwitchedEH = ["turret", {
  [hct_player, vehicle hct_player] call hct_core_fnc_vehicleChanged;
}, true] call CBA_fnc_addPlayerEventHandler;

hct_paused = false;
