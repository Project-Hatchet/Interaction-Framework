#include "script_component.hpp"
/*
 * htf_interaction_fnc_findButton
 */

params ["_points"];

private _button = nil;
private _buttonDis = 1000;

{
  private _dis = _x call FUNC(checkInteraction);
  if !(isNil "_dis") then {
    if (_dis < _buttonDis) then {
      _button = _x;
      _buttonDis = _dis;
    };
  };
} forEach _points;

_button
