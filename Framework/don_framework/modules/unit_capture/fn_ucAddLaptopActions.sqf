/*
    fn_ucAddLaptopActions.sqf

    Lee laptopObj getVariable ["DON_uc_actions", []] y añade addAction para reproducir rutas.
    Formato de cada acción: [texto, targetRef, routeName, loop?, timeShift?]
*/
params ["_laptop"];

if (isNull _laptop) exitWith {};
if (!local _laptop) exitWith {};

private _actions = _laptop getVariable ["DON_uc_actions", []];
if !(_actions isEqualType [] && {count _actions > 0}) exitWith {};

if (_laptop getVariable ["DON_uc_actions_added", false]) exitWith {};
_laptop setVariable ["DON_uc_actions_added", true, false];

{
    if !(_x isEqualType [] && {count _x >= 3}) then { continue }; // [title, targetRef, routeName, loop?, timeShift?]
    _x params ["_title", "_targetRef", "_routeName", ["_loop", nil], ["_timeShift", nil]];
    if (!(_title isEqualType "") || {_title isEqualTo ""}) then { continue }; 
    if (!(_routeName isEqualType "") || {_routeName isEqualTo ""}) then { continue };

    _laptop addAction [
        _title,
        {
            params ["_target", "_caller", "_id", "_args"];
            _args params ["_targetRef", "_routeName", "_loop", "_timeShift"];
            [_targetRef, _routeName, _loop, _timeShift] call DON_fnc_ucPlayOnOwner;
        },
        [_targetRef, _routeName, _loop, _timeShift],
        1.5,
        true,
        true,
        "",
        "true",
        5
    ];
} forEach _actions;
