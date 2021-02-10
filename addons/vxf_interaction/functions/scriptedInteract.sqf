/*
* vxf_interaction_fnc_scriptedInteract
*
* call a button or lever from a script
*/

params ["_vehicle", "_config", ["_animationTargetLabel", nil]];

private _vehicleConfig = _vehicle getVariable "vxf_config";

if (isNil "_vehicleConfig") exitWith {};

private _configPath = _vehicleConfig >> "interaction";
{_configPath = _configPath >> _x} forEach _config;
private _interactionConfig = [_vehicle, _configPath] call vxf_interaction_fnc_loadItem;

if (isNil "_animationTargetLabel") exitWith {
 [_vehicle, _interactionConfig, true] call vxf_interaction_fnc_buttonDown;
 [_vehicle, _interactionConfig, true] call vxf_interaction_fnc_buttonUp;
};

_interactionConfig params ["_name","_condition","_subItems",["_positionType", nil],["_position", nil],["_label", nil],["_radius", nil],["_clickSound",""],["_interactCondition",{true}],["_buttonConfig", nil], ["_animConfig", nil], ["_knobConfig", nil]];
_animConfig params ["_animation", "_animationSpeed", "_animLooping", "_animationSteps", "_animationLabels", "_animStart", "_animEnd"];

private _stepIndex = _animationLabels find _animationTargetLabel;
if (_stepIndex == -1) exitWith {};
private _targetAnimStep = _animationSteps # _stepIndex;
[_vehicle, _animation, _targetAnimStep, _animationTargetLabel, _animationSpeed, _animStart, _animEnd, _interactionConfig] call vxf_interaction_fnc_leverAnimate;
