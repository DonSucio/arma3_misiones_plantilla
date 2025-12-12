/*
    fn_loadConfig.sqf
    Carga el fichero editable "para tontos" don_config.sqf UNA vez.
*/

if (missionNamespace getVariable ["DON_configLoaded", false]) exitWith { true };
missionNamespace setVariable ["DON_configLoaded", true ];

// Ejecuta config editable
call compile preprocessFileLineNumbers "don_config.sqf";

true
