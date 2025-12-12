/*
    DON Framework - GRAD Persistence config (description.ext)
    --------------------------------------------------------
    - Este fichero recoge TU configuración de persistencia en formato "include".
    - La lista gigante de blacklist se guarda aparte en gradPersistence_blacklist.hpp.

    NOTA:
    - Si DON_ENABLE_GRAD_PERSISTENCE = 0, este fichero no define nada y no estorba.
*/

#include "..\..\config\don_defines.hpp"

#if DON_ENABLE_GRAD_PERSISTENCE

class CfgGradPersistence {
    missionTag = "BaseInstruccion_UAEHoplita_v003_PERSISTENCIA";
    loadOnMissionStart = 1;
    missionWaitCondition = "true";
    playerWaitCondition = "true";
    saveUnits = 3;
    saveVehicles = 1;
    saveContainers = 2;
    saveStatics = 0;
    saveGradFortificationsStatics = 3;
    saveMarkers = 3;
    saveTasks = 0;
    saveTriggers = 0;
    savePlayerInventory = 1;
    savePlayerDamage = 1;
    savePlayerPosition = 1;
    savePlayerMoney = 1;
    saveTeamAccounts = 1;
    saveTimeAndDate = 1;

    // --- AQUÍ VA TU LISTA GIGANTE DE CLASES ---
    // Copia/pega directamente todo tu array blacklist[] completo dentro de estas llaves.
    blacklist[] = {
        #include "gradPersistence_blacklist.hpp"
    };
// === GRAD Fortifications + Persistence: inventario virtual ===
    class customVariables {
        class gradFortificationsVehicleInventory {
            varName = "grad_fortifications_myFortifications";
            varNamespace = "vehicle";
            public = 1;
        };
        class gradFortificationsContainerInventory {
            varName = "grad_fortifications_myFortifications";
            varNamespace = "container";
            public = 1;
        };
        class gradFortificationsPlayerInventory {
            varName = "grad_fortifications_myFortifications";
            varNamespace = "player";
            public = 1;
        };
        class gradFortificationsUnitInventory {
            varName = "grad_fortifications_myFortifications";
            varNamespace = "unit";
            public = 1;
        };
    };
};



// ======================================================
// >>> CONFIGURACIÓN GRAD FORTIFICATIONS
// ======================================================

#endif
