# intro_sequence

Intro cinematográfica reutilizable: reproduce música en bucle, lanza la intro RP de siempre y mueve la cámara por una ruta capturada (BIS_fnc_unitCapture).

## Config (don_config.sqf)
- `DON_intro_sequence_enabled` (bool): activa el módulo.
- `DON_intro_sequence_playRP` (bool): si `true`, llama también a `DON_fnc_introRP`.
- `DON_intro_sequence_routeName` (string): nombre de la ruta definida en `DON_unitCapture_routes` para la cámara.
- `DON_intro_sequence_loop` (bool): repite la ruta de cámara en bucle.
- `DON_intro_sequence_timeShift` (segundos): recorta el arranque de la ruta (opcional).
- `DON_intro_music_enabled` (bool): activa la música.
- `DON_intro_music_track` (string): clase de `CfgMusic` definida en `description.ext`.
- `DON_intro_music_volume` (0-1), `DON_intro_music_fadeIn` (segundos), `DON_intro_music_loop` (bool).

## Requisitos
- La pista de música debe existir en `CfgMusic` de la misión. Ejemplo mínimo para `description.ext`:
  ```sqf
  class CfgMusic {
      tracks[] = {"DON_HalloweenTheme"};
      class DON_HalloweenTheme {
          name = "DON Halloween";
          sound[] = {"sound\\halloween_theme.ogg", db+0, 1};
      };
  };
  ```
- La ruta de cámara debe estar declarada en `DON_unitCapture_routes` y el módulo `DON_unitCapture_enabled` activo.
  La cámara usa `DON_fnc_ucPlayOnOwner`, así que hereda loop/timeShift y la locality segura del módulo `unit_capture`.

## Uso rápido
1. En `don_config.sqf`, activa `DON_intro_sequence_enabled = true;`, rellena `DON_intro_sequence_routeName` y el nombre de la pista `DON_intro_music_track`.
2. Asegúrate de que `initPlayerLocal.sqf` de tu misión llame al init del framework (stub por defecto).
3. Declara las rutas capturadas (por ejemplo `paths\\lb1_lead.sqf`) en `DON_unitCapture_routes`.
