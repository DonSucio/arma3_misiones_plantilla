# GRAD Persistence en DON Framework

Este módulo es **persistencia**: guardar/cargar progreso de misión en el **profileNamespace del servidor** (no es una BD externa). La parte "mágica" de DON Framework es que **no tocas description.ext** más que para incluir el framework, y activas/desactivas módulos desde un único fichero.

## 1) Activar/Desactivar

Abre:

`don_framework/config/don_defines.hpp`

y pon:

- `#define DON_ENABLE_GRAD_PERSISTENCE 1`
- `#define DON_ENABLE_GRAD_FORTIFICATIONS 1` *(solo si usas integración con GRAD Fortifications)*

Si lo dejas en 0, no se hace ningún `#include` y **no rompe** aunque no tengas las carpetas.

## 2) Dónde van los archivos del módulo

En la raíz de tu misión:

```
modules/
  grad-persistence/
  grad-fortifications/   (opcional, pero recomendado si lo usas)
```

## 3) Config que se aplica

Tu config vive aquí:

- `don_framework/third_party/grad/cfgGradPersistence.hpp`
- `don_framework/third_party/grad/gradPersistence_blacklist.hpp` (tu lista gigante)

Está montado para que el framework lo "inyecte" en el `description.ext` cuando el módulo está habilitado.

## 4) Importante (rutas)

Los `#include` de GRAD están escritos con rutas `..\..\..` porque estos ficheros están dentro de `don_framework/...`.
