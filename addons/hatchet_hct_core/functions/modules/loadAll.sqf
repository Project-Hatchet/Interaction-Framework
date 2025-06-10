/*
 * hct_core_fnc_loadAll
 *
 * Reads out relevant vehicle modules from config and stores them in vehicle variables
 *
 * Params: array[array[(object) vehicle]
 * Returns: nothing
 *
 * Author: Yax
 */
params ["_vehicle"];

private _vehicleModuleArray = [];

private _vehicleConfig = _vehicle getVariable "hct_config";
private _modules = "true" configClasses (_vehicleConfig >> "modules");

private _projectPrefix = _vehicle getVariable ["hct_projectPrefix", ""];
#define HANDLEDEFAULT(VAR,MODULENAME,PATH) if(VAR == "" && {!isNil{missionNameSpace getVariable format[PATH, MODULENAME]}}) then {VAR = format[PATH, MODULENAME];};

{ //forEach _modules
  private _moduleConfig = _x;
  private _moduleName = configName _x;
  private _startUp = (getNumber (_moduleConfig >> "startOnEnter") == 1);

  private _setup = getText (_moduleConfig >> "setup");
  HANDLEDEFAULT(_setup,_moduleName,(_projectPrefix+"_%1_fnc_setup"))
  private _shutDown = getText (_moduleConfig >> "shutDown");
  HANDLEDEFAULT(_shutDown,_moduleName,(_projectPrefix+"_%1_fnc_shutDown"))
  private _perFrame = getText (_moduleConfig >> "perFrame");
  HANDLEDEFAULT(_perFrame,_moduleName,(_projectPrefix+"_%1_fnc_perFrame"))
  private _perSecond = getText (_moduleConfig >> "perSecond");
  HANDLEDEFAULT(_perSecond,_moduleName,(_projectPrefix+"_%1_fnc_perSecond"))
  private _perFixed = getText (_moduleConfig >> "perFixed");
  HANDLEDEFAULT(_perFixed,_moduleName,(_projectPrefix+"_%1_fnc_perFixed"))
  private _draw3D = getText (_moduleConfig >> "draw3D");
  HANDLEDEFAULT(_draw3D,_moduleName,(_projectPrefix+"_%1_fnc_draw3D"))


  if (_startUp && _setup != "") then {
    private _func = (missionNameSpace getVariable _setup);
    if (!isNil "_func" && typeName _func == "CODE") then {
      private _result = ([_vehicle] call _func);
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
} forEach _modules;

_vehicle setVariable ["hct_modules", _vehicleModuleArray];
