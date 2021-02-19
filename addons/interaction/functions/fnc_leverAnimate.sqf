#include "script_component.hpp"
/*
 * hatchet_interaction_fnc_leverAnimate
 *
 * interaction button animate lever/switch functionality
 */

params ["_vehicle", "_animation", "_animationTarget", "_animationTargetLabel", "_animationSpeed", "_animStart", "_animEnd", "_button"];

if (isNil{_vehicle getVariable QGVAR(points)}) exitWith {false};
if (_animation in vxf_animating_keys) exitWith {false};

_button PARAMS;
diag_log format ["%2: lever animate %1", _name, time];

if !(_this call compile _interactCondition) exitWith {
  //[] spawn {
  //  showCommandingMenu "RscMainMenu";
  //  showCommandingMenu "";
  //};
};

if (_clickSound != "") then {
  playSound _clickSound;
};

[_vehicle, _animation, _animationTargetLabel, _animationTarget] call _animStart;
[_vehicle, _position, 1, name ace_player] call FUNC(pointNetSend);
vxf_animating_keys pushBack _animation;

_vehicle animateSource [_animation, _animationTarget, _animationSpeed];

#define OUTER_ARGS(ARRAY) ARRAY params ["_vehicle", "_animation", "_animationTarget", "_animationTargetLabel", "_animEnd"]
#define INNER_ARGS \
  _this params ["_p1", "_startTime"]; \
  OUTER_ARGS(_p1)

// Waits for 3 seconds, then begins a CBA waitUntil
[{
  OUTER_ARGS(_this);
  [{
    INNER_ARGS;
    (_vehicle animationPhase _animation > _animationTarget - 0.02) &&
      { (_vehicle animationPhase _animation < _animationTarget + 0.02) }
  }, {
    INNER_ARGS;
    [_vehicle, _animation, _animationTargetLabel, _animationTarget] call _animEnd;
    vxf_animating_keys deleteAt (vxf_animating_keys find _animation);
  },
    [[_vehicle, _animation, _animationTarget, _animationTargetLabel, _animEnd], cba_missionTime]
  ] call CBA_fnc_waitUntilAndExecute;
}, [
  _vehicle, _animation, _animationTarget, _animationTargetLabel, _animEnd
], 3] call CBA_fnc_waitAndExecute;
