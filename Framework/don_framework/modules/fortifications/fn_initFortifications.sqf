#include "..\config\don_defines.hpp"
/*
    fn_initFortifications.sqf
    -------------------------
    Wrapper ligero para GRAD Fortifications. Se activa solo si
    DON_fortifications_enabled = true en don_config.sqf y el módulo
    está habilitado en don_defines.hpp.
*/

if (missionNamespace getVariable ["DON_fortifications_checked", false]) exitWith {
    missionNamespace getVariable ["DON_fortifications_active", false]
};
missionNamespace setVariable ["DON_fortifications_checked", true];

// Toggle editable (runtime)
if !(missionNamespace getVariable ["DON_fortifications_enabled", false]) exitWith {
    missionNamespace setVariable ["DON_fortifications_active", false];
    false
};

#ifndef DON_ENABLE_GRAD_FORTIFICATIONS
    diag_log "[DON] GRAD Fortifications: DON_ENABLE_GRAD_FORTIFICATIONS = 0 (don_defines.hpp).";
    missionNamespace setVariable ["DON_fortifications_active", false];
    false
#endif

// Comprobación blanda de disponibilidad del módulo (no vendoreamos libs)
private _gradFortificationsPresent = !isNil "grad_fortifications_fnc_registerNewFortification";
if (!_gradFortificationsPresent) exitWith {
    diag_log "[DON] GRAD Fortifications: faltan los ficheros en modules\\grad-fortifications (o mod cargado).";
    missionNamespace setVariable ["DON_fortifications_active", false];
    false
};

missionNamespace setVariable ["DON_fortifications_active", true];
true
