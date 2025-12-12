# DON Mission Template (refactor)

Esta carpeta es una **plantilla** para misiones de Arma 3 con un mini-framework reutilizable.

## Lo que editas tú (fácil)
- `don_missionMeta.hpp` → nombre/imagen/pantallas de carga + ajustes de debug
- `don_config.sqf` → textos (intro) y activar/desactivar módulos

## Lo que NO deberías tocar por misión
- `description.ext` (solo incluye archivos)
- `don_framework\...` (el framework)

## Cómo usarlo en una misión nueva
1. Copia esta carpeta como base de la misión.
2. Cambia `don_missionMeta.hpp` y `don_config.sqf`.
3. (Opcional) Si no quieres usar postInit, deja los stubs `initPlayerLocal.sqf` / `initServer.sqf` tal cual.

## Añadir un módulo nuevo
- Crea `don_framework\modules\<modulo>\fn_algo.sqf` + `README.md`
- Regístralo en `don_framework\config\cfgFunctions.hpp`
- (Si tiene UI) incluye su .hpp dentro de `don_framework\config\rscTitles.hpp`
