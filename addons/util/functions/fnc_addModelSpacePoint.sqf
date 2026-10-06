/*
 * hct_util_fnc_addModelSpacePoint
 *
 * Adds a sight line from the camera through the mouse cursor for
 * hct_util_fnc_findModelSpaceCoordinates.
 *
 * Run from the debug console (Esc menu open) with the mouse over the point
 * to measure.
 *
 * params: none
 *
 * returns: (bool) line added
 */

if (isNil "hct_helperPoints") exitWith {
  systemChat "Run this first: call hct_util_fnc_findModelSpaceCoordinates";
  false
};

// built from the camera's own view ray: screenToWorld needs ground behind the
// cursor and returns an empty position above the horizon
private _start = AGLToASL positionCameraToWorld [0,0,0];
private _end = _start vectorAdd ((screenToWorldDirection getMousePosition) vectorMultiply 10);
hct_helperPoints pushBack [ASLToAGL _start, ASLToAGL _end];

true
