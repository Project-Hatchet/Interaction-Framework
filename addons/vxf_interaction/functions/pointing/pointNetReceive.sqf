/*
 * vxf_interaction_fnc_pointNetReceive
 *
 * receives pointing positions and adds timestamps and textures
 *
 * params (array)[(positionModel) pointPos, (SCALAR) type, (string) player name]
 */

params ["_pointPos", "_pointType", "_name"];

private _pointTextures = [
  "\a3\ui_f\data\IGUI\Cfg\CrewAimIndicator\commander_ca.paa",
  "\a3\ui_f\data\IGUI\Cfg\Cursors\freelook_ca.paa"
];

vxf_point_icons pushBack [_pointPos, cba_missionTime, _pointTextures # _pointType, _name];
