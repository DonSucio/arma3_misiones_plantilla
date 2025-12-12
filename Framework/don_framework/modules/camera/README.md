# camera

Bloquea la 3ª persona por slot, salvo que el slot tenga `allowThirdPerson = true`.

## Configuración por slot (Eden)
Para permitir 3ª persona en un slot:
```sqf
this setVariable ["allowThirdPerson", true, true];
```

## Config (don_config.sqf)
- `DON_thirdPersonLock_enabled` (bool)
