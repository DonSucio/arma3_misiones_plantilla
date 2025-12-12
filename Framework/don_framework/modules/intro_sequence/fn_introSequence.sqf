/*
    fn_introSequence.sqf

    Orquesta la intro cinematográfica: loop de música, cámara y (opcional) la intro RP.
*/
if (!hasInterface) exitWith {};

if !(missionNamespace getVariable ["DON_intro_sequence_enabled", false]) exitWith {};

// Música en bucle
if (missionNamespace getVariable ["DON_intro_music_enabled", false]) then {
    [
        missionNamespace getVariable ["DON_intro_music_track", ""],
        missionNamespace getVariable ["DON_intro_music_volume", 1],
        missionNamespace getVariable ["DON_intro_music_fadeIn", 3],
        missionNamespace getVariable ["DON_intro_music_loop", true]
    ] call DON_fnc_playLoopMusic;
};

// Intro RP reutilizable
if (
    missionNamespace getVariable ["DON_intro_sequence_playRP", true] &&
    missionNamespace getVariable ["DON_intro_enabled", true]
) then {
    [] spawn DON_fnc_introRP;
};

// Cámara sobre ruta capturada (unitPlay)
private _routeName = missionNamespace getVariable ["DON_intro_sequence_routeName", ""];
if (!(_routeName isEqualTo "")) then {
    private _loop = missionNamespace getVariable ["DON_intro_sequence_loop", false];
    private _timeShift = missionNamespace getVariable ["DON_intro_sequence_timeShift", 0];

    [_routeName, _loop, _timeShift] spawn {
        params ["_routeName", "_loop", "_timeShift"]; // captura de variables externas
        private _cam = "camera" camCreate [0,0,0];
        _cam cameraEffect ["internal", "back"];
        _cam camCommit 0;

        private _handle = [_cam, _routeName, _loop, _timeShift] call DON_fnc_ucPlayOnOwner;
        waitUntil {
            uiSleep 0.1;
            isNull _cam || { scriptDone _handle }
        };
        _cam cameraEffect ["terminate", "back"];
        camDestroy _cam;
    };
};
