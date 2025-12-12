/*
    fn_ucPlayOnOwner.sqf

    Reproduce una ruta capturada (BIS_fnc_unitCapture) sobre un objeto/vehículo, respetando locality.
    - _objOrRef: objeto o nombre de variable de Eden.
    - _routeRef: nombre registrado en DON_uc_routes o array literal de captura.
    - _loopOverride: bool opcional; si nil usa el loop por defecto (config o ruta).
    - _timeShift: recorte inicial en segundos; si nil usa el de la ruta.
*/
params ["_objOrRef", "_routeRef", ["_loopOverride", nil], ["_timeShift", nil], ["_forcedLocal", false]];

private _obj = [_objOrRef] call DON_fnc_ucResolveObject;
if (isNull _obj) exitWith { scriptNull };

// Redirige al propietario/localidad adecuada
if (!local _obj && {!_forcedLocal}) exitWith {
    private _owner = owner _obj;
    [_obj, _routeRef, _loopOverride, _timeShift, true] remoteExec ["DON_fnc_ucPlayOnOwner", _owner];
    scriptNull
};

// Recupera ruta
private _route = [];
private _loopDefault = missionNamespace getVariable ["DON_unitCapture_defaultLoop", false];
private _timeShiftDefault = 0;

if (_routeRef isEqualType "") then {
    private _routes = missionNamespace getVariable ["DON_uc_routes", createHashMap];
    if !(_routes isEqualType createHashMap) then { _routes = createHashMap; };
    private _entry = _routes get _routeRef;
    if (isNil "_entry") exitWith { scriptNull };
    _entry params ["_routeData", ["_loopCfg", _loopDefault], ["_timeShiftCfg", 0]];
    _route = _routeData;
    _loopDefault = _loopCfg;
    _timeShiftDefault = _timeShiftCfg;
} else {
    _route = _routeRef;
};

if !(_route isEqualType [] && {count _route >= 2}) exitWith { scriptNull };

// Ajuste de loop/timeShift
private _loop = if (_loopOverride isEqualType true) then { _loopOverride } else { _loopDefault };
private _shift = if (_timeShift isEqualType 0) then { _timeShift } else { _timeShiftDefault };

// Helper local para timeShift (copia defensiva)
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

private _routeToPlay = _route;
if (_shift > 0) then {
    _routeToPlay = [_route, _shift] call _fnc_shift;
};

if !(_routeToPlay isEqualType [] && {count _routeToPlay >= 2}) exitWith { scriptNull };

// Cancela reproducción anterior en este objeto
private _key = format ["DON_uc_handle_%1", netId _obj];
private _prev = _obj getVariable ["DON_uc_handle", scriptNull];
if (!isNull _prev) then { terminate _prev; };

private _handle = [_obj, _routeToPlay] spawn BIS_fnc_unitPlay;
_obj setVariable ["DON_uc_handle", _handle, true];
_obj setVariable ["DON_uc_loop", _loop, true];
_obj setVariable ["DON_uc_route", _routeRef, true];
_obj setVariable ["DON_uc_timeShift", _shift, true];

if (_loop) then {
    [_obj, _routeRef, _shift] spawn {
        params ["_obj", "_routeRef", "_shift"];
        private _key = "DON_uc_handle";
        waitUntil {
            uiSleep 0.1;
            isNull _obj || {
                private _h = _obj getVariable [_key, scriptNull];
                scriptDone _h
            }
        };
        if (isNull _obj) exitWith {};
        if (!local _obj) exitWith {
            [_obj, _routeRef, true, _shift, true] remoteExec ["DON_fnc_ucPlayOnOwner", owner _obj];
        };
        [_obj, _routeRef, true, _shift, true] call DON_fnc_ucPlayOnOwner;
    };
};

_handle
