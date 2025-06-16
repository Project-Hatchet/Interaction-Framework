/*
 * hct_interaction_fnc_drawLabel
 *
 * interaction button release functionality
 */

/*
 * hct_interaction_fnc_drawLabel Execution Time: 0.0146 ms
 *
 * interaction button release functionality
 */

 private _vehicle = vehicle hct_player;

#include "script_component.hpp"

with uiNamespace do {
  if (isNil "hct_cursor_ctrl") then {
    hct_cursor_ctrl = findDisplay ([46, 86005] select hct_interaction_mouseBlocker) ctrlCreate ["RscStructuredText", -1];
  };
};

uiNamespace setVariable ["hct_interaction_cursorPos", hct_interaction_cursorPos];

if (isNil "hct_interaction_currentButton") exitWith {
  ["", ""] call hct_interaction_fnc_setLabel;
};

hct_interaction_currentButton PARAMS;
if (_positionType == "anim") then {
  _position = _vehicle selectionPosition _position;
};

private _color = [[1,1,1,1], [1,0,0,1]] select (hct_interaction_buttonHolding);
private _size = [0.05, 0.045] select (hct_interaction_buttonHolding);
_label = if (hct_interaction_showLabels > 0.5) then {
  if (count _buttonConfig > 0 && count _knobConfig == 0) then {
    format [
      ["%2", "[%1] %2"] select (hct_interaction_showLabels > 1),
      hct_akn_use,
      _label
    ]
  } else {
    _label
  }
} else {
  ""
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
  if (hct_alternative_scroll_up && !hct_interaction_scrolledHolding) then {
    [_vehicle, 1, _knobConfig] call hct_interaction_fnc_knobAnimate;
  };
  if (hct_alternative_scroll_down && !hct_interaction_scrolledHolding) then {
    [_vehicle, -1, _knobConfig] call hct_interaction_fnc_knobAnimate;
  };
  if (hct_interaction_showLabels > 1) then {
//    ["Scroll or drag to spin",0,0.6,0,0,0, 1303] spawn BIS_fnc_dynamicText;
    ["", "Scroll or drag to spin"] call hct_interaction_fnc_setLabel;
  } else {
    ["", ""] call hct_interaction_fnc_setLabel;
  };
} else {
  ["", ""] call hct_interaction_fnc_setLabel;
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
    ["", ""] call hct_interaction_fnc_setLabel;
  };
  private _loopFirst = if (_animLooping) then {0} else {-1};
  private _loopLast = if (_animLooping) then {(count _animationSteps) - 1} else {-1};
  private _prevStep = if (_currentState == 0) then {_loopLast} else {_currentState - 1};
  private _nextStep = if (_currentState == (count _animationSteps) - 1) then {_loopFirst} else {_currentState + 1};
  if (hct_interaction_showLabels > 1) then {
    private _prevText = "";
    if (_prevStep > -1) then {
      _prevText = format ["<t size='1.5'>Set to <t color='#ff0000'>%2</t> with <t color='#ff0000'>%1</t></t>", hct_akn_prev, _animationLabels # _prevStep];
    };
    private _nextText = "";
    if (_nextStep > -1) then {
      _nextText = format ["<t size='1.5'>Set to <t color='#ff0000'>%2</t> with <t color='#ff0000'>%1</t></t>", hct_akn_next, _animationLabels # _nextStep];
    };
    [_prevText, _nextText] call hct_interaction_fnc_setLabel;
  } else {
    ["", ""] call hct_interaction_fnc_setLabel;
  };
  if (hct_alternative_scroll_up && _prevStep > -1) then {
    [_vehicle, _animation, _animationSteps # _prevStep, _animationLabels # _prevStep, _animationSpeed, _animStart, _animEnd, hct_interaction_currentButton] call hct_interaction_fnc_leverAnimate;
  };
  if (hct_alternative_scroll_down && _nextStep > -1) then {
    [_vehicle, _animation, _animationSteps # _nextStep, _animationLabels # _nextStep, _animationSpeed, _animStart, _animEnd, hct_interaction_currentButton] call hct_interaction_fnc_leverAnimate;
  };
} else {
  ["", ""] call hct_interaction_fnc_setLabel;
};

if (!hct_alternative_scroll_down && !hct_alternative_scroll_up) then {hct_interaction_scrolledHolding = false;};
