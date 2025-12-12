# core

Este módulo arranca el framework y centraliza los "entrypoints".

## Qué hace
- `postInit`: arranca automáticamente en todos los clientes/servidor (si usas `postInit = 1`).
- `initPlayerLocal`: arranque cliente (equivalente a initPlayerLocal.sqf).
- `initServer`: arranque servidor (equivalente a initServer.sqf).
- `loadConfig`: carga `don_config.sqf` una vez.
- `onPlayerKilled` / `onPlayerRespawn`: wrappers para los scripts especiales.

## Uso recomendado
- Deja `description.ext` como plantilla con `#include ...cfgFunctions.hpp`
- Edita solo:
  - `don_missionMeta.hpp`
  - `don_config.sqf`

## Notas
Si mantienes `initPlayerLocal.sqf` e `initServer.sqf` en la misión, que solo llamen a las funciones del framework
(y el framework se protege para no inicializar dos veces).
