/*
    fn_initPlayerLocal.sqf
    Entry-point de cliente.
*/
if (!hasInterface) exitWith {};

if (missionNamespace getVariable ["DON_clientInited", false]) exitWith {};
missionNamespace setVariable ["DON_clientInited", true];

// Carga config editable
[] call DON_fnc_loadConfig;

// GRAD Fortifications (wrapper y chequeos)
[] call DON_fnc_initFortifications;

// Módulos (activa/desactiva desde don_config.sqf)
if (missionNamespace getVariable ["DON_whitelist_enabled", true]) then {
    [] call DON_fnc_enforceSlotWhitelist;
};

[] call DON_fnc_applyClientEnvironment;

if (missionNamespace getVariable ["DON_thirdPersonLock_enabled", true]) then {
    [] call DON_fnc_lockThirdPersonBySlot;
};

if (missionNamespace getVariable ["DON_intro_enabled", true]) then {
    [] call DON_fnc_introRP;
};

if (missionNamespace getVariable ["DON_diary_enabled", true]) then {
    [] call DON_fnc_diaryLosAhmed;
};
