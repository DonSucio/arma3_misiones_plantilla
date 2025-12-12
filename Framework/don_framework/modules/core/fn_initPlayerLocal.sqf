/*
    fn_initPlayerLocal.sqf
    Entry-point de cliente.
*/
if (!hasInterface) exitWith {};

if (missionNamespace getVariable ["DON_clientInited", false]) exitWith {};
missionNamespace setVariable ["DON_clientInited", true];

// Carga config editable
[] call DON_fnc_loadConfig;

// Rutas de unitCapture (cámara, IA, vehículos)
[] call DON_fnc_ucRegisterRoutes;

// Acciones de portátiles declaradas en Eden (DON_uc_actions)
[] spawn {
    if !(missionNamespace getVariable ["DON_unitCapture_enabled", false]) exitWith {};
    uiSleep 0.5;

    private _fnc_tryAdd = {
        params ["_obj"]; 
        if (isNull _obj) exitWith {};
        private _actions = _obj getVariable ["DON_uc_actions", []];
        if (_actions isEqualType [] && {count _actions > 0}) then {
            [_obj] call DON_fnc_ucAddLaptopActions;
        };
    };

    { [_x] call _fnc_tryAdd; } forEach allMissionObjects "All";

    addMissionEventHandler ["EntityCreated", {
        params ["_ent"];
        private _actions = _ent getVariable ["DON_uc_actions", []];
        if (_actions isEqualType [] && {count _actions > 0}) then {
            [_ent] call DON_fnc_ucAddLaptopActions;
        };
    }];
};

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

if (missionNamespace getVariable ["DON_intro_sequence_enabled", false]) then {
    [] call DON_fnc_introSequence;
} else {
    if (missionNamespace getVariable ["DON_intro_enabled", true]) then {
        [] call DON_fnc_introRP;
    };
};

if (missionNamespace getVariable ["DON_diary_enabled", true]) then {
    [] call DON_fnc_diaryLosAhmed;
};
