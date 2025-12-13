# Unit Capture (BIS_fnc_unitPlay)

Sistema recomendado para reproducir helicópteros/vehículos grabados con `BIS_fnc_unitCapture`, listo para dedicado/MP
con acciones “para tontos” en un portátil.

## 1) Grabar y guardar la ruta
1. En el editor, graba con `BIS_fnc_unitCapture` y copia el array devuelto.
2. En la carpeta de la misión crea `paths/loquesea.sqf` y pega el array tal cual (no muevas las rutas al framework).

## 2) Configurar `don_config.sqf`
```sqf
// Activa el módulo
DON_unitCapture_enabled = true;
DON_unitCapture_defaultLoop = false; // loop por defecto si no se indica en cada ruta

// Rutas declaradas: ["nombre", "rutaSQF", loop?, timeShiftSegundos]
DON_unitCapture_routes = [
    ["lb1_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb1_lead.sqf", false, 0],
    ["lb2_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb2_lead.sqf"]
];
```
`[] call DON_fnc_ucRegisterRoutes;` cachea todo en `missionNamespace`.

## 3) Preparar Eden (variables + acciones en portátil)
- Pon nombre de variable a cada helicóptero/vehículo grabado: `heli1`, `heli2`, etc.
- En el portátil añade:
```sqf
this setVariable ["DON_uc_actions", [
    ["LB1 - start", [
        ["heli1", "lb1_lead", false, 0, 0],   // targetRef, routeName, loop, timeShift, startDelay
        ["heli2", "lb1_lead", false, 0, 8]    // 8s de delay entre helicópteros
    ]],
    ["STOP", [["heli1"], ["heli2"]], "stop"]
], true];
```
- Compatibilidad con formato simple: `["Texto", "heli1", "lb1_lead", true, 0]`.

## 4) API “para tontos”
- `[] call DON_fnc_ucRegisterRoutes;` — HashMap nombre -> `[frames, loopPorDefecto, timeShiftPorDefecto]`.
- `[_ref] call DON_fnc_ucResolveObject;` — acepta objeto o nombre de variable de Eden.
- `[_objOrRef, _routeRef, _loop?, _timeShift?] call DON_fnc_ucPlayOnOwner;` — locality-safe, reenvía al owner y reproduce con loop/handle.
- `[_objOrRef] call DON_fnc_ucStop;` — detiene la reproducción donde el vehículo sea local.
- `[_payload, _caller] call DON_fnc_ucDispatchFromLaptop;` — orquesta batches con delays (lo usa el portátil desde servidor).

## 5) Sincronización y delays
- `timeShift` recorta segundos iniciales de la captura (también configurable al registrar la ruta).
- `startDelay` (por target) permite escalonar despegues dentro del mismo botón.

## 6) Probar en dedicado/MP
1. Server: habilita el módulo y registra rutas (initServer del framework ya llama a `ucRegisterRoutes`).
2. Cliente con interfaz: las acciones del portátil aparecen aunque el portátil no sea local.
3. Al pulsar acción: cliente -> `remoteExecCall` al servidor -> server resuelve objetos (missionNamespace) -> reenvía al owner y ejecuta `BIS_fnc_unitPlay` local.
4. STOP: el mismo botón puede parar varios helicópteros (`"stop"`).

## Notas rápidas
- Las rutas se siguen leyendo desde `paths/*.sqf` de la misión.
- El módulo se apoya en `BIS_fnc_unitPlay`; no es un sistema de puntos (para eso está `routes/`).
- Si cambias owner (getIn de jugador, etc.) el wrapper reenvía automáticamente la reproducción.
