/*
    fn_applyClientEnvironment.sqf
    -----------------------------
    Basado en tu BLOQUE 2 (enableEnvironment).
*/
if (!hasInterface) exitWith {};

private _disableAnimals = missionNamespace getVariable ["DON_environment_disableAnimals", true];
private _keepSounds     = missionNamespace getVariable ["DON_environment_keepSounds", true];

// enableEnvironment [animals, ambientSounds]
enableEnvironment [!_disableAnimals, _keepSounds];
