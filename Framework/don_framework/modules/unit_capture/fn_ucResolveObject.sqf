/*
    fn_ucResolveObject.sqf

    Acepta referencia de objeto o nombre de variable de Eden y devuelve el objeto.
*/
params ["_ref"];

if (_ref isEqualType objNull) exitWith { _ref };
if (!(_ref isEqualType "")) exitWith { objNull };
if (_ref isEqualTo "") exitWith { objNull };

missionNamespace getVariable [_ref, objNull]
