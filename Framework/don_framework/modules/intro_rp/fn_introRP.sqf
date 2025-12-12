/*
    fn_introRP.sqf
    ----------------
    Basado en tu BLOQUE 1. Los textos salen de don_config.sqf.
*/
if (!hasInterface) exitWith {};

[] spawn {
    // Construcción de texto (title + body)
    private _titlePlain = missionNamespace getVariable ["DON_intro_title", "ROL PERMANENTE"];
    private _titleText  = format [
        "<t font='PuristaSemibold' size='1.4' color='#FFFFFF' align='center'>%1</t>",
        _titlePlain
    ];

    private _bodyHtml = missionNamespace getVariable ["DON_intro_body_html", ""];

    if (_bodyHtml isEqualTo "") then {
        private _lines = missionNamespace getVariable ["DON_intro_body_lines", []];
        private _joined = _lines joinString "<br/>";
        _bodyHtml = format [
            "<t font='PuristaLight' size='1.05' color='#DADADA' align='center'>%1</t>",
            _joined
        ];
    };

    private _duration = missionNamespace getVariable ["DON_intro_duration", 30];

    // Capa de UI para la intro
    private _layer = "RP_INTRO_LAYER" call BIS_fnc_rscLayer;
    _layer cutRsc ["RP_Intro", "PLAIN", 0, false];

    // Esperar a que el display exista
    waitUntil { !(isNull (uiNamespace getVariable ["RP_Intro", displayNull])) };
    private _disp      = uiNamespace getVariable ["RP_Intro", displayNull];
    private _ctrlTitle = _disp displayCtrl 1003;
    private _ctrlBody  = _disp displayCtrl 1004;

    _ctrlTitle ctrlSetStructuredText parseText _titleText;
    _ctrlBody  ctrlSetStructuredText parseText _bodyHtml;
    _ctrlTitle ctrlCommit 0;
    _ctrlBody  ctrlCommit 0;

    sleep _duration;

    // Cerrar intro y volver al juego
    _layer cutRsc ["Default", "PLAIN", 0, false];
};
