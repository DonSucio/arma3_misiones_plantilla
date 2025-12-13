/*
    fn_ucAddLaptopActions.sqf

    Lee laptopObj getVariable ["DON_uc_actions", []] y añade addAction para reproducir/stop rutas.
    Formatos soportados:
    - Simple (compat): [texto, targetRef, routeName, loop?, timeShift?, startDelay?]
    - Batch recomendado: [texto, [ [targetRef, routeName, loop?, timeShift?, startDelay?], ... ], "play"|"stop"]
*/
params ["_laptop"];

if (!hasInterface) exitWith {};
if (isNull _laptop) exitWith {};

private _actions = _laptop getVariable ["DON_uc_actions", []];
if !(_actions isEqualType [] && {count _actions > 0}) exitWith {};

private _key = format ["DON_uc_actions_added_%1", netId _laptop];
if (missionNamespace getVariable [_key, false]) exitWith {};
missionNamespace setVariable [_key, true];

private _fnc_normalizeEntry = {
    params ["_entry"];
    if !(_entry isEqualType []) exitWith { objNull };
    private _targetRef = _entry param [0, objNull, [objNull, ""]];
    private _routeName = _entry param [1, "", [""]];
    private _loop = _entry param [2, nil, [true]];
    private _timeShift = _entry param [3, nil, [0]];
    private _startDelay = _entry param [4, 0, [0]];
    if (_targetRef isEqualType "" && {_targetRef isEqualTo ""}) exitWith { objNull };
    if (_targetRef isEqualType objNull && {isNull _targetRef}) exitWith { objNull };
    [_targetRef, _routeName, _loop, _timeShift, _startDelay]
};

{
    if !(_x isEqualType []) then { continue };

    private _title = "";
    private _mode = "play";
    private _batch = [];

    // Compat: [title, targetRef, route, loop?, timeShift?, startDelay?]
    if ((count _x) >= 3 && {!((_x#1) isEqualType [])}) then {
        _x params ["_titleCmp", "_targetRef", "_routeName", ["_loopCmp", nil], ["_timeShiftCmp", nil], ["_delayCmp", 0], ["_modeCmp", "play"]];
        _title = _titleCmp;
        _batch = [[_targetRef, _routeName, _loopCmp, _timeShiftCmp, _delayCmp]];
        if (_modeCmp isEqualType "") then { _mode = toLower _modeCmp; };
    } else {
        _x params ["_titleCfg", ["_batchCfg", []], ["_modeCfg", "play"]];
        _title = _titleCfg;
        _batch = _batchCfg;
        if (_modeCfg isEqualType "") then { _mode = toLower _modeCfg; };
    };

    if (!(_title isEqualType "") || {_title isEqualTo ""}) then { continue };
    if !(_batch isEqualType [] && {count _batch > 0}) then { continue };

    private _normalized = [];
    {
        private _entry = [_x] call _fnc_normalizeEntry;
        if !(_entry isEqualType []) then { continue };
        _normalized pushBack _entry;
    } forEach _batch;

    if ((count _normalized) == 0) then { continue };

    _laptop addAction [
        _title,
        {
            params ["_target", "_caller", "_id", "_args"];
            _args params ["_payload"];
            if (isServer) then {
                [_payload, _caller] call DON_fnc_ucDispatchFromLaptop;
            } else {
                [_payload, _caller] remoteExecCall ["DON_fnc_ucDispatchFromLaptop", 2];
            };
        },
        [[_mode, _normalized, _title]],
        1.5,
        true,
        true,
        "",
        "true",
        5
    ];
} forEach _actions;
