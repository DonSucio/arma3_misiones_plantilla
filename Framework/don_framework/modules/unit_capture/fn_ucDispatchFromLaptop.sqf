/*
    fn_ucDispatchFromLaptop.sqf (servidor)

    Orquesta lotes de acciones de unitCapture con delays por target.
    _payload: [mode, [ [targetRef, routeRef, loop?, timeShift?, startDelay?], ... ], title]
*/
params ["_payload", ["_caller", objNull]];

if (!isServer) exitWith {
    [_payload, _caller] remoteExecCall ["DON_fnc_ucDispatchFromLaptop", 2];
};

if !(_payload isEqualType [] && {count _payload >= 2}) exitWith {};

_payload params ["_mode", ["_entries", []], ["_title", ""]];
if !(_entries isEqualType [] && {count _entries > 0}) exitWith {};
if (_mode isEqualType "") then { _mode = toLower _mode; } else { _mode = "play"; };

{
    if !(_x isEqualType []) then { continue };
    _x params ["_targetRef", ["_routeRef", "", ["", []]], ["_loop", nil, [true]], ["_timeShift", nil, [0]], ["_startDelay", 0, [0]]];

    if (_targetRef isEqualType "" && {_targetRef isEqualTo ""}) then { continue };
    if (_targetRef isEqualType objNull && {isNull _targetRef}) then { continue };

    [_targetRef, _routeRef, _loop, _timeShift, _mode, _startDelay] spawn {
        params ["_targetRef", "_routeRef", "_loop", "_timeShift", "_mode", ["_delay", 0]];
        uiSleep (_delay max 0);
        if (_mode isEqualTo "stop") exitWith {
            [_targetRef] call DON_fnc_ucStop;
        };
        [_targetRef, _routeRef, _loop, _timeShift] call DON_fnc_ucPlayOnOwner;
    };
} forEach _entries;
