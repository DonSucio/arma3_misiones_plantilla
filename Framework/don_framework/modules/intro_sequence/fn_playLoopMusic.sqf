/*
    fn_playLoopMusic.sqf

    Reproduce una pista de CfgMusic con loop opcional.
    Está pensado para usarse en clientes (intro cinematográfica, ambience).
*/
if (!hasInterface) exitWith {};

params [
    ["_track", "", [""]],
    ["_volume", 1, [0]],
    ["_fadeIn", 3, [0]],
    ["_loop", true, [true]]
];

if (_track isEqualTo "") exitWith {};

// Limpia handlers anteriores
private _oldEh = missionNamespace getVariable ["DON_intro_music_eh", -1];
if (_oldEh >= 0) then {
    removeMusicEventHandler ["MusicStop", _oldEh];
    missionNamespace setVariable ["DON_intro_music_eh", -1];
};

missionNamespace setVariable ["DON_intro_music_track", _track];

// Arranca la pista con fundido
0 fadeMusic 0;
playMusic _track;
if (_fadeIn > 0) then {
    _fadeIn fadeMusic _volume;
} else {
    0 fadeMusic _volume;
};

// Loop opcional
if (_loop) then {
    private _ehId = addMusicEventHandler ["MusicStop", {
        private _loopTrack = missionNamespace getVariable ["DON_intro_music_track", ""];
        if (!(_loopTrack isEqualTo "")) then {
            playMusic _loopTrack;
        };
    }];
    missionNamespace setVariable ["DON_intro_music_eh", _ehId];
};
