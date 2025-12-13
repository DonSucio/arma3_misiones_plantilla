# routes

Sistema declarativo de rutas reutilizables para cámara o unidades. **No es UnitCapture** (las capturas viven en `unit_capture/`).

## Config (don_config.sqf)
- `DON_routes_enabled` (bool): activa el registro.
- `DON_routes_definitions`: array de rutas. Formato:
  `["nombre", [listaDePuntos], loop?, radioLlegada, velocidad]`
  - Puntos pueden ser markers o posiciones `[x,y,z]`.
  - `loop?` (bool) por defecto `true`.
  - `radioLlegada` (metros) por defecto `5`.
  - `velocidad` (string) por defecto `"LIMITED"` (`setSpeedMode`).

Ejemplo:
```sqf
DON_routes_definitions = [
    ["intro_cam_route", ["mrk_cam_1", "mrk_cam_2", "mrk_cam_3"], true, 5, "LIMITED"],
    ["patrol_zombies", [[1200,3400,0],[1220,3450,0]], true, 8, "NORMAL"]
];
```

## Helpers
- `[] call DON_fnc_registerRoutes;` — normaliza las rutas (lo hace el init del framework).
- `[unit, "intro_cam_route", ["loop", false, "radius", 6]] call DON_fnc_attachUnitToRoute;` — `_options` puede ser
  HashMap **o** array de pares clave/valor.
- `[_routeName] call DON_fnc_getRoute;` — devuelve el HashMap con `points/loop/radius/speed`.

## Uso rápido (Eden)
1. Activa `DON_routes_enabled = true;` y define tus rutas en `don_config.sqf`.
2. Para mover una IA/vehículo, en su init pon:
   ```sqf
   [this, "patrol_zombies"] call DON_fnc_attachUnitToRoute;
   ```
3. Si no es local, el wrapper la reenvía al owner automáticamente antes de hacer `doMove`.
