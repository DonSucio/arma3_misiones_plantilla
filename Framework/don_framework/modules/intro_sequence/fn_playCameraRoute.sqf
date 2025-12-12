/*
    fn_playCameraRoute.sqf

    Mueve la cámara interna a lo largo de una ruta declarada en DON_routes_definitions.
    Pensado para intros; no toca controles del jugador.
*/
if (!hasInterface) exitWith {};

params [
    ["_routeName", "", [""]],
    ["_segmentTime", 8, [0]],
    ["_target", objNull, [objNull, "", []]]
];

if (_routeName isEqualTo "") exitWith {};

private _route = [_routeName] call DON_fnc_getRoute;
if (!(_route isEqualType createHashMap)) exitWith {};
private _points = _route getOrDefault ["points", []];
if ((count _points) < 2) exitWith {};

// Normaliza target: obj, marker o posición
private _targetValue = objNull;
if (_target isEqualType "") then {
    _targetValue = getMarkerPos _target;
} else {
    _targetValue = _target;
};

showCinemaBorder true;
private _cam = "camera" camCreate (_points select 0);
_cam cameraEffect ["internal", "back"];
_cam camCommit 0;

{
    if (_forEachIndex == 0) then { continue; };

    private _pos = _x;
    _cam camSetPos _pos;

    private _camTarget = _pos;
    if (_targetValue isEqualType []) then {
        _camTarget = _targetValue;
    } else {
        if (!isNull _targetValue) then {
            _camTarget = _targetValue;
        };
    };
    _cam camSetTarget _camTarget;

    _cam camCommit _segmentTime;
    waitUntil { camCommitted _cam };
} forEach _points;

_cam cameraEffect ["terminate", "back"];
camDestroy _cam;
showCinemaBorder false;
