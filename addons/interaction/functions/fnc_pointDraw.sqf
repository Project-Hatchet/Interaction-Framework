/*
 * hct_interaction_fnc_pointDraw
 *
 * draws pointing positions
 *
 * params (array)[(object) vehicle]
 */

params ["_vehicle"];

for "_i" from (count hct_point_icons - 1) to 0 step -1 do {
 private _x = hct_point_icons # _i;
 if (cba_missionTime > (_x # 1) + hct_point_lifetime) then {
   hct_point_icons deleteAt _i;
 } else {
   private _drawPos = if(typeName (_x # 0) == "STRING") then {_vehicle selectionPosition (_x # 0)} else {(_x # 0)};
   drawIcon3D [_x # 2, [1,0,0,1], _vehicle modelToWorldVisual _drawPos, 2, 2, 0, (_x # 3)];
 };
};
