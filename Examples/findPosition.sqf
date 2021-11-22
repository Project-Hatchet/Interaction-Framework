// https://youtu.be/JaYI3eflifM

// Reset
htf_helper_points = [];

// Get 2 lines
htf_helper_points pushBack [positionCameraToWorld [0,0,0], screenToWorld getMousePosition];

// Get model space
_modelSpace = htf_helper_points apply {
    _x apply {vehicle player worldToModelVisual _x}
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
_point = (_c1 vectorAdd _c2) vectorMultiply 0.5;
copyToClipboard str _point;
_point
