<?php
class CONEXION{
    private $conexion;
    public function conectar(){
        $puerto = "3306";
        $host = "localhost";
        $db = "quinto";
        $usuario = "root";
        $psw = "";

        // Esta línea es para que reconozca caracteres como la "ñ" xd
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8');

        try {
            $this->conexion = new PDO("mysql:host=" . $host . ":" . $puerto . ";dbname=" . $db, $usuario, $psw, $opc);
            //echo ("Conexion establecida. . .");
            return true;
        } catch (PDOException $e) {
            echo ("Error en la conexión. . ." . $e->getMessage() . ". . .");
            return false;
        }
    }

    public function getCon(){
        return $this->conexion;
    }

    public function desconectar(){
        $this->conexion = null;
    }
}
