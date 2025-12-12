// === Día 3 — initPlayerLocal.sqf ===
// Intro (local) + reproductor de música (obedece al servidor)

uiNamespace setVariable ["UMB_introActive", false];

// ----- Reproductor local que respeta la intro y APLAZA si hace falta -----
missionNamespace setVariable ["UMB_fnc_musicPlay", {
  params ["_track","_fadeOut","_fadeIn"];
  if (isNil "_fadeOut") then { _fadeOut = 0.6 };
  if (isNil "_fadeIn")  then { _fadeIn  = 1.0 };

  if (uiNamespace getVariable ["UMB_introActive", false]) exitWith {
    missionNamespace setVariable ["UMB_music_pending", [_track,_fadeOut,_fadeIn]];
    if (isNull (missionNamespace getVariable ["UMB_music_waiter", scriptNull])) then {
      private _h = [] spawn {
        waitUntil { uiSleep 0.1; !(uiNamespace getVariable ["UMB_introActive", false]) };
        private _p = missionNamespace getVariable ["UMB_music_pending", []];
        missionNamespace setVariable ["UMB_music_waiter", scriptNull];
        if (_p isEqualType [] && {count _p == 3}) then {
          _p params ["_t","_fo","_fi"];
          _fo fadeMusic 0; uiSleep _fo; playMusic _t; _fi fadeMusic 1;
        };
      };
      missionNamespace setVariable ["UMB_music_waiter", _h];
    };
  };

  _fadeOut fadeMusic 0; uiSleep _fadeOut; playMusic _track; _fadeIn fadeMusic 1;
}];

// === INTRO (solo primera vez de este jugador) ===
private _doIntro = !(player getVariable ["umb_introDone", false]);
if (_doIntro) then {
  player setVariable ["umb_introDone", true];

  [] spawn {
    uiNamespace setVariable ["UMB_introActive", true];
    disableSerialization;

    private _layer = "UMB_INTRO_LAYER" call BIS_fnc_rscLayer;
    _layer cutRsc ["UMB_Intro", "PLAIN", 0, false];

    waitUntil { !(isNull (uiNamespace getVariable ["UMB_Intro", displayNull])) };
    private _disp      = uiNamespace getVariable ["UMB_Intro", displayNull];
    private _ctrlTitle = _disp displayCtrl 1003;
    private _ctrlBody  = _disp displayCtrl 1004;
    private _logo      = _disp displayCtrl 1001;
    _logo ctrlSetText "umbrella_logo.jpg";

    _ctrlTitle ctrlSetFade 1; _ctrlTitle ctrlCommit 0;
    _ctrlBody  ctrlSetFade 1; _ctrlBody  ctrlCommit 0;

    // Música de intro: intro.ogg (umb_intro_music)
    0 fadeMusic 0; playMusic "umb_intro_music"; 2 fadeMusic 1;

    _logo ctrlSetFade 1; _logo ctrlCommit 0;
    _logo ctrlSetFade 0; _logo ctrlCommit 0.8;

    // Preroll corto
    private _preRoll = 3.50;
    private _startF = diag_frameNo;
    waitUntil { diag_frameNo > _startF + 24 };
    uiSleep _preRoll;

    // ===== Control de presupuesto de tiempo =====
    private _INTRO_MAX = 128;  // 2 min 8 s (tope duro)
    private _introStart = diag_tickTime;
    private _deadline   = _introStart + _INTRO_MAX;

    // Helpers
    UMB_fnc_showTitle = { params ["_ctrl","_html","_fade"]; _ctrl ctrlSetStructuredText parseText _html; _ctrl ctrlSetFade 0; _ctrl ctrlCommit _fade; };
    UMB_fnc_strReplace = { params ["_s","_w","_r"]; private _o=_s; private _i=_o find _w; while {_i>-1} do { _o=(_o select [0,_i])+_r+(_o select [_i+count _w]); _i=_o find _w; }; _o; };
    UMB_fnc_typeBody = {
      params ["_ctrl","_plain","_dUnused"];
      private _open="<t font='PuristaLight' size='1.08' color='#DADADA' align='center'>"; private _close="</t>";
      private _html=[_plain,"\n","<br/>"] call UMB_fnc_strReplace;
      _ctrl ctrlSetStructuredText parseText (_open+_html+_close);
    };

    // ===== Slides DÍA 3 (narrativo) =====
    private _fadeTitle  = 0.30;
    private _perSlideFX = _fadeTitle + 0.10;
    private _finalFade  = 2.00;

    // Tiempos de lectura por slide (≈ los del Día 2)
    private _holds = [18,19,19,18,18,19];

    private _slides = [
      // 1) Día 2 · Resumen (final más militar)
      [
        "<t font='PuristaSemibold' size='1.40' color='#FFFFFF'>DÍA 2 · RESUMEN</t>",
        "Ayer asegurasteis los núcleos en superficie y redujisteis la presión de la biomasa sobre el sector. La actividad residual confirma presencia en niveles inferiores. Hoy se actúa sobre ese origen."
      ],
      // 2) Día 3 · Área de operaciones / inserción
      [
        "<t font='PuristaSemibold' size='1.40' color='#FFFFFF'>DÍA 3 · ÁREA DE OPERACIONES</t>",
        "Os encontráis en un complejo subterráneo CLASIFICADO de Umbrella, señalado por Inteligencia como PUNTO CERO de la biomasa. Despertáis en una galería de servicio a ~2 km del acceso principal; desde ahí tomaréis vehículos internos y avanzaréis por el túnel hasta la sección de laboratorio. Mismo método que en el Día 2: localizar núcleos de biomasa amarillentos, colocar las cargas y detonarlas."
      ],
      // 3) Comportamiento de los núcleos / ventana 10 minutos
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>NÚCLEOS Y VENTANA DE ACTUACIÓN</t>",
        "Los núcleos amarillentos mantienen el mismo comportamiento observado: al perturbarlos pueden generar alucinaciones. Desde la PRIMERA alucinación disponéis de un MÁXIMO de 10 MINUTOS para limpiar la zona, colocar los explosivos, detonar y abandonar el punto. Rebasar esa ventana implica riesgo alto de bajas."
      ],
      // 4) Seguridad / contacto con biomasa
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>SEGURIDAD</t>",
        "Evitad el contacto con la biomasa en todo momento. Las formaciones pequeñas o medianas pueden tolerarse con máscara de gas si el tiempo de exposición es corto. Las formaciones de gran tamaño NO se tocan ni se atraviesan: se bordean y se informa."
      ],
      // 5) Comunicaciones
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>COMUNICACIONES</t>",
        "Canal 50 para táctico, reportes de situación y confirmación de detonaciones. Mensajes breves y claros: unidad, posición en túnel, estado y siguiente objetivo."
      ],
      // 6) Cierre / prioridades
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>CIERRE DE OPERACIÓN</t>",
        "Umbrella pretende restaurar el control del sector neutralizando este punto. Si el laboratorio queda comprometido o la ruta de salida se cierra, prioridad absoluta: supervivencia de la unidad y destrucción del material sensible."
      ]
    ];

    {
      private _t = _x#0;
      private _b = _x#1;
      [_ctrlTitle, _t, _fadeTitle] call UMB_fnc_showTitle;
      uiSleep _perSlideFX;
      _ctrlBody ctrlSetFade 0; _ctrlBody ctrlCommit 0; _ctrlBody ctrlSetStructuredText parseText "";
      [_ctrlBody, _b, 0] call UMB_fnc_typeBody;
      sleep (_holds select _forEachIndex);
    } forEach _slides;

    // Ajuste fino
    private _remain = (_deadline - diag_tickTime) - _finalFade;
    if (_remain > 0) then { uiSleep _remain max 0; };

    // Fade-out suave de UI + música y corte final
    2 fadeMusic 0;
    _logo ctrlSetFade 1; _logo ctrlCommit 1.0;
    _ctrlTitle ctrlSetFade 1; _ctrlTitle ctrlCommit 0.9;
    _ctrlBody  ctrlSetFade 1; _ctrlBody  ctrlCommit 0.9;
    uiSleep 2.0; playMusic "";

    _layer cutRsc ["Default", "PLAIN", 0, false];
    cutText ["", "BLACK IN", 0];

    // Fallback: enganchar la música del servidor si ya está emitida
    [] spawn {
      private _deadline2 = diag_tickTime + 30;
      waitUntil {
        uiSleep 0.25;
        !(uiNamespace getVariable ["UMB_introActive", false]) &&
        ((missionNamespace getVariable ["UMB_music_current",""]) != "" || diag_tickTime > _deadline2)
      };
      private _t = missionNamespace getVariable ["UMB_music_current",""];
      if (_t != "") then {
        [_t, 0, 1] call (missionNamespace getVariable "UMB_fnc_musicPlay");
      };
    };
    uiNamespace setVariable ["UMB_introActive", false];
  };
} else {
  // Si ya estaba vista: mismo fallback sin mostrar intro
  [] spawn {
    private _deadline = diag_tickTime + 30;
    waitUntil {
      uiSleep 0.25;
      !(uiNamespace getVariable ["UMB_introActive", false]) &&
      ((missionNamespace getVariable ["UMB_music_current",""]) != "" || diag_tickTime > _deadline)
    };
    private _t = missionNamespace getVariable ["UMB_music_current",""];
    if (_t != "") then {
      [_t, 0, 1] call (missionNamespace getVariable "UMB_fnc_musicPlay");
    };
  };
};

// ----- (Día 3) SIN StartBox / SIN lanzamiento de LB -----
// Aquí se puede añadir otro addAction específico del Día 3 si luego lo necesitas.
