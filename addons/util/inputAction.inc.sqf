// Add more utility for base game inputs https://community.bistudio.com/wiki/inputAction/actions

// Salute in vehicle
addUserActionEventHandler ["Salute", "Activate", {
  if (isNull objectParent hct_player) exitWith {};
  hct_player switchGesture ["hct_util_salute", 0, 0];
}];

// Deploy Countermeasures from other turret seats
addUserActionEventHandler ["launchCM", "Activate", {
  if ((hct_vehicle unitTurret hct_player) isEqualTo []) exitWith {};
  [hct_vehicle] call hct_util_fnc_deployCountermeasures;
}];

// Zoom turret from internal view for MFDs/PiP displays
addUserActionEventHandler ["zoomIn", "Activate", {
  if (cameraView != "INTERNAL") exitWith {};
  [hct_vehicle unitTurret hct_player, 1] call hct_util_fnc_zoomTurret;
}];
addUserActionEventHandler ["zoomOut", "Activate", {
  if (cameraView != "INTERNAL") exitWith {};
  [hct_vehicle unitTurret hct_player, -1] call hct_util_fnc_zoomTurret;
}];
