/*
    don_framework\config\cfgFunctions.hpp
    ---------------------------------------
    Registro de funciones. Aquí añades/quitas módulos del framework,
    y las misiones NO tienen que tocar initPlayerLocal/initServer si no quieren.
*/

class CfgFunctions {

    // --- Third party (GRAD, etc.) ---
    // OJO: rutas relativas desde don_framework\config\ -> raíz de misión (..\..)
    #include "don_defines.hpp"

    #if DON_ENABLE_GRAD_PERSISTENCE
        #include "..\..\modules\grad-persistence\cfgFunctions.hpp"
    #endif

    #if DON_ENABLE_GRAD_FORTIFICATIONS
        #include "..\..\modules\grad-fortifications\cfgFunctions.hpp"
    #endif
    class DON {
        tag = "DON";

        class core {
            file = "don_framework\modules\core";
            class postInit { postInit = 1; };   // Auto-arranque (opcional)
            class loadConfig {};
            class initPlayerLocal {};
            class initServer {};
            class onPlayerKilled {};
            class onPlayerRespawn {};
        };

        class intro_rp {
            file = "don_framework\modules\intro_rp";
            class introRP {};
        };

        class whitelist {
            file = "don_framework\modules\whitelist";
            class enforceSlotWhitelist {};
        };

        class camera {
            file = "don_framework\modules\camera";
            class lockThirdPersonBySlot {};
        };

        class environment {
            file = "don_framework\modules\environment";
            class applyClientEnvironment {};
        };

        class diary_los_ahmed {
            file = "don_framework\modules\diary_los_ahmed";
            class diaryLosAhmed {};
        };
    };
};
