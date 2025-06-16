#include "script_component.hpp"
// only executed on client

["unit", {params ["_newUnit"]; if !(isNull _newUnit) then {hct_player = _newUnit;};}] call CBA_fnc_addPlayerEventHandler;
hct_player = player;

call FUNC(init);
