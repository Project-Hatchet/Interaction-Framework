#include "script_component.hpp"
/*
 * vxf_interaction_fnc_addActions
 */

private _veh = vehicle vxf_player;
if !((driver _veh) isEqualto vxf_player || {(gunner _veh isEqualTo vxf_player) && isCopilotEnabled _veh}) exitWith {};

// Engine
{
  if !(_x in GVAR(actionIgnore)) then {
    private _config = (configFile >> (format [QRVAR(%1), _x]));
    [getText (_config >> "label"), getText (_config >> "buttonDown"), getText (_config >> "condition"), _x] call FUNC(addAction);
  };
} forEach ["EngineOn", "EngineOff", "LightOn", "LightOff"];
