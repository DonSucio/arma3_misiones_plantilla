/*
    fn_lockThirdPersonBySlot.sqf
    ----------------------------
    Basado en tu BLOQUE 2 (3ª persona por slot).
*/
if (!hasInterface) exitWith {};
if (isDedicated) exitWith {};

private _allowTPV = player getVariable ["allowThirdPerson", false];
if (_allowTPV) exitWith {};

[] spawn {
    private _msgShown = false;

    while {true} do {
        // Espera hasta que el jugador intente ponerse en 3ª persona
        waitUntil { cameraView in ["EXTERNAL", "GROUP"] };

        // Lo devolvemos a 1ª persona (sea a pie o en vehículo)
        (vehicle player) switchCamera "INTERNAL";

        if (!_msgShown) then {
            _msgShown = true;
            systemChat "Este slot está limitado a primera persona.";
        };

        sleep 0.05;
    };
};
