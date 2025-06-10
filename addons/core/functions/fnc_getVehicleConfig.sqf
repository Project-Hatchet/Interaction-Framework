/*
 * hct_core_fnc_getVehicleConfig
 *
 * Function will look through the cfgVehicles for the vehicle
 * and look for relevant hct config subclasses, when it finds them
 * the most relevant one will be assigned to the vehicle's hct_config variable
 *
 * Params: (object) vehicle
 * Returns: (bool) success
 *
 * Author: Yax
 */

params ["_vehicle"];

private _configFound = false;
private _configSources = [];

_vehicle setVariable ["hct_config", nil];
private _turretIndex = [ace_player] call ace_common_fnc_getTurretIndex;

if(ace_player == driver _vehicle) then {
  _configSources pushBack "hct_driver";
};

private _copilotTurretIndex = [_vehicle] call ace_common_fnc_getTurretCopilot;
if((count _copilotTurretIndex) > 0 && (count _turretIndex) > 0 && {(_turretIndex # 0) == (_copilotTurretIndex # 0)}) then {
  _configSources pushBack "hct_copilot";
};

if(count _turretIndex > 0) then {
  _configSources pushBack format["hct_turret_%1",(_turretIndex # 0)];
};

if(ace_player == gunner _vehicle) then {
  _configSources pushBack "hct_gunner";
};

if(_vehicle getCargoIndex ace_player > -1) then {
  _configSources pushBack "hct_cargo";
};

_configSources pushBack "hct";

{
  private _config = (configFile >> "cfgVehicles" >> (typeOf _vehicle) >> _x);
  if(isClass _config) exitWith {
    _configFound = true;
    //if there was already a config present, a seat change happened, so do a shutdown of old systems
    //if (!isNil {_vehicle getVariable "hct_config"}) then {
    //  [_vehicle] call hct_core_fnc_shutDown;
    //};
    _vehicle setVariable ["hct_config", _config];
    _vehicle setVariable ["hct_projectPrefix", getText (_config >> "projectPrefix")];
  };
}forEach _configSources;

_configFound
