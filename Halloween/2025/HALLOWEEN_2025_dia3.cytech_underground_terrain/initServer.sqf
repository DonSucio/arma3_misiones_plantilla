// === Día 3 — initServer.sqf ===
// Música: UN SOLO TEMA (15 min) en bucle
// Se elimina: apagado de farolas + funciones/rutas de LB

if (!isServer) exitWith {};

// ----------------- Música: UNA PISTA en bucle (15 min) -----------------
private _track = "umb_chill_15_00";
private _len   = 900; // segundos

// Comprobación por si acaso
if !(isClass (missionConfigFile >> "CfgMusic" >> _track)) then {
  diag_log format ["[UMB][MUSIC] ¡ATENCIÓN! La clase %1 no existe en missionConfigFile >> CfgMusic.", _track];
};

// Publica estado inicial
UMB_music_current = "";
UMB_music_endTime = 0;
publicVariable "UMB_music_current";
publicVariable "UMB_music_endTime";

// Bucle infinito: publica estado y ordena reproducir en clientes; repite cada 15 min
[_track, _len] spawn {
  params ["_track","_len"];
  while { true } do {
    missionNamespace setVariable ["UMB_music_current", _track, true];
    missionNamespace setVariable ["UMB_music_endTime", diag_tickTime + _len, true];
    [_track, 0.6, 1.0] remoteExec ["UMB_fnc_musicPlay", -2, true];  // CLIENTES + JIP
    sleep (_len max 1);
  };
};
