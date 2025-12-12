/*
  initServer.sqf — Una única pista (15 min) en bucle, controlada por el servidor.
  - Publica estado para que los clientes puedan engancharse en cuanto salgan de la intro.
*/

[] spawn {
  // (Opcional) tu bloque de farolas
  private _center     = [worldSize/2, worldSize/2, 0];
  private _radius     = worldSize;
  private _lamps      = nearestObjects [_center, ["Lamps_base_F"], _radius];
  private _safeCenter = getMarkerPos "ZONA_ILUMINADA";
  private _safeRadius = 400;

  {
    if (_x distance2D _safeCenter > _safeRadius) then {
      [_x, false] remoteExecCall ["BIS_fnc_switchLamp", 0, _x];
    };
    if (_forEachIndex % 200 == 0) then { sleep 0.01; };
  } forEach _lamps;
};

if (!isServer) exitWith {};

private _track = "umb_chill_15_00";
private _len   = 900;  // segundos

// (opcional) comprobación
if !(isClass (missionConfigFile >> "CfgMusic" >> _track)) then {
  diag_log format ["[UMB][MUSIC] ¡ATENCIÓN! La clase %1 no existe en missionConfigFile >> CfgMusic.", _track];
};

// Bucle simple y sólido: publica estado y ordena reproducir en clientes. Repite cada 15 min.
[_track, _len] spawn {
  params ["_track","_len"];
  while { true } do {
    // publica estado para fallbacks/JIP
    missionNamespace setVariable ["UMB_music_current", _track, true];
    missionNamespace setVariable ["UMB_music_endTime", diag_tickTime + _len, true];

    // orden a clientes (JIP)
    [_track, 0.6, 1.0] remoteExec ["UMB_fnc_musicPlay", -2, true];

    sleep (_len max 1);
  };
};
