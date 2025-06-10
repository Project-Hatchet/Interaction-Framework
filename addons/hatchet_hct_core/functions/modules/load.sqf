/*
 * hct_core_fnc_load
 *
 * Loads a single module with default paths
 *
 * Params: array[array[(object) vehicle, (string) module name]
 * Returns: nothing
 *
 * Author: Yax
 */
params ["_vehicle", "_moduleName"];

private _vehicleModuleArray = _vehicle getVariable ["hct_modules", []];

#define HANDLEDEFAULT(VAR,MODULENAME,PATH) private VAR =  format[PATH, MODULENAME];

private _startUp = true;

HANDLEDEFAULT(_setup,_moduleName,"hct_%1_fnc_setup")
HANDLEDEFAULT(_perFrame,_moduleName,"hct_%1_fnc_perFrame")
HANDLEDEFAULT(_perSecond,_moduleName,"hct_%1_fnc_perSecond")
HANDLEDEFAULT(_perFixed,_moduleName,(_projectPrefix+"_%1_fnc_perFixed"))
HANDLEDEFAULT(_draw3D,_moduleName,(_projectPrefix+"_%1_fnc_draw3D"))
HANDLEDEFAULT(_shutDown,_moduleName,"hct_%1_fnc_shutDown")

if (_startUp && _setup != "") then {
  private _func = (missionNameSpace getVariable _setup);
  if (!isNil "_func" && typeName _func == "CODE") then {
    _result = ([_vehicle] call _func);
    if (typeName _result == "BOOL" && {!_result}) then {
      _startUp = false;
    };
  };
};

_vehicleModuleArray pushBack [
  _moduleName,
  _startUp,
  _setup,
  _perFrame,
  _perSecond,
  _perFixed,
  _draw3D,
  _shutDown
];

_vehicle setVariable ["hct_modules", _vehicleModuleArray];
