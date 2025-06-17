#include "script_component.hpp"
/*
 * Author: Ampersand
 * Toggle vehicle pip rtt effects
 *
 * Arguments:
 * 0: State <NUMBER>
 *      0: All off
 *      1: All on
 *      2: Toggle All
 *
 * Return Value:
 * None.
 *
 * Example:
 * [2] call tgp_main_fnc_toggleRenderTargets
 */

params [["_state", 2]];

_vehicle = hct_vehicle;

private _renderTargets = _vehicle getVariable [QGVAR(renderTargets), []];
if (_renderTargets isEqualTo []) then {
    // Not initialized, get config
    _renderTargets = "true" configClasses (configOf _vehicle >> "RenderTargets") apply { getText(_x >> "renderTarget") };
    if (_renderTargets isEqualTo []) then {
        _renderTargets = false;
    };
    _vehicle setVariable [QGVAR(renderTargets), _renderTargets];
};
if (_renderTargets isEqualTo false) exitWith {};

switch (_state) do {
    case false;
    case 0: {
        {
            _vehicle cameraEffect ["terminate", "FRONT", _x];
            _vehicle setVariable [format ["%1%2", QGVAR(RTT), _x], false];
        } forEach _renderTargets;
    };
    case true;
    case 1: {
        _vehicle cameraEffect ["terminate", "FRONT"];
        {
            _vehicle setVariable [format ["%1%2", QGVAR(RTT), _x], true];
        } forEach _renderTargets;
    };
    case 2: {
        private _xState = _vehicle getVariable [format ["%1%2", QGVAR(RTT), _renderTargets select 0], true];
        [!_xState] call FUNC(toggleRenderTargets);
    };
    default {};
};
