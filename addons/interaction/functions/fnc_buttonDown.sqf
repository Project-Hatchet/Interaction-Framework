#include "script_component.hpp"
/*
 * vxf_interaction_fnc_buttonDown
 *
 * interaction button press down functionality
 */

params ["_vehicle", "_button", ["_forced", false]];

if (isNil {_vehicle getVariable QGVAR(points)}) exitWith {false};
if (isNil QGVAR(currentButton) && {!_forced}) exitWith {};

_button PARAMS;
diag_log format ["%2: button down %1", _name, time];

if !(_vehicle call compile _interactCondition) exitWith {};

_buttonConfig BTNPARAMS;

if !(_clickSound isEqualTo "") then {
  playSound _clickSound;
};

[_vehicle] call _buttonDown;
[_vehicle, _position, 1, name vxf_player] call FUNC(pointNetSend);

if !(isNil "_buttonHold") then {
  GVAR(buttonHoldCode) = _buttonHold;
};
GVAR(buttonHolding) = true;
GVAR(dragging_buttonDownTime) = time;

true
