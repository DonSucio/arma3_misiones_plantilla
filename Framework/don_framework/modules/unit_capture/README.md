# Unit Capture (BIS_fnc_unitPlay)

Reproduce capturas exportadas con `BIS_fnc_unitCapture` sobre helicópteros/vehículos/unidades, con locality segura y acciones declaradas en Eden.

## Configuración
En `don_config.sqf`:
```sqf
// Activa el módulo
DON_unitCapture_enabled = true;
DON_unitCapture_defaultLoop = false; // loop por defecto si no se pone en cada ruta

// Rutas: ["nombre", "ficheroSQF", loop?, timeShiftSegundos]
DON_unitCapture_routes = [
    ["lb1_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb1_lead.sqf", false, 0],
    ["lb2_lead", "Halloween/HALLOWEEN_2025_dia2.chernarusredux/paths/lb2_lead.sqf"]
];
```

## API
- `[] call DON_fnc_ucRegisterRoutes;` — carga/cacha las rutas declaradas.
- `[_ref] call DON_fnc_ucResolveObject;` — acepta objeto o nombre de variable de Eden.
- `[_objOrRef, _routeNameOrArray, _loop?, _timeShift?] call DON_fnc_ucPlayOnOwner;` — reproduce con locality segura (reenvía al owner si hace falta). Guarda el handle en `_obj setVariable ["DON_uc_handle", ...]` y soporta loop.
- `[_objOrRef] call DON_fnc_ucStop;` — detiene la reproducción y apaga el loop.

### Portátiles/acciones Eden
1. En Eden, pon nombre de variable al helicóptero: `heli1`.
2. En el portátil: nombre `laptop1` y en su init:
```sqf
this setVariable ["DON_uc_actions", [
    ["LB1 - vuelo", "heli1", "lb1_lead"],
    ["LB2 - vuelo", "heli1", "lb2_lead", true]
], true];
```
El módulo añade los `addAction` automáticamente en clientes y reenviará la reproducción al owner correcto.

## Notas
- No copies los ficheros de ruta al framework: la misión sigue leyendo `paths/*.sqf` desde su carpeta.
- `_routeNameOrArray` puede ser el nombre declarado en config o el array literal exportado por `unitCapture`.
- Funciona en dedicado/MP: las acciones corren en el cliente y la reproducción se ejecuta donde el vehículo es local.
