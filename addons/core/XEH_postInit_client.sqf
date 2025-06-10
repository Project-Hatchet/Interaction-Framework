#include "script_component.hpp"
// only executed on client

["unit", {hct_player = _this # 1}] call CBA_fnc_addPlayerEventHandler;
hct_player = player;

call FUNC(init);
