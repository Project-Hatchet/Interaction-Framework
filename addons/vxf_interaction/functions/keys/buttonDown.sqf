/*
 * vxf_interaction_fnc_buttonDown
 *
 * interaction button press down functionality
 */

#include "../interactDefines.hpp"

params ["_vehicle", "_button", ["_forced", false]];
if (isNil{_vehicle getVariable "vxf_interaction"}) exitWith {false};
if (isNil "vxf_interaction_currentButton" && !_forced) exitWith {};

_button PARAMS;
diag_log format ["%2: button down %1", _name, time];

if(!(_vehicle call compile _interactCondition)) exitWith {};

_buttonConfig BTNPARAMS;

if (_clickSound != "") then {playSound _clickSound};

[_vehicle] call _buttonDown;
[_vehicle, _position, 1, name player] call vxf_interaction_fnc_pointNetSend;

if (!isNil "_buttonHold") then {
  vxf_interaction_buttonHoldCode = _buttonHold;
};
vxf_interaction_buttonHolding = true;
vxf_interaction_dragging_buttonDownTime = time;

true
