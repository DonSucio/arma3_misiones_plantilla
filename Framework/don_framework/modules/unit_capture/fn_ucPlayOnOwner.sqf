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
    [_obj, _routeRef, _loopOverride, _timeShift, true] remoteExecCall ["DON_fnc_ucPlayOnOwner", owner _obj];
    scriptNull
};

[_obj, _routeRef, _loopOverride, _timeShift] call DON_fnc_ucPlayLocal
