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
) exitWith {};

if (_this) then {
  hct_interaction_cursor_mouseDown = false;
  (findDisplay 46) createDisplay "hct_interaction_mouseBlocker";
  (findDisplay 86005) displayAddEventHandler ["KeyUp", {[_this,'keyup'] call CBA_events_fnc_keyHandler}];
  setMousePosition [0.5, 0.5];

} else {

  if (uiNamespace getVariable ["hct_interaction_mouseBlocker", false]) then {
    (findDisplay 86005) closeDisplay 0;
  };

};
