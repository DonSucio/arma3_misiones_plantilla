/*
    fn_ucPlayLocal.sqf

    Reproduce una ruta de unitCapture donde el objeto YA es local.
    No gestiona locality ni dispatch: usa DON_fnc_ucPlayOnOwner para eso.
*/
params ["_objOrRef", "_routeRef", ["_loopOverride", nil], ["_timeShift", nil]];

private _obj = [_objOrRef] call DON_fnc_ucResolveObject;
if (isNull _obj) exitWith { scriptNull };
if (!local _obj) exitWith { scriptNull };

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

private _loop = if (_loopOverride isEqualType true) then { _loopOverride } else { _loopDefault };
private _shift = if (_timeShift isEqualType 0) then { _timeShift max 0 } else { _timeShiftDefault };

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

private _prev = _obj getVariable ["DON_uc_handle", scriptNull];
if (!isNull _prev) then { terminate _prev; };

private _handle = [_obj, _routeToPlay] spawn BIS_fnc_unitPlay;
_obj setVariable ["DON_uc_handle", _handle, true];
_obj setVariable ["DON_uc_loop", _loop, true];
_obj setVariable ["DON_uc_route", _routeRef, true];
_obj setVariable ["DON_uc_timeShift", _shift, true];

if (_loop) then {
    [_obj, _routeRef, _loop, _shift] spawn {
        params ["_obj", "_routeRef", "_loop", "_shift"];
        waitUntil {
            uiSleep 0.1;
            isNull _obj || {
                private _h = _obj getVariable ["DON_uc_handle", scriptNull];
                scriptDone _h
            }
        };
        if (isNull _obj) exitWith {};
        if (!local _obj) exitWith {
            [_obj, _routeRef, _loop, _shift] remoteExecCall ["DON_fnc_ucPlayOnOwner", owner _obj];
        };
        [_obj, _routeRef, _loop, _shift] call DON_fnc_ucPlayOnOwner;
    };
};

_handle
