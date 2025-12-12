// === Día 2 — initPlayerLocal.sqf ===
// Intro (local) + reproductor de música (obedece al servidor) + StartBox

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

    // Preroll corto para no comerse presupuesto
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
      // Pintado inmediato (sin “typewriter”) para que los tiempos sean estables
      params ["_ctrl","_plain","_dUnused"];
      private _open="<t font='PuristaLight' size='1.08' color='#DADADA' align='center'>"; private _close="</t>";
      private _html=[_plain,"\n","<br/>"] call UMB_fnc_strReplace;
      _ctrl ctrlSetStructuredText parseText (_open+_html+_close);
    };

    // ===== Slides DÍA 2 (narrativo) =====
    private _fadeTitle  = 0.30;              // fade-in de título por slide
    private _perSlideFX = _fadeTitle + 0.10; // pausa breve tras título
    private _finalFade  = 2.00;              // fade out música/UI final

    // Tiempos de lectura por slide (suman ~112 s)
    private _holds = [18,19,20,18,18,19];

    private _slides = [
      // 1) Día 1 · Resumen (narrativo, sin bloque de "Inteligencia")
      [
        "<t font='PuristaSemibold' size='1.40' color='#FFFFFF'>DÍA 1 · RESUMEN</t>",
        "Ayer despertasteis fuera de servicio en una base, cuando los rumores de un brote pasaron a ser llamadas reales. La situación escaló en minutos y, entre apagones y civiles alterados, lograsteis rescatar a tres científicos — Isidro Gamos Alcura, Cevino Sobretti y Solomeo Paredes — cerrando el día con la extracción completada y el equipo listo para el siguiente paso."
      ],
      // 2) Día 2 · Ubicación clasificada
      [
        "<t font='PuristaSemibold' size='1.40' color='#FFFFFF'>DÍA 2 · UBICACIÓN CLASIFICADA</t>",
        "Entramos en un nuevo escenario con varios focos activos: nuestra misión es frenar la expansión neutralizando los núcleos en superficie. El tiempo en zona y la munición cuentan; priorizad los marcados en el mapa y manteneos móviles."
      ],
      // 3) Situación actual — alucinaciones y ventana de 10 min
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>SITUACIÓN ACTUAL</t>",
        "La biomasa crece con agresividad y devora terreno; al perturbarla, algunos núcleos expulsan esporas. Al establecer contacto con los NÚCLEOS se han observado alucinaciones: desde el primer síntoma, disponéis de un MÁXIMO de 10 minutos para colocar las cargas, detonar y alejaros de la zona. No apuréis ese margen: entrad, actuad y salid."
      ],
      // 4) Objetivo — sin confirmación ni secundarios
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>OBJETIVO</t>",
        "Neutralizar los NÚCLEOS de biomasa (≈5 posiciones marcadas). Procedimiento: asegurar el perímetro, localizar el núcleo, colocar las cargas en la base y detonar. Tras la explosión, romper contacto y continuar con el siguiente objetivo."
      ],
      // 5) Despliegue — canal 50 y bengalas rojas
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>DESPLIEGUE</t>",
        "Salida desde buque de Umbrella e inserción en CUATRO Little Bird (LB1–LB4) con bancos laterales. Mantener enlace por CANAL 50 para contactar con TÁCTICO y reportar tras cada detonación. Marcar objetivos confirmados con BENGALAS ROJAS para bombardeo por misiles balísticos."
      ],
      // 6) Recordatorio — tamaños y máscara
      [
        "<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>RECORDATORIO</t>",
        "Las masas GIGANTES — macro-biomasa — NO se tocan bajo ningún concepto. Las formaciones del tamaño de un vehículo o de una casa pequeña no han mostrado efectos agudos si se lleva MÁSCARA DE GAS, pero evitad el contacto innecesario. Si es descomunal, no os acerquéis: no la toquéis, no la probéis, no la respiréis."
      ]
    ];

    // Overhead fijo: prerroll + (título/pausa por slide) + fade final
    private _overhead = _preRoll + (count _slides * _perSlideFX) + _finalFade;

    {
      private _t = _x#0;
      private _b = _x#1;
      [_ctrlTitle, _t, _fadeTitle] call UMB_fnc_showTitle;
      uiSleep _perSlideFX;
      _ctrlBody ctrlSetFade 0; _ctrlBody ctrlCommit 0; _ctrlBody ctrlSetStructuredText parseText "";
      [_ctrlBody, _b, 0] call UMB_fnc_typeBody;
      sleep (_holds select _forEachIndex);
    } forEach _slides;

    // Ajuste fino para coincidir con fin de la pista y no pasar de 2:08
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

// ----- StartBox: UN SOLO BOTÓN -----
[] spawn {
  waitUntil { !isNull player };
  waitUntil { !isNil "StartBox" && {!isNull StartBox} };

  StartBox addAction [
    "▶ Lanzar despliegue (LB1 + LB2 + LB3 + LB4)",
    { [] remoteExec ["UMB_fnc_startLB1234", 2]; },
    nil, 1.5, true, true, "", "true"
  ];
};
