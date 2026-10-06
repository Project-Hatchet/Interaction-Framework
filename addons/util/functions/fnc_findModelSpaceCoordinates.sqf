/*
 * hct_util_fnc_findModelSpaceCoordinates
 *
 * Find the model space coordinates for an interaction.
 *
 * params: none
 *
 * returns: none
 *
 * get in vehicle
 * run in debug console

call hct_util_fnc_findModelSpaceCoordinates

 * move head position, open Esc menu, and mouse over the point
 * run in debug console to add the first line

call hct_util_fnc_addModelSpacePoint

 * move head position and add another line
 * with 2 points the coordinates will be calculated, displayed, and copied to clipboard
 * check the position and if ok then paste into the config
 *
 * animation names and sources
 * [animationNames cameraOn, "true" configClasses (configOf cameraOn >> "AnimationSources") apply {configName _x}]
 *
 */

hideObject player;
hct_helperVehicle = vehicle player;
hct_helperPoint = nil;
hct_helperPoints = [];
if !(isNil "hct_helperID") then { removeMissionEventHandler ["Draw3D", hct_helperID]; };
hct_helperID = addMissionEventHandler ["Draw3D",{
  if (count hct_helperPoints == 3) then {
    hct_helperPoints = [hct_helperPoints # 2];
  };
  // a sight line without two full positions errors in every draw below
  private _valid = hct_helperPoints select {
    _x isEqualTypeArray [[], []] && {count (_x # 0) == 3} && {count (_x # 1) == 3}
  };
  if (count _valid != count hct_helperPoints) then {
    hct_helperPoints = _valid;
    systemChat "Ignored a sight line with no position - add lines with: call hct_util_fnc_addModelSpacePoint";
  };
  hintSilent format ["# points %1/2", count hct_helperPoints];

  {
    drawLine3D [_x # 0, _x # 1, [1,1,1,1]];
  } forEach hct_helperPoints;
  if (count hct_helperPoints == 2) then {
    _modelSpace = hct_helperPoints apply {
      _x apply {hct_helperVehicle worldToModelVisual _x}
    };
    _modelSpace params ["_pair1", "_pair2"];
    _p1 = (_pair1 # 0);
    _p2 = (_pair2 # 0);
    _d1 = (_pair1 # 0) vectorFromTo (_pair1 # 1);
    _d2 = (_pair2 # 0) vectorFromTo (_pair2 # 1);
    _n = _d1 vectorCrossProduct _d2;
    // parallel sight lines never cross and divide by zero below
    if (vectorMagnitude _n < 0.001) exitWith {
      hct_helperPoints deleteAt 1;
      systemChat "The two sight lines are parallel - move your head further before adding the second line";
    };
    _n1 = _d1 vectorCrossProduct _n;
    _n2 = _d2 vectorCrossProduct _n;
    _c1 = _p1 vectorAdd (_d1 vectorMultiply (((_p2 vectorDiff _p1) vectorDotProduct _n2)/(_d1 vectorDotProduct _n2)));
    _c2 = _p2 vectorAdd (_d2 vectorMultiply (((_p1 vectorDiff _p2) vectorDotProduct _n1)/(_d2 vectorDotProduct _n1)));
    hct_helperPoint = (_c1 vectorAdd _c2) vectorMultiply 0.5;
    copyToClipboard ((str hct_helperPoint splitString "[]") # 0);
  };
  if !(isNil "hct_helperPoint") then {
    drawIcon3D [
      "a3\ui_f\data\Map\MarkerBrushes\cross_ca.paa",
      [1,1,1,1],
      hct_helperVehicle modelToWorldVisual hct_helperPoint,
      1,1,0,
      ""
    ];
  };
}];
