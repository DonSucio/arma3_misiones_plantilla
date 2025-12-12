/*
    DON Framework - GRAD includes (description.ext)
    ----------------------------------------------
    Este fichero existe para que description.ext no se llene de #includes.

    OJO con las rutas:
    - Este fichero vive en don_framework\third_party\grad
    - Por eso usamos ..\.. para salir a la raíz de la misión
*/

#include "..\..\config\don_defines.hpp"

#if DON_ENABLE_GRAD_FORTIFICATIONS
    // Necesario para GRAD Fortifications (config global del módulo)
    #include "..\..\..\modules\grad-fortifications\grad_fortifications.hpp"
#endif
