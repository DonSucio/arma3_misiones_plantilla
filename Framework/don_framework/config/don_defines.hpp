/*
    DON Framework - Toggles de módulos ("para tontos")
    --------------------------------------------------
    Estos toggles se leen en TIEMPO DE COMPILACIÓN (preprocesador del description.ext).

    Si dejas algo en 0:
      - No se hace #include del módulo
      - No rompe aunque NO exista la carpeta modules\...

    Si lo pones en 1:
      - Asegúrate de tener el módulo descargado dentro de /modules
*/

// ==============================
// GRAD
// ==============================

// GRAD Persistence (guardar/cargar progreso en profileNamespace del servidor)
#define DON_ENABLE_GRAD_PERSISTENCE 0

// GRAD Fortifications (necesario si usas saveGradFortificationsStatics y/o su hint UI)
#define DON_ENABLE_GRAD_FORTIFICATIONS 0
