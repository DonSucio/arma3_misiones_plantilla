# GRAD Fortifications (no vendoreado)

Esta carpeta debe contener los archivos originales de **GRAD Fortifications**.

1. Descarga el ZIP desde https://github.com/gruppe-adler/grad-fortifications (no hace falta clonar).
2. Copia su contenido dentro de `modules/grad-fortifications/`.
3. Activa el wrapper del framework:
   - `don_framework/config/don_defines.hpp` ➜ `#define DON_ENABLE_GRAD_FORTIFICATIONS 1`
   - `don_config.sqf` ➜ `DON_fortifications_enabled = true;`

La configuración de ejemplo (objetos, inventarios virtuales y HEMTT Box como almacén) está en `don_framework/third_party/grad/cfgGradFortifications.hpp`.
