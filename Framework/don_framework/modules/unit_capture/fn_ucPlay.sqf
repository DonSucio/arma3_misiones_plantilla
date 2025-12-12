/*
    fn_ucPlay.sqf (alias)

    Conserva compatibilidad con llamadas antiguas y redirige a DON_fnc_ucPlayOnOwner.
*/
params ["_objOrRef", "_routeRef", ["_loopOverride", nil], ["_timeShift", nil]];

[_objOrRef, _routeRef, _loopOverride, _timeShift] call DON_fnc_ucPlayOnOwner
