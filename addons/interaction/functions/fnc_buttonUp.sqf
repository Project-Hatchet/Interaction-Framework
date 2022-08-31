#include "script_component.hpp"
/*
 * vxf_interaction_fnc_buttonUp
 *
 * interaction button release functionality
 */

GVAR(buttonHolding) = false;
params ["_vehicle", "_button"];
if (isNil{_vehicle getVariable QGVAR(points)}) exitWith {false};

_button PARAMS;
diag_log format ["%2: button up %1", _name, time];

if !(_vehicle call compile _interactCondition) exitWith {};

_buttonConfig BTNPARAMS;

[_vehicle] call _buttonUp;
GVAR(buttonHoldCode) = nil;
if (!isNil "_knobClick") then {
  private _clickTime = time - GVAR(dragging_buttonDownTime);
  if (_clickTime < 0.25) then {
    systemChat format ["CLICK TIME %1", _clickTime];
    [_vehicle] call _knobClick;
  };
};

true
