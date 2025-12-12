/*
    fn_onPlayerRespawn.sqf
    Wrapper para onPlayerRespawn.sqf
*/
params ["_unit", "_corpse"];

// Volvemos el sonido a la normalidad poco a poco
2 fadeSound 1;

// Quitamos el negro
cutText ["", "BLACK IN", 2];
