#include "script_component.hpp"
// only executed on client

["unit", {params ["_newUnit"]; if !(isNull _newUnit) then {hct_player = _newUnit;};}] call CBA_fnc_addPlayerEventHandler;
["visibleMap", {
  params ["", "_visible"];
  if (_visible) then {
    with uiNamespace do {
      ctrlDelete hct_cursor_ctrl;
      hct_cursor_ctrl = nil;
    };
  };
}] call CBA_fnc_addPlayerEventHandler;
hct_player = player;

call FUNC(init);
