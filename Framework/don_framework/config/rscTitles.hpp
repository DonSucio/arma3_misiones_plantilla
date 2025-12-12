/*
    don_framework\config\rscTitles.hpp
    -----------------------------------
    UI/overlays. De momento solo incluye RP_Intro.
    Para añadir más overlays: crea un .hpp en un módulo y lo incluyes aquí.
*/

class RscTitles {
    class Default {
        idd = -1;
        fadein = 0;
        fadeout = 0;
        duration = 0;
    };

    // === RP — Intro de rol permanente ===
    // Sin música de fondo y sin imagen de fondo. Solo texto sobre negro.
    class RP_Intro {
        idd = -1;
        duration = 1e10;                       // La cerramos por script
        movingEnable = 0;
        onLoad = "uiNamespace setVariable ['RP_Intro', _this select 0]";
        fadein = 0;
        fadeout = 0;

        class controls {
            // Fondo negro a pantalla completa
            class RP_BG {
                idc = 1000;
                type = 0;                      // CT_STATIC
                style = 0;
                x = safeZoneX;
                y = safeZoneY;
                w = safeZoneW;
                h = safeZoneH;
                colorBackground[] = {0,0,0,1}; // Negro opaco
                colorText[] = {0,0,0,0};
                text = "";
                font = "PuristaMedium";
                sizeEx = 0;
            };

            // Título (ROL PERMANENTE)
            class RP_Title {
                idc = 1003;
                type = 13;                     // RscStructuredText
                style = 0;
                x = safeZoneX + safeZoneW*0.08;
                y = safeZoneY + safeZoneH*0.15;
                w = safeZoneW*0.84;
                h = safeZoneH*0.14;
                text = "";
                size = 0.06;
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                class Attributes {
                    align = "center";
                    color = "#FFFFFF";
                    font  = "PuristaSemibold";
                };
            };

            // Cuerpo (normas de rol)
            class RP_Body {
                idc = 1004;
                type = 13;                     // RscStructuredText
                style = 0;
                x = safeZoneX + safeZoneW*0.10;
                y = safeZoneY + safeZoneH*0.30;
                w = safeZoneW*0.80;
                h = safeZoneH*0.52;
                text = "";
                size = 0.05;
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                class Attributes {
                    align = "center";
                    color = "#DADADA";
                    font  = "PuristaLight";
                };
            };
        };
    };

};
