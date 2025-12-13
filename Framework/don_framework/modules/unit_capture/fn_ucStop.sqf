/*
    fn_ucStop.sqf
    Detiene la reproducción de una ruta capturada en el objeto dado.
*/
params ["_objRef", ["_forcedLocal", false]];

private _obj = [_objRef] call DON_fnc_ucResolveObject;
if (isNull _obj) exitWith {};

if (!local _obj && {!_forcedLocal}) exitWith {
    [_obj, true] remoteExecCall ["DON_fnc_ucStop", owner _obj];
};

private _handle = _obj getVariable ["DON_uc_handle", scriptNull];
if (!isNull _handle) then { terminate _handle; };
_obj setVariable ["DON_uc_handle", scriptNull, true];
_obj setVariable ["DON_uc_loop", false, true];
_obj setVariable ["DON_uc_route", nil, true];
_obj setVariable ["DON_uc_timeShift", 0, true];
