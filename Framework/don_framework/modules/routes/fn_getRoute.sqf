/*
    fn_getRoute.sqf

    Devuelve el HashMap de una ruta ya registrada.
*/

params [
    ["_routeName", "", [""]]
];

if (_routeName isEqualTo "") exitWith { createHashMap };

private _registry = missionNamespace getVariable ["DON_routes_registry", createHashMap];
if (!(_registry isEqualType createHashMap)) exitWith { createHashMap };

_registry getOrDefault [_routeName, createHashMap];
