# Unit Capture (BIS_fnc_unitPlay)

Sistema recomendado para reproducir helicópteros/vehículos grabados con `BIS_fnc_unitCapture`, listo para dedicado/MP con acciones “para tontos” en un portátil.

## 1) Grabar y guardar la ruta
1. En el editor, graba con `BIS_fnc_unitCapture` y copia el array devuelto.
2. En la carpeta de la misión crea `paths/loquesea.sqf` y pega el array tal cual (no muevas las rutas al framework).

## 2) Configurar `don_config.sqf`
```sqf
// Activa el módulo
DON_unitCapture_enabled = true;
DON_unitCapture_defaultLoop = false;      // loop por defecto si no se indica en cada ruta
DON_unitCapture_prepareVehicles = true;   // motor ON, fuel 1, damage 0, IA MOVE/TARGET/AUTOTARGET off, CARELESS/BLUE antes de unitPlay

// Rutas declaradas: ["nombre", "rutaSQF", loop?, timeShiftSegundos]
DON_unitCapture_routes = [
    ["lb1_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb1_lead.sqf", false, 0],
    ["lb2_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb2_lead.sqf"]
];
```
`[] call DON_fnc_ucRegisterRoutes;` cachea todo en `missionNamespace` (ya lo llama el framework en initServer/initPlayerLocal).

## 3) Colocar portátil/StartBox en Eden (DON_uc_actions)
Pon nombre de variable a cada helicóptero/vehículo grabado: `heli1`, `heli2`, etc. Luego añade en el portátil una variable `DON_uc_actions` (propagada a todos los clientes) con uno de estos formatos:

### Formato simple (una acción = una reproducción)
```sqf
this setVariable ["DON_uc_actions", [
    ["▶ Iniciar LB1", "heli1", "lb1_lead", false, 0], // title, targetRef, routeName, loop?, timeShift?
    ["⏹ STOP", "heli1", "", false, 0, 0, "stop"]    // también puedes parar uno a uno usando el modo "stop" (targetRef obligatorio)
], true];
```
- Compatible con el formato anterior: `["Texto", "heli1", "lb1_lead", true, 0]`.
- Si usas modo `"stop"`, el tercer parámetro puede quedar vacío.

### Formato batch (un botón lanza varias rutas con delays)
```sqf
this setVariable ["DON_uc_actions", [
    ["▶ Lanzar despliegue (LB1+LB2+LB3+LB4)", [
        ["LB1", "lb1_lead", false, 0, 0],      // targetRef, routeName, loop, timeShift, startDelay
        ["LB2", "lb2_lead", false, 6, 0],
        ["LB3", "lb3_lead", false, 10.5, 0],
        ["LB4", "lb4_lead", false, 12, 0]
    ]],
    ["⏹ STOP (LB1-4)", [["LB1"], ["LB2"], ["LB3"], ["LB4"]], "stop"]
], true];
```
- Un mismo botón puede reproducir N rutas, cada una con su `timeShift` y `startDelay` (como el despliegue LB1-4 del Día 2).
- `startDelay` se aplica por vehículo dentro del propio botón.

Las acciones se añaden en cada cliente (sin requerir locality del portátil) y son visibles para JIP.

## 4) RemoteExec con whitelist (mode=2)
- Opción rápida: pon `DON_INCLUDE_REMOTEEXEC_CONFIG 1` en `don_framework/config/don_defines.hpp` (usará `don_framework/config/cfgRemoteExec.hpp`).
- Si ya tienes tu propio `CfgRemoteExec`, añade estas clases dentro de `class Functions`:
```cpp
class DON_fnc_ucDispatchFromLaptop { allowedTargets = 2; jip = 0; };
class DON_fnc_ucPlayOnOwner        { allowedTargets = 0; jip = 1; };
class DON_fnc_ucStop               { allowedTargets = 0; jip = 1; };
```

## 5) API rápida
- `[] call DON_fnc_ucRegisterRoutes;` — HashMap nombre -> `[frames, loopPorDefecto, timeShiftPorDefecto]`.
- `[_ref] call DON_fnc_ucResolveObject;` — acepta objeto o nombre de variable de Eden.
- `[_objOrRef, _routeRef, _loop?, _timeShift?] call DON_fnc_ucPlayOnOwner;` — locality-safe, reenvía al owner y reproduce con loop/handle.
- `[_objOrRef] call DON_fnc_ucStop;` — detiene la reproducción donde el vehículo sea local.
- `[_payload, _caller] call DON_fnc_ucDispatchFromLaptop;` — orquesta batches con delays (lo usa el portátil desde servidor).

## 6) Notas y comportamiento
- `timeShift` recorta segundos iniciales de la captura (también configurable al registrar la ruta).
- `startDelay` (por target) permite escalonar despegues dentro del mismo botón.
- Con `DON_unitCapture_prepareVehicles = true`, cada reproducción enciende motor, fuel 1, damage 0 y bloquea IA MOVE/TARGET/AUTOTARGET con `CARELESS + BLUE` antes de `unitPlay` (igual que el Día 2).
- Las rutas siguen leyendo de `paths/*.sqf` de la misión; no se duplican en el framework.
