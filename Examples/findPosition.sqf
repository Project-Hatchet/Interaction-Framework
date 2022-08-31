// https://youtu.be/JaYI3eflifM

// Reset
vxf_helperVehicle = [vehicle player, cursorObject] select (player == vehicle player);
vxf_helperPoint = nil;
vxf_helperPoints = [];
if !(isNil "vxf_helperID") then { removeMissionEventHandler ["Draw3D", vxf_helperID]; };
vxf_helperID = addMissionEventHandler ["Draw3D",{
  if !(isNil "vxf_helperPoint") then {
    drawIcon3D [
      "a3\ui_f\data\Map\MarkerBrushes\cross_ca.paa",
      [1,1,1,1],
      vxf_helperVehicle modelToWorldVisual vxf_helperPoint,
      1,1,0,
      ""
    ];
  };
  {
    drawLine3D [_x # 0, _x # 1, [1,1,1,1]];
  } forEach vxf_helperPoints;
}];

// Get 2 lines
vxf_helperPoints pushBack [positionCameraToWorld [0,0,0], screenToWorld getMousePosition];

// Get model space
_modelSpace = vxf_helperPoints apply {
    _x apply {vxf_helperVehicle worldToModelVisual _x}
};
_modelSpace params ["_pair1", "_pair2"];
_p1 = (_pair1 # 0);
_p2 = (_pair2 # 0);
_d1 = (_pair1 # 0) vectorFromTo (_pair1 # 1);
_d2 = (_pair2 # 0) vectorFromTo (_pair2 # 1);
_n = _d1 vectorCrossProduct _d2;
_n1 = _d1 vectorCrossProduct _n;
_n2 = _d2 vectorCrossProduct _n;
_c1 = _p1 vectorAdd (_d1 vectorMultiply (((_p2 vectorDiff _p1) vectorDotProduct _n2)/(_d1 vectorDotProduct _n2)));
_c2 = _p2 vectorAdd (_d2 vectorMultiply (((_p1 vectorDiff _p2) vectorDotProduct _n1)/(_d2 vectorDotProduct _n1)));
vxf_helperPoint = (_c1 vectorAdd _c2) vectorMultiply 0.5;
copyToClipboard str _point;
vxf_helperPoint
