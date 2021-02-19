#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_drawLabel
 *
 * interaction button release functionality
 */

private _vehicle = vehicle ace_player;

if (isNil QGVAR(currentButton)) exitWith {
  ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
};

GVAR(currentButton) PARAMS;
if (_positionType == "anim") then {
  _position = _vehicle selectionPosition _position;
};

private _color = if (GVAR(buttonHolding)) then {[1,0,0,1]} else {[1,1,1,1]};
private _size = if (GVAR(buttonHolding)) then {0.045} else {0.05};
if (count _buttonConfig > 0 && count _knobConfig == 0) then {
  _label = format ["[%1] %2",((["VXF Interaction",QGVAR(points)] call CBA_fnc_getKeybind)# 5) call CBA_fnc_localizeKey, _label];
};
drawIcon3D [
  "\a3\ui_f\data\IGUI\Cfg\Cursors\selected_ca.paa",
  _color,
  _vehicle modelToWorldVisual _position,
  1,
  1,
  0,
  _label,
  2,
  _size
];

if (count _knobConfig > 0) then {
  _knobConfig params KNOBPARAMS;
  if (inputAction "prevAction" > 0 && !GVAR(scrolledHolding)) then {
    [_vehicle, 1, _knobConfig] call FUNC(knobAnimate);
  };
  if (inputAction "nextAction" > 0 && !GVAR(scrolledHolding)) then {
    [_vehicle, -1, _knobConfig] call FUNC(knobAnimate);
  };
  ["Scroll or drag to spin",0,0.6,0,0,0, 1303] spawn BIS_fnc_dynamicText;
} else {
  ["",0,0.6,0,0,0, 1303] spawn BIS_fnc_dynamicText;
};

if (count _animConfig > 0 && count _knobConfig == 0) then {
  _animConfig params ANIMPARAMS;
  private _closestState = 0;
  private _closestDiff = 9999;
  private ["_diff"];
  private _animationPhase = (_vehicle animationPhase _animation);
  { // forEach _animationSteps
    _diff = abs(_animationPhase - _x);
    if (_diff < _closestDiff) then {
      _closestDiff = _diff;
      _closestState = _forEachIndex;
    };
  } forEach _animationSteps;
  private _currentState = _closestState;
  if (_currentState == -1) exitWith {
    ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
    ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  };
  private _loopFirst = if (_animLooping) then {0} else {-1};
  private _loopLast = if (_animLooping) then {(count _animationSteps) - 1} else {-1};
  private _prevStep = if (_currentState == 0) then {_loopLast} else {_currentState - 1};
  private _nextStep = if (_currentState == (count _animationSteps) - 1) then {_loopFirst} else {_currentState + 1};
  if (_prevStep > -1) then {
    [format ["<t size='0.8'>Set to <t color='#ff0000'>%2</t> with <t color='#ff0000'>%1</t></t>", actionKeysNames "prevAction", _animationLabels # _prevStep],(-safeZoneX)+(GVAR(cursorPos) # 0) - (safeZoneW / 2),((GVAR(cursorPos) # 1) - 0.1),0,0,0, 1301] spawn BIS_fnc_dynamicText;
  } else {
    ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  };
  if (_nextStep > -1) then {
    [format ["<t size='0.8'>Set to <t color='#ff0000'>%2</t> with <t color='#ff0000'>%1</t></t>", actionKeysNames "nextAction", _animationLabels # _nextStep],(-safeZoneX)+(GVAR(cursorPos) # 0) - (safeZoneW / 2),((GVAR(cursorPos) # 1) + 0.1),0,0,0, 1302] spawn BIS_fnc_dynamicText;
  } else {
    ["",0,0.4,0,0,0, 1302] spawn BIS_fnc_dynamicText;
  };
  if (inputAction "prevAction" > 0 && _prevStep > -1) then {
    [_vehicle, _animation, _animationSteps # _prevStep, _animationLabels # _prevStep, _animationSpeed, _animStart, _animEnd, GVAR(currentButton)] call FUNC(leverAnimate);
  };
  if (inputAction "nextAction" > 0 && _nextStep > -1) then {
    [_vehicle, _animation, _animationSteps # _nextStep, _animationLabels # _nextStep, _animationSpeed, _animStart, _animEnd, GVAR(currentButton)] call FUNC(leverAnimate);
  };
} else {
  ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  ["",0,0.6,0,0,0, 1302] spawn BIS_fnc_dynamicText;
};

if (inputAction "prevAction" == 0 && inputAction "nextAction" == 0) then {GVAR(scrolledHolding) = false;};
