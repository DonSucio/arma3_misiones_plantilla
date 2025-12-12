/*
  initPlayerLocal.sqf — Intro local.
  - Los clientes NO deciden qué suena; obedecen órdenes del servidor.
  - Si llega una orden durante la intro, se APLAZA hasta salir.
  - Tras la intro hay FALLBACK: si por carrera no llegó la orden, lee el estado del servidor y arranca la pista.
*/

uiNamespace setVariable ["UMB_introActive", false];

// Reproductor local (respeta intro, con aplazado)
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

// === INTRO (solo primera vez) ===
private _doIntro = !(player getVariable ["umb_introDone", false]);
if (_doIntro) then {
  player setVariable ["umb_introDone", true];

  [] spawn {
    uiNamespace setVariable ["UMB_introActive", true];
    disableSerialization;

    private _layer = "UMB_INTRO_LAYER" call BIS_fnc_rscLayer;
    _layer cutRsc ["UMB_Intro", "PLAIN", 0, false];

    waitUntil { !(isNull (uiNamespace getVariable ["UMB_Intro", displayNull])) };
    private _disp  = uiNamespace getVariable ["UMB_Intro", displayNull];
    private _ctrlTitle = _disp displayCtrl 1003;
    private _ctrlBody  = _disp displayCtrl 1004;
    private _logo      = _disp displayCtrl 1001;

    _ctrlTitle ctrlSetFade 1; _ctrlTitle ctrlCommit 0;
    _ctrlBody  ctrlSetFade 1; _ctrlBody  ctrlCommit 0;

    0 fadeMusic 0; playMusic "umb_intro_music"; 2 fadeMusic 1;

    _logo ctrlSetFade 1; _logo ctrlCommit 0;
    _logo ctrlSetFade 0; _logo ctrlCommit 0.8;

    private _preRoll = 6.25; private _startF = diag_frameNo;
    waitUntil { diag_frameNo > _startF + 24 }; uiSleep _preRoll;

    // Helpers mínimos
    UMB_fnc_showTitle = { params ["_c","_h","_f"]; _c ctrlSetStructuredText parseText _h; _c ctrlSetFade 0; _c ctrlCommit _f; };
    UMB_fnc_strReplace = { params ["_s","_w","_r"]; private _o=_s; private _i=_o find _w; while {_i>-1} do {_o=(_o select[0,_i])+_r+(_o select[_i+count _w]); _i=_o find _w;}; _o; };
    UMB_fnc_typeBody = {
      params ["_c","_plain","_d"];
      private _open="<t font='PuristaLight' size='1.08' color='#DADADA' align='center'>"; private _close="</t>";
      for "_i" from 1 to count _plain do {
        private _sub=_plain select[0,_i]; private _html=[_sub,"\n","<br/>"] call UMB_fnc_strReplace;
        _c ctrlSetStructuredText parseText (_open+_html+_close); sleep _d;
      };
    };

    private _fadeTitle=0.40; private _typeDelay=0.028; private _holdExtra=5.0;
    private _slides = [
      ["<t font='PuristaSemibold' size='1.40' color='#FFFFFF'>ISLA BLOQUE · PROPIEDAD DE UMBRELLA CORPORATION</t>",
       "Eres personal de Seguridad Corporativa de Umbrella — contratista privado bajo Contrato A-7.\nTu función: preservar activos, información y personal crítico de la compañía."],
      ["<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>CONTEXTO</t>",
       "Te encuentras fuera de servicio en la base principal.\nLa red eléctrica insular está caída por trabajos y averías encadenadas; de momento es de día y la situación es estable.\nLa base opera con energía de emergencia."],
      ["<t font='PuristaSemibold' size='1.30' color='#FFFFFF'>SITUACIÓN</t>",
       "En la isla se han reportado comportamientos anómalos en población civil.\nCorre el rumor de un brote actualmente en evaluación.\nHospitales y centros de atención están sobrecargados mientras se investiga la situación."],
      ["<t font='PuristaSemibold' size='1.40' color='#FFFFFF'>STANDBY</t>",
       "Cuando recuperes control, abre tu mapa y dirígete a la zona marcada Briefing.\nUmbrella aprecia tu compromiso."]
    ];

    { private _t=_x#0; private _b=_x#1;
      [_ctrlTitle,_t,_fadeTitle] call UMB_fnc_showTitle;
      uiSleep (_fadeTitle+0.10);
      _ctrlBody ctrlSetFade 0; _ctrlBody ctrlCommit 0; _ctrlBody ctrlSetStructuredText parseText "";
      [_ctrlBody,_b,_typeDelay] call UMB_fnc_typeBody; sleep _holdExtra;
    } forEach _slides;

    2 fadeMusic 0; uiSleep 2; playMusic "";
    uiNamespace setVariable ["UMB_introActive", false];

    _logo ctrlSetFade 1; _logo ctrlCommit 0.2;
    _ctrlTitle ctrlSetFade 1; _ctrlTitle ctrlCommit 0.2;
    _ctrlBody  ctrlSetFade 1; _ctrlBody  ctrlCommit 0.2;
    uiSleep 0.25;

    _layer cutRsc ["Default", "PLAIN", 0, false];
    titleCut ["", "PLAIN", 0];
    cutText ["", "BLACK IN", 0];

    // FALLBACK: si el servidor ya está emitiendo y esta máquina no recibió la orden, engancha aquí.
    [] spawn {
      private _deadline = diag_tickTime + 30;  // esperar hasta 30 s
      waitUntil {
        uiSleep 0.25;
        !(uiNamespace getVariable ["UMB_introActive", false]) &&
        ((missionNamespace getVariable ["UMB_music_current",""]) != "" || diag_tickTime > _deadline)
      };
      private _t = missionNamespace getVariable ["UMB_music_current",""];
      if (_t != "") then {
        // No reiniciamos si ya está sonando; aun así, forzar playMusic no hace daño
        [_t, 0, 1] call (missionNamespace getVariable "UMB_fnc_musicPlay");
      };
    };
  };

} else {
  // Ya viste la intro (reentradas): mismo fallback, pero sin mostrar intro.
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
