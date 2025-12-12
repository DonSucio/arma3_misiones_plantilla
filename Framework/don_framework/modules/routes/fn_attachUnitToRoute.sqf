/*
    fn_attachUnitToRoute.sqf

    Hace que una unidad/vehículo recorra una ruta registrada.
    Usa doMove; si el objeto no es local, reenvía la llamada al dueño.
*/

params [
    ["_unit", objNull, [objNull]],
    ["_routeName", "", [""]],
    ["_options", createHashMap, [createHashMap, []]]
];

if (isNull _unit) exitWith {};
if (_routeName isEqualTo "") exitWith {};

if (!local _unit) exitWith {
    [_unit, _routeName, _options] remoteExec ["DON_fnc_attachUnitToRoute", _unit];
};

private _route = [_routeName] call DON_fnc_getRoute;
if (!(_route isEqualType createHashMap)) exitWith {};
private _points = _route getOrDefault ["points", []];
if ((count _points) == 0) exitWith {};

private _loop = _route getOrDefault ["loop", true];
private _radius = _route getOrDefault ["radius", 5];
private _speed = _route getOrDefault ["speed", "LIMITED"];

if (_options isEqualType createHashMap) then {
    _loop = _options getOrDefault ["loop", _loop];
    _radius = _options getOrDefault ["radius", _radius];
    _speed = _options getOrDefault ["speed", _speed];
};

if (_unit isKindOf "CAManBase" || { _unit isKindOf "LandVehicle" || _unit isKindOf "Air" || _unit isKindOf "Ship" }) then {
    _unit setSpeedMode _speed;
};

[_unit, _points, _loop, _radius] spawn {
    params ["_unit", "_points", "_loop", "_radius"];

    while {alive _unit && {(count _points) > 0}} do {
        {
            if (!alive _unit) exitWith {};
            _unit doMove _x;
            waitUntil {
                sleep 0.5;
                (!alive _unit) || {(_unit distance2D _x) <= _radius}
            };
        } forEach _points;

        if (!_loop || {!alive _unit}) exitWith {};
    };
};
