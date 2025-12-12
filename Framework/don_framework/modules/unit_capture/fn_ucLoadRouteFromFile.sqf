/*
    fn_ucLoadRouteFromFile.sqf

    Carga una ruta capturada por BIS_fnc_unitCapture desde un fichero .sqf.
*/
params ["_filePath"];

if (!(_filePath isEqualType "") || {_filePath isEqualTo ""}) exitWith {
    diag_log "[DON][UC] ucLoadRouteFromFile: ruta vacía o no es string.";
    []
};

if !(fileExists _filePath) exitWith {
    diag_log format ["[DON][UC] ucLoadRouteFromFile: el fichero %1 no existe.", _filePath];
    []
};

private _route = call compileFinal preprocessFileLineNumbers _filePath;

// Desenvuelve niveles extra (algunas capturas vienen como [[...]]).
while {_route isEqualType [] && {count _route == 1 && {(_route#0) isEqualType []}}} do {
    _route = _route#0;
};

// Validación mínima: array de arrays, con al menos 2 filas.
if !(_route isEqualType [] && {count _route >= 2 && {(_route#0) isEqualType []}}) exitWith {
    diag_log format ["[DON][UC] ucLoadRouteFromFile: formato inesperado en %1.", _filePath];
    []
};

_route
