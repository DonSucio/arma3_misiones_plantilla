/*
    DON Framework - Config de GRAD Fortifications
    ---------------------------------------------
    Configuración completa aportada por el usuario. Se incluye solo si
    DON_ENABLE_GRAD_FORTIFICATIONS está a 1 en don_defines.hpp.
*/

#include "..\\config\\don_defines.hpp"

#if DON_ENABLE_GRAD_FORTIFICATIONS

// GRAD Persistence + GRAD Fortifications: inventario virtual
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

// Configuración GRAD Fortifications
class CfgGradFortifications {
    // ---- Ajustes generales ----
    boundingBoxSizeFactor      = 1;
    buildTimeFactor            = 1;
    demolishTimeFactor         = 1;
    packUpTimeFactor           = 1;

    playerInventorySize        = 50;   // Capacidad inventario virtual del jugador
    vehicleInventorySizeFactor = 1;    // Factor general para vehículos

    canDemolishDefault         = 1;
    canPackUpDefault           = 1;

    canStoreInLandVehicles     = 1;
    canStoreInShips            = 0;
    canStoreInHelicopters      = 0;
    canStoreInPlanes           = 0;
    canStoreInContainers       = 1;

    fortificationOwnerType     = "BUILDER"; // dueño = el que la coloca

    // --------------------------------------------------
    // FORTIFICACIONES
    // --------------------------------------------------
    class Fortifications {
        // 1) Muro de sacos largo
        class Land_BagFence_Long_F {
            size              = 3;
            buildTime         = 5;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        // 2) H-Barrier 3 bloques
        class Land_HBarrier_3_F {
            size              = 8;
            buildTime         = 10;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        // 3) Bunker pequeño de sacos
        class Land_BagBunker_Small_F {
            size              = 15;
            buildTime         = 20;
            canDemolish       = 1;
            canPackUp         = 0; // solo demoler
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        // === Tus objetos extra ===
        class TFAR_Land_Communication_F {
            size              = 10;
            buildTime         = 10;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_HBarrier_Big_F {
            size              = 15;
            buildTime         = 15;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_Fort_Watchtower_EP1 {
            size              = 20;
            buildTime         = 25;
            canDemolish       = 1;
            canPackUp         = 0;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_HBarrierWall_corridor_F {
            size              = 15;
            buildTime         = 15;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_HBarrierWall6_F {
            size              = 15;
            buildTime         = 15;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_HBarrier_5_F {
            size              = 12;
            buildTime         = 12;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_CncWall4_F {
            size              = 8;
            buildTime         = 10;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_CamoNetVar_NATO_EP1 {
            size              = 8;
            buildTime         = 8;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_ConnectorTent_01_NATO_open_F {
            size              = 15;
            buildTime         = 18;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_MedicalTent_01_NATO_generic_open_F {
            size              = 18;
            buildTime         = 20;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_fort_rampart_EP1 {
            size              = 20;
            buildTime         = 25;
            canDemolish       = 1;
            canPackUp         = 0;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_Razorwire_F {
            size              = 5;
            buildTime         = 6;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_HBarrierTower_F {
            size              = 20;
            buildTime         = 25;
            canDemolish       = 1;
            canPackUp         = 0;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_CncBarrierMedium_F {
            size              = 6;
            buildTime         = 6;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_CncBarrierMedium4_F {
            size              = 8;
            buildTime         = 8;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_CncBlock {
            size              = 5;
            buildTime         = 5;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };

        class Land_BarGate_F {
            size              = 8;
            buildTime         = 8;
            canDemolish       = 1;
            canPackUp         = 1;
            onBuildComplete   = "(_this select 1) enableSimulationGlobal false;";
        };
    };

    // --------------------------------------------------
    // VEHÍCULO VANILLA COMO ALMACÉN DE FORTIFICACIONES
    // --------------------------------------------------
    class Vehicles {
        // Camión HEMTT Box BLUFOR (NATO)
        class B_Truck_01_box_F {
            isStorage            = 1;   // Puede almacenar fortificaciones
            vehicleInventorySize = 40;  // Capacidad virtual concreta
        };
    };
};

#endif
