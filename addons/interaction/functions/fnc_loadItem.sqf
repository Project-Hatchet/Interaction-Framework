#include "script_component.hpp"
/*
 * FUNC(loadItem)
 *
 * loads part of interaction from config
 *
 * params: (array)[(object) vehicle, (configClass) config]
 *
 * returns: (array)[
 *            (string) name
 *            (string) condition
 *            (array) sub-items
 *            OPTIONAL: (string) position type
 *            OPTIONAL: (string) position
 *            OPTIONAL: (string) label
 *            OPTIONAL: (scalar) radius
 *            OPTIONAL: (array) button config
 *            OPTIONAL: (array) lever config
 *            ]
 */

params ["_vehicle", "_config"];

private _result = [
  configName _config,
  getText (_config >> "condition")
];

private _subItems = [];
private _subItemConfigs = "true" configClasses _config;
{ //forEach _subItems
  _subItems pushBack ([_vehicle, _x] call FUNC(loadItem));
} forEach _subItemConfigs;

_result pushBack _subItems;

private _positionType = getText (_config >> "positionType");
private _position = getText (_config >> "position");
if (_positionType == "static") then {
  _position = _vehicle selectionPosition _position;
};
if (_positionType == "coordinates") then {
  _positionType = "static";
  _position = getArray (_config >> "position");
};
private _label = getText (_config >> "label");
private _radius = getNumber (_config >> "radius");
private _interactCondition = getText (_config >> "interactionCondition");
private _buttonDown = getText (_config >> "buttonDown");
private _buttonUp = getText (_config >> "buttonUp");
private _buttonHold = getText (_config >> "buttonHold");
private _clickSound = getText (_config >> "clickSound");

private _buttonConfig = [];
if (_buttonDown != "" || _buttonUp != "" || _buttonHold != "") then {
  _buttonConfig = [
    compile _buttonDown,
    compile _buttonUp,
    (if (_buttonHold != "") then {compile _buttonHold} else {nil})
  ];
};

private _animation = getText (_config >> "animation");
private _animStates = (_config >> "animStates") call BIS_fnc_getCfgData;
private _animLabels = (_config >> "animLabels") call BIS_fnc_getCfgData;
private _animSpeed = getNumber (_config >> "animSpeed");
private _animLooping = getNumber (_config >> "looping");
private _animStart = getText (_config >> "animStart");
private _animEnd = getText (_config >> "animEnd");
private _animConfig = [];
if (_animation != "" && ISFULLARRAY(_animStates) && ISFULLARRAY(_animLabels)) then {
  _animConfig = [
    _animation,
    (if (_animSpeed == 0) then {true} else {_animSpeed}),
    (_animLooping == 1),
    _animStates,
    _animLabels,
    compile _animStart,
    compile _animEnd
  ];
};

private _scrollIncrement = getNumber (_config >> "scrollIncrement");
private _dragRange = getNumber (_config >> "dragRange");
private _animLimits = (_config >> "animLimits") call BIS_fnc_getCfgData;
private _dragStart = getText (_config >> "dragStart");
private _dragging = getText (_config >> "dragging");
private _dragStop = getText (_config >> "dragStop");
private _knobConfig = [];
if (_animation != "" && _dragRange > 0 && ISFULLARRAY(_animLimits)) then {
  _knobConfig = [
    _animation,
    _scrollIncrement,
    _dragRange,
    _animLooping,
    _animLimits,
    (if (_animSpeed == 0) then {true} else {_animSpeed}),
    compile _dragStart,
    (if (_dragging != "") then {compile _dragging} else {nil}),
    compile _dragStop
  ];
  _buttonConfig = [
    {_this call FUNC(dragStart)},
    {_this call FUNC(dragStop)},
    {_this call FUNC(drag)},
    compile _buttonUp
  ];
};

//check if there is sufficient data for an interaction
if (
  _positionType != "" &&
  (typeName _position == "STRING" && {_position != ""}) || (typeName _position == "ARRAY") &&
  // _label != "" &&
  _radius > -1
) then {
  _result = _result + [
    _positionType,
    _position,
    _label,
    _radius,
    _clickSound,
    _interactCondition,
    _buttonConfig,
    _animConfig,
    _knobConfig
  ];
};

_result
