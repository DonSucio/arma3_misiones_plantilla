/*
    fn_postInit.sqf
    Se ejecuta automáticamente por CfgFunctions (postInit=1).
    Si además tienes initPlayerLocal/initServer como stubs, este guard evita dobles.
*/

// Server init
if (isServer) then {
    [] call DON_fnc_initServer;
};

// Client init
if (hasInterface) then {
    [] call DON_fnc_initPlayerLocal;
};
