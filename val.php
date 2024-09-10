<?php
// Conexión SSH con autenticación mediante la extensión SSH2 de PHP

#error_reporting(E_ALL);
#ini_set('display_errors', 1);

// Verifica si se ha proporcionado el parámetro 'token' en la URL
if (isset($_GET['token'])) {
    $username = $_GET['token']; // Obtiene el valor del parámetro 'token' de la URL
    $conexion = ssh2_connect('GATESCCNIP', 22); // Ingresa el hostname o IP del servidor SSH y el puerto
    if (!$conexion) {
        die('La conexión SSH falló.');
    }

    $auth = ssh2_auth_password($conexion, $username, 'DEXVPN'); // Ingresa la contraseña
    if (!$auth) {
        echo 'Fail'; // Si la autenticación falla
    } else {
        echo 'OK'; // Si la autenticación es exitosa
    }
} else {
    echo 'no ay nada que ver aquí .'; // Mensaje si no se proporciona el parámetro 'token'
}
?>

