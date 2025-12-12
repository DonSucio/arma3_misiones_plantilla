# whitelist

Expulsa al lobby si el jugador entra en un slot con whitelist y su UID no está permitido.

## Cómo se configura por slot (Eden)
En el init del objeto jugador (el "this" del slot):
```sqf
this setVariable ["allowedUIDs", ["7656119XXXXXXXXXX","7656119YYYYYYYYYY"], true];
```

## Config (don_config.sqf)
- `DON_whitelist_enabled` (bool)
