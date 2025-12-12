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

// Cámara sobre ruta declarativa
private _routeName = missionNamespace getVariable ["DON_intro_sequence_routeName", ""];
if (!(_routeName isEqualTo "")) then {
    private _segmentTime = missionNamespace getVariable ["DON_intro_sequence_segmentTime", 8];
    private _target = missionNamespace getVariable ["DON_intro_sequence_cameraTarget", objNull];
    [_routeName, _segmentTime, _target] spawn DON_fnc_playCameraRoute;
};
