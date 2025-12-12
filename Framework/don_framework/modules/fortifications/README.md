# GRAD Fortifications (wrapper DON)

Wrapper minimalista para activar/desactivar GRAD Fortifications desde `don_config.sqf` sin tocar `description.ext`.

## Cómo se activa
1. Descarga GRAD Fortifications y cópialo en `modules/grad-fortifications` (ver README de `Framework/modules`).
2. Abre `don_framework/config/don_defines.hpp` y pon `#define DON_ENABLE_GRAD_FORTIFICATIONS 1` para que el `description.ext` incluya el módulo.
3. En `don_config.sqf` activa el toggle runtime: `DON_fortifications_enabled = true;`.

Si falta alguno de los pasos anteriores, el wrapper deja `DON_fortifications_active = false` y escribe un `diag_log` explicando el motivo.

## Ejemplos rápidos (Eden)
- Para dar inventario virtual a un vehículo o contenedor:
  ```sqf
  this setVariable ["grad_fortifications_myFortifications", ["Land_BagFence_Long_F", "Land_HBarrier_3_F"], true];
  ```
- Para reutilizar la config incluida (inventario player + HEMTT Box como almacén), basta con tener el módulo instalado y el toggle activo.

## Notas
- La configuración completa de fortificaciones vive en `don_framework/third_party/grad/cfgGradFortifications.hpp`.
- No se vendorea el mod: la carpeta `modules/grad-fortifications` debe contener los archivos originales de https://github.com/gruppe-adler/grad-fortifications.
