#include "script_component.hpp"
/*
 * https://github.com/zen-mod/ZEN/blob/master/addons/common/functions/fnc_deployCountermeasures.sqf
 * Author: mharis001
 * Deploys countermeasures from the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player] call zen_common_fnc_deployCountermeasures
 *
 * Public: No
 */

params ["_vehicle"];

if !(_vehicle isKindOf "LandVehicle" || {_vehicle isKindOf "Air"} || {_vehicle isKindOf "Ship"}) exitWith {};

private _weapons = [];
private _cfgAmmo = configFile >> "CfgAmmo";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    _x params ["_magazine", "_turretPath", "_count"];

    // Filter empty magazines and check that the magazines' ammo type is a countermeasure
    if (_count == 0 || {_turretPath isEqualTo (hct_vehicle unitTurret hct_player)}) then { continue; };

    private _ammo = getText (_cfgMagazines >> _magazine >> "ammo");

    if (getText (_cfgAmmo >> _ammo >> "simulation") == "shotCM") then {
        // Add all weapons on the turret that can use this magazine
        {
            if (_magazine in (_x call CBA_fnc_compatibleMagazines)) then {
                _weapons pushBackUnique _x;
            };
        } forEach (_vehicle weaponsTurret _turretPath);
    };
} forEach magazinesAllTurrets _vehicle;

if (_weapons isEqualTo []) exitWith {};

[_vehicle, selectRandom _weapons] call BIS_fnc_fire;

nil
