/*
 * vxf_interaction_fnc_drawLabel
 *
 * interaction button release functionality
 */

 private _vehicle = vehicle player;

#include "interactDefines.hpp"

if (isNil "vxf_interaction_currentButton") exitWith {
  ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
};

vxf_interaction_currentButton PARAMS;
if (_positionType == "anim") then {
  _position = _vehicle selectionPosition _position;
};

private _color = if (vxf_interaction_buttonHolding) then {[1,0,0,1]} else {[1,1,1,1]};
private _size = if (vxf_interaction_buttonHolding) then {0.045} else {0.05};
if (count _buttonConfig > 0 && count _knobConfig == 0) then {
  _label = format ["[%1] %2",((["Hatchet Vehicle Framework","vxf_interaction"] call CBA_fnc_getKeybind)# 5) call CBA_fnc_localizeKey, _label];
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
  if ((inputAction "prevAction" > 0 || vxf_alternative_scroll_up) && !vxf_interaction_scrolledHolding) then {
    [_vehicle, 1, _knobConfig] call vxf_interaction_fnc_knobAnimate;
  };
  if ((inputAction "nextAction" > 0 || vxf_alternative_scroll_down) && !vxf_interaction_scrolledHolding) then {
    [_vehicle, -1, _knobConfig] call vxf_interaction_fnc_knobAnimate;
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
    [format ["<t size='0.8'>Set to <t color='#ff0000'>%2</t> with <t color='#ff0000'>%1</t></t>", actionKeysNames "prevAction", _animationLabels # _prevStep],(-safeZoneX)+(vxf_interaction_cursorPos # 0) - (safeZoneW / 2),((vxf_interaction_cursorPos # 1) - 0.1),0,0,0, 1301] spawn BIS_fnc_dynamicText;
  } else {
    ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  };
  if (_nextStep > -1) then {
    [format ["<t size='0.8'>Set to <t color='#ff0000'>%2</t> with <t color='#ff0000'>%1</t></t>", actionKeysNames "nextAction", _animationLabels # _nextStep],(-safeZoneX)+(vxf_interaction_cursorPos # 0) - (safeZoneW / 2),((vxf_interaction_cursorPos # 1) + 0.1),0,0,0, 1302] spawn BIS_fnc_dynamicText;
  } else {
    ["",0,0.4,0,0,0, 1302] spawn BIS_fnc_dynamicText;
  };
  if ((inputAction "prevAction" > 0 || vxf_alternative_scroll_up) && _prevStep > -1) then {
    [_vehicle, _animation, _animationSteps # _prevStep, _animationLabels # _prevStep, _animationSpeed, _animStart, _animEnd, vxf_interaction_currentButton] call vxf_interaction_fnc_leverAnimate;
  };
  if ((inputAction "nextAction" > 0 || vxf_alternative_scroll_down) && _nextStep > -1) then {
    [_vehicle, _animation, _animationSteps # _nextStep, _animationLabels # _nextStep, _animationSpeed, _animStart, _animEnd, vxf_interaction_currentButton] call vxf_interaction_fnc_leverAnimate;
  };
} else {
  ["",0,0.4,0,0,0, 1301] spawn BIS_fnc_dynamicText;
  ["",0,0.6,0,0,0, 1302] spawn BIS_fnc_dynamicText;
};

if (inputAction "prevAction" == 0 && inputAction "nextAction" == 0 && !vxf_alternative_scroll_down && !vxf_alternative_scroll_up) then {vxf_interaction_scrolledHolding = false;};
