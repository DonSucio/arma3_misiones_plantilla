/*
    don_config.sqf (EDITA AQUÍ)
    -----------------------------
    Fichero "para tontos": cambia textos y activa/desactiva módulos.
    Se ejecuta automáticamente en cliente y servidor (si usas el framework).
*/

// ===============================
// INTRO DE ROL (RP_Intro)
// ===============================
DON_intro_enabled  = true;
DON_intro_duration = 30;  // segundos

// Título (texto plano)
DON_intro_title = "ROL PERMANENTE — NUNCA SALGAS DE PERSONAJE";

// Cuerpo (lista de líneas; el framework las formatea)
DON_intro_body_lines = [
    "• Nunca salgas de personaje.",
    "• No uses información OOC/metagaming.",
    "• Si tienes dudas, pregunta por radio.",
    "• Respeta la cadena de mando y el ambiente."
];

// Si prefieres meter HTML/StructuredText a mano, usa esto (y se ignoran las líneas):
// DON_intro_body_html = "<t align='center'>Texto con <br/> saltos</t>";

// ===============================
// INTRO CINEMÁTICA + MÚSICA
// ===============================
DON_intro_sequence_enabled = false;         // Activa la intro con cámara + música
DON_intro_sequence_playRP  = true;          // Llama también a la intro RP anterior

// Cámara: recorre una ruta capturada declarada en DON_unitCapture_routes
DON_intro_sequence_routeName   = "";       // Ej: "intro_cam"
DON_intro_sequence_loop        = false;     // Repite la ruta de cámara
DON_intro_sequence_timeShift   = 0;         // Recorte del arranque (segundos)

// Música: usa una clase de CfgMusic definida en description.ext
DON_intro_music_enabled = false;
DON_intro_music_track   = "";              // Clase de CfgMusic (ej: "DON_HalloweenTheme")
DON_intro_music_volume  = 1;                // 0-1
DON_intro_music_fadeIn  = 3;                // Segundos de fundido de entrada
DON_intro_music_loop    = true;             // Repite al terminar

// ===============================
// WHITELIST POR SLOT
// ===============================
DON_whitelist_enabled = true;
// Cómo funciona: en el init del slot (en Eden) pones:
// this setVariable ["allowedUIDs", ["7656...","7656..."], true];

// ===============================
// 3ª PERSONA POR SLOT
// ===============================
DON_thirdPersonLock_enabled = true;
// En el init del slot (Eden) si quieres permitir 3ª persona:
// this setVariable ["allowThirdPerson", true, true];

// ===============================
// AMBIENTE (fauna/vida)
// ===============================
// enableEnvironment [animals, ambientSounds]
DON_environment_disableAnimals = true;   // false = deja animales
DON_environment_keepSounds     = true;   // true  = mantiene sonidos

// ===============================
// GRAD FORTIFICATIONS
// ===============================
DON_fortifications_enabled = false;  // Activa el wrapper del módulo (requiere DON_ENABLE_GRAD_FORTIFICATIONS=1)

// ===============================
// DIARIO "LOS AHMED"
// ===============================
DON_diary_enabled = true;


// ===============================
// UNIT CAPTURE (BIS_fnc_unitPlay)
// ===============================
DON_unitCapture_enabled = false;
DON_unitCapture_defaultLoop = false; // loop por defecto si no se especifica en cada ruta
DON_unitCapture_prepareVehicles = true; // prepara vehículos antes de unitPlay (motor, fuel, IA off) si está activo
// Formato: ["nombre", "rutaSQF", loop?, timeShiftSegundos]
DON_unitCapture_routes = [
    // ["lb1_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb1_lead.sqf", false, 0],
    // ["lb2_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb2_lead.sqf"]
];


// ===============================
// SERVER: congelar simulación (opcional)
// ===============================
// Si quieres que ciertas cajas/props no simulen físicas (para evitar que se muevan),
// añade aquí los classnames:
DON_freezeSimulation_types = [
    "Land_WoodenCrate_01_F"
    // "ACE_Box_Ammo",
    // "rhs_7ya37_1_single"
];
