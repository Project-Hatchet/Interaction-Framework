/*
 * vxf_interaction_fnc_checkInteraction
 *
 * checks if a sub-item is valid for interaction
 *
 * params: (array)[
 *            (string) name
 *            (string) condition
 *            (array) sub-items
 *            OPTIONAL: (string) position type
 *            OPTIONAL: (string) position
 *            OPTIONAL: (string) label
 *            OPTIONAL: (scalar) radius
 *            OPTIONAL: (string) buttonDown code
 *            OPTIONAL: (string) buttonUp code
 *            OPTIONAL: (string) buttonHold
 *            OPTIONAL: (string) buttonMove
 *            ]
 *
 * returns: on success array, on failure nil
 */

#include "interactDefines.hpp"
PARAMS;

scopeName "main";

// cut it off if the condition is false
if (_condition != "" && {!(_vehicle call (compile _condition))}) exitWith {nil};

if (!isNil "_positionType") then {
  // get the selection position coordinates
  if (_positionType == "anim") then {
    _position = _vehicle selectionPosition _position;
  };
  private _positionWorld = _vehicle modelToWorldVisual _position;
  private _screenPos = worldToScreen _positionWorld;
  // make sure the position is on the screen
  if (count _screenPos == 2) then {
    private _btnSel = (_screenPos distance vxf_interaction_cursorPos) < (_radius * vxf_interaction_buttonRadius);
    if (_btnSel) then {
      _this breakOut "main";
    };
  };
};

private ["_result"];
{ // forEach _subItems
  _result = _x call vxf_interaction_fnc_checkInteraction;
  if (!isNil "_result") then {
    _result breakOut "main";
  };
} forEach _subItems;

nil
