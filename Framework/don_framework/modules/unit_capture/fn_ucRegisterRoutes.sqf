/*
    fn_ucRegisterRoutes.sqf

    Lee DON_unitCapture_routes desde don_config.sqf y genera un HashMap
    nombre -> [routeData, loopPorDefecto, timeShiftPorDefecto].
*/

private _enabled = missionNamespace getVariable ["DON_unitCapture_enabled", false];
private _definitions = missionNamespace getVariable ["DON_unitCapture_routes", []];
private _defaultLoop = missionNamespace getVariable ["DON_unitCapture_defaultLoop", false];

private _routes = createHashMap;
if (!_enabled) exitWith {
    missionNamespace setVariable ["DON_uc_routes", _routes];
};

// Helper local para timeShift (descarta entradas anteriores al desplazamiento)
private _fnc_shift = {
    params ["_route", "_shift"];
    if (_shift <= 0) exitWith {_route};
    if !(_route isEqualType [] && {count _route > 0}) exitWith {_route};

    private _first = _route#0;
    private _idx = -1;
    for "_i" from 0 to (count _first - 1) do {
        if ((_first select _i) isEqualType 0) exitWith { _idx = _i; };
    };
    if (_idx < 0) exitWith {_route};

    private _out = [];
    {
        private _row = _x;
        private _t = _row select _idx;
        if (_t isEqualType 0 && {_t >= _shift}) then {
            private _copy = +_row;
            _copy set [_idx, (_t - _shift) max 0];
            _out pushBack _copy;
        };
    } forEach _route;
    _out
};

{
    if !(_x isEqualType [] && {count _x >= 2}) exitWith {};
    _x params ["_name", "_file", ["_loop", _defaultLoop], ["_timeShift", 0]];
    if (!(_name isEqualType "") || { _name isEqualTo "" }) exitWith {};
    if (!(_file isEqualType "") || { _file isEqualTo "" }) exitWith {};

    private _route = [_file] call DON_fnc_ucLoadRouteFromFile;
    if (_timeShift > 0) then {
        _route = [_route, _timeShift] call _fnc_shift;
    };

    if !(_route isEqualType [] && {count _route >= 2}) exitWith {
        diag_log format ["[DON][UC] ucRegisterRoutes: ruta %1 inválida (%2).", _name, _file];
    };

    _routes set [_name, [_route, _loop, _timeShift]];
} forEach _definitions;

missionNamespace setVariable ["DON_uc_routes", _routes];
