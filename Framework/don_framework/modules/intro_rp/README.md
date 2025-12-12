# intro_rp

Muestra una intro en negro con título + cuerpo (StructuredText).

## Requisitos
- `RscTitles` debe incluir la clase `RP_Intro` (ya viene en `don_framework\config\rscTitles.hpp`).

## Config (don_config.sqf)
- `DON_intro_enabled` (bool)
- `DON_intro_duration` (segundos)
- `DON_intro_title` (texto plano)
- `DON_intro_body_lines` (array de líneas)
- Opcional: `DON_intro_body_html` (string StructuredText). Si existe, se usa tal cual.

## Permisos / notas
Se ejecuta solo en clientes con interfaz (`hasInterface`).
