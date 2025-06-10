/*
 * hct_interaction_fnc_buttonDown
 *
 * interaction button press down functionality
 */

#include "script_component.hpp"

params ["_vehicle", "_button", ["_forced", false]];
if (isNil{_vehicle getVariable "hct_interaction"}) exitWith {false};
if (isNil "hct_interaction_currentButton" && !_forced) exitWith {};

_button PARAMS;
diag_log format ["%2: button down %1", _name, time];

if(!(_vehicle call compile _interactCondition)) exitWith {};

_buttonConfig BTNPARAMS;

if (_clickSound != "") then {playSound _clickSound};

[_vehicle] call _buttonDown;
[_vehicle, _position, 1, name ace_player] call hct_interaction_fnc_pointNetSend;

if (!isNil "_buttonHold") then {
  hct_interaction_buttonHoldCode = _buttonHold;
};
hct_interaction_buttonHolding = true;
hct_interaction_dragging_buttonDownTime = time;

true
