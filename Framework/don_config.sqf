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
// DIARIO "LOS AHMED"
// ===============================
DON_diary_enabled = true;



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
