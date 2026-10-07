/*
 * hct_interaction_fnc_keyCursor
 *
 * Handle input for use mouse cursor
 *
 * Params: None
 */


if (
  isNil "hct_vehicle"
  || {cameraView != "INTERNAL"}
  || {!isNull curatorCamera}
  || {visibleMap}
) exitWith {
  if (uiNamespace getVariable ["hct_interaction_mouseBlocker", false]) then {
    (findDisplay 86005) closeDisplay 0;
  };
};

if (_this) then {
  hct_interaction_cursor_mouseDown = false;
  (findDisplay 46) createDisplay "hct_interaction_mouseBlocker";
  (findDisplay 86005) displayAddEventHandler ["KeyUp", {[_this,'keyup'] call CBA_events_fnc_keyHandler}];
  // mouse button releases stay inside this display, so the hold action's
  // onDeactivate never fires when it is bound to a mouse button
  // (actionKeys reports mouse buttons as 65536 + button index)
  (findDisplay 86005) displayAddEventHandler ["MouseButtonUp", {
    params ["_display", "_button"];
    if ((65536 + _button) in actionKeys "hct_interaction_cursor") then {_display closeDisplay 0;};
  }];
  setMousePosition [0.5, 0.5];

} else {

  if (uiNamespace getVariable ["hct_interaction_mouseBlocker", false]) then {
    (findDisplay 86005) closeDisplay 0;
  };

};
