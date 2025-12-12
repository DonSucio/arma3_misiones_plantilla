/*
    fn_registerRoutes.sqf

    Lee DON_routes_definitions y las normaliza en un registro (missionNamespace).
*/

private _enabled = missionNamespace getVariable ["DON_routes_enabled", false];
if (!_enabled) exitWith {
    missionNamespace setVariable ["DON_routes_registry", createHashMap];
};

private _defs = missionNamespace getVariable ["DON_routes_definitions", []];
private _registry = createHashMap;

{
    if (!(_x isEqualType [])) then { continue; };

    private _name = _x param [0, "", [""]];
    private _rawPoints = _x param [1, [], [[]]];
    private _loop = _x param [2, true, [true]];
    private _radius = _x param [3, 5, [0]];
    private _speed = _x param [4, "LIMITED", [""]];

    if (_name isEqualTo "") then { continue; };
    if ((count _rawPoints) == 0) then { continue; };

    private _points = _rawPoints apply {
        if (_x isEqualType "") then { getMarkerPos _x } else { _x };
    };

    private _routeData = createHashMap;
    _routeData set ["points", _points];
    _routeData set ["loop", _loop];
    _routeData set ["radius", _radius max 0.5];
    _routeData set ["speed", _speed];

    _registry set [_name, _routeData];
} forEach _defs;

missionNamespace setVariable ["DON_routes_registry", _registry];
