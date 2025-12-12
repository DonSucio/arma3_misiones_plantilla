// === Día 2 — initServer.sqf ===
// Farolas + LB + Música: UN SOLO TEMA (15 min) en bucle

// ----- Apagado de farolas fuera de ZONA_ILUMINADA -----
[] spawn {
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

if (!isServer) exitWith {};  // resto: solo servidor

// ----------------- Utilidades LB (sin cambios) -----------------
missionNamespace setVariable ["UMB_fnc_loadRoute", {
  params ["_file"];
  if !(fileExists _file) exitWith { [] };
  private _rt = call compileFinal preprocessFileLineNumbers _file;
  while { _rt isEqualType [] && { count _rt == 1 && { (_rt#0) isEqualType [] } } } do { _rt = _rt#0; };
  if !(_rt isEqualType [] && { count _rt > 1 && { (_rt#0) isEqualType [] } }) exitWith { [] };
  _rt
}]; publicVariable "UMB_fnc_loadRoute";

missionNamespace setVariable ["UMB_fnc_timeShiftRoute", {
  params ["_route", "_shift"];
  if (_shift <= 0) exitWith { _route };
  private _out = [];
  if ((count _route) == 0) exitWith { _route };
  private _idx = -1;
  private _s   = _route select 0;
  if (_s isEqualType []) then {
    for "_i" from 0 to (count _s - 1) do { if ((_s select _i) isEqualType 0) exitWith { _idx = _i; }; };
  };
  if (_idx < 0) exitWith { _route };
  {
    private _row = _x; private _t = _row select _idx;
    if (_t isEqualType 0 && { _t >= _shift }) then {
      private _copy = +_row; _copy set [_idx, (_t - _shift) max 0];
      _out pushBack _copy;
    };
  } forEach _route;
  _out
}]; publicVariable "UMB_fnc_timeShiftRoute";

missionNamespace setVariable ["UMB_fnc_engineOnlyLB", {
  params ["_veh"];
  if (isNull _veh) exitWith {};
  _veh engineOn true;
  _veh setFuel 1;
  _veh setDamage 0;
  _veh disableAI "MOVE";
  _veh disableAI "TARGET";
  _veh disableAI "AUTOTARGET";
  _veh setBehaviour "CARELESS";
  _veh setCombatMode "BLUE";
}]; publicVariable "UMB_fnc_engineOnlyLB";

missionNamespace setVariable ["UMB_fnc_runLB_localKey", {
  params ["_veh", "_rkey"];
  if (!local _veh) exitWith {};
  private _deadline = time + 5;
  waitUntil { !isNil { missionNamespace getVariable _rkey } || { time > _deadline } };
  private _route = missionNamespace getVariable [_rkey, []];
  if !(_route isEqualType [] && { count _route >= 2 }) exitWith {};
  private _hkey = format ["UMB_%1_handle", vehicleVarName _veh];
  private _prev = missionNamespace getVariable [_hkey, scriptNull];
  if (!isNull _prev) then { terminate _prev; };
  private _h = [_veh, _route] spawn BIS_fnc_unitPlay;
  missionNamespace setVariable [_hkey, _h];
}]; publicVariable "UMB_fnc_runLB_localKey";

missionNamespace setVariable ["UMB_fnc_startOne", {
  params ["_vehName", "_file", ["_timeShift", 0]];
  private _veh = missionNamespace getVariable [_vehName, objNull];
  if (isNull _veh) exitWith {};
  private _route = [_file] call (missionNamespace getVariable "UMB_fnc_loadRoute");
  if (_timeShift > 0 && { _route isEqualType [] }) then {
    _route = [_route, _timeShift] call (missionNamespace getVariable "UMB_fnc_timeShiftRoute");
  };
  private _n = if (_route isEqualType []) then { count _route } else { 0 };
  if (_n < 2) exitWith {};
  [_veh] call (missionNamespace getVariable "UMB_fnc_engineOnlyLB");
  if (local _veh) then {
    private _hkey = format ["UMB_%1_handle", vehicleVarName _veh];
    private _prev = missionNamespace getVariable [_hkey, scriptNull];
    if (!isNull _prev) then { terminate _prev; };
    private _h = [_veh, _route] spawn BIS_fnc_unitPlay;
    missionNamespace setVariable [_hkey, _h];
  } else {
    private _rkey = format ["UMB_route_%1", _vehName];
    missionNamespace setVariable [_rkey, _route];
    private _own = owner _veh;
    if (_own != 2) then { _own publicVariableClient _rkey; };
    [_veh, _rkey] remoteExec ["UMB_fnc_runLB_localKey", _own];
  };
}]; publicVariable "UMB_fnc_startOne";

missionNamespace setVariable ["UMB_fnc_startLB1234", {
  ["LB1", "paths\lb1_lead.sqf", 0]     call (missionNamespace getVariable "UMB_fnc_startOne");
  ["LB2", "paths\lb2_lead.sqf", 6]     call (missionNamespace getVariable "UMB_fnc_startOne");
  ["LB3", "paths\lb3_lead.sqf", 10.5]  call (missionNamespace getVariable "UMB_fnc_startOne");
  ["LB4", "paths\lb4_lead.sqf", 12]    call (missionNamespace getVariable "UMB_fnc_startOne");
}]; publicVariable "UMB_fnc_startLB1234";

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

// ---- Comprobación temprana de rutas (debug) ----
// (Eliminado para no mostrar mensajes a clientes)
