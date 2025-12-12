/*
    fn_initServer.sqf
    Entry-point de servidor.

    Nota: tu initServer subido al chat venía con "..." (contenido recortado),
    así que aquí dejo una base limpia + un bloque configurable para congelar simulación.
*/
if (!isServer) exitWith {};

if (missionNamespace getVariable ["DON_serverInited", false]) exitWith {};
missionNamespace setVariable ["DON_serverInited", true];

[] call DON_fnc_loadConfig;

// Array global de objetivos emergentes (si lo usas en scripts)
if (isNil "popTargets") then {
    popTargets = [];
};

// ----------------------------------------------------------
// Congelar simulación de tipos concretos (configurable)
// ----------------------------------------------------------
private _freezeTypes = missionNamespace getVariable ["DON_freezeSimulation_types", []];
if ((count _freezeTypes) > 0) then {

    // 1) Objetos que ya existen al arrancar
    {
        if ((typeOf _x) in _freezeTypes) then {
            _x enableSimulationGlobal false;
        };
    } forEach allMissionObjects "All";

    // 2) Objetos nuevos durante la misión (Zeus / scripts / etc.)
    addMissionEventHandler ["EntityCreated", {
        params ["_ent"];
        private _freezeTypes = missionNamespace getVariable ["DON_freezeSimulation_types", []];
        if ((typeOf _ent) in _freezeTypes) then {
            _ent enableSimulationGlobal false;
        };
    }];
};
