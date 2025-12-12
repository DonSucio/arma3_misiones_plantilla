/*
    fn_onPlayerKilled.sqf
    Wrapper para onPlayerKilled.sqf (se ejecuta localmente en el jugador que muere).
*/
// params array según engine; tu script no lo necesitaba, pero lo aceptamos:
params [["_unit", objNull], ["_killer", objNull], ["_instigator", objNull], ["_useEffects", true]];

// Pantalla a negro rápido
cutText ["", "BLACK OUT", 1];

// Bajamos casi todo el sonido
0 fadeSound 0.05;

sleep 1;

private _texto =
"============================\n" +
"      ESTÁS INCONSCIENTE\n" +
"============================\n\n" +
"Tu cuerpo herido e inconsciente\n" +
"está siendo devuelto a la\n" +
"enfermería de la base mediante MEDEVAC...";

cutText [_texto, "BLACK FADED", 1, true];
