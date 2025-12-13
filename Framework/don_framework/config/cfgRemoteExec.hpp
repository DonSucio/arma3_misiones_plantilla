/*
    cfgRemoteExec.hpp (opcional)
    ----------------------------
    Whitelist mínima para el módulo de Unit Capture cuando usas CfgRemoteExec mode=2.
    Si ya tienes tu propio CfgRemoteExec en la misión, copia/mergea solo las clases DON_fnc_*.
*/

class CfgRemoteExec {
    mode = 2;    // Solo funciones whitelisteadas
    jip  = 1;

    class Functions {
        class DON_fnc_ucDispatchFromLaptop { allowedTargets = 2; jip = 0; };
        class DON_fnc_ucPlayOnOwner        { allowedTargets = 0; jip = 1; };
        class DON_fnc_ucStop               { allowedTargets = 0; jip = 1; };
    };
};
