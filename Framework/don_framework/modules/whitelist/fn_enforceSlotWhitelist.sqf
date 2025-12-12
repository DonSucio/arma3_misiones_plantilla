/*
    fn_enforceSlotWhitelist.sqf
    ---------------------------
    Basado en tu BLOQUE 2 (parte whitelist).
*/
if (!hasInterface) exitWith {};

waitUntil {!isNull player};
waitUntil {getPlayerUID player != ""};

private _uid     = getPlayerUID player;
private _allowed = player getVariable ["allowedUIDs", []];

if ((count _allowed > 0) && !(_uid in _allowed)) then {
    ["No estás en la whitelist de este slot.\nSerás devuelto al lobby.", "PLAIN"] call BIS_fnc_guiMessage;
    sleep 2;
    endMission "LOSER";
};
