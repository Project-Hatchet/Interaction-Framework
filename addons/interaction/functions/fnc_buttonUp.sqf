/*
 * hct_interaction_fnc_buttonUp
 *
 * interaction button release functionality
 */

#include "script_component.hpp"

hct_interaction_buttonHolding = false;
params ["_vehicle", "_button"];
if (isNil{_vehicle getVariable "hct_interaction"}) exitWith {false};

_button PARAMS;
diag_log format ["%2: button up %1", _name, time];

if(!(_vehicle call compile _interactCondition)) exitWith {};

_buttonConfig BTNPARAMS;

[_vehicle] call _buttonUp;
hct_interaction_buttonHoldCode = nil;
if (!isNil "_knobClick") then {
  private _clickTime = time - hct_interaction_dragging_buttonDownTime;
  if (_clickTime < 0.25) then {
    if (hct_interactionShowDebugMessages) then {systemChat format["CLICK TIME %1", _clickTime];};
    [_vehicle] call _knobClick;
  };
};
true
