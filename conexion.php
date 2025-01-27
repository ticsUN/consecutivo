<?php
/** PARAMETROS DE CONEXION DE LA BASE DE DATOS **/
$host = '172.18.0.1'; //'192.168.0.95';
$db = 'local_consecutivos'; //'coopun_consecutivo';
$user = 'postgres';//'adm_consecutivo';
$pass = 'postgres';//'adm_consecutivo';
$port = '5432';//"5444";

// Intentar establecer la conexión a la base de datos con PostgreSQL
$conexion = @pg_connect("host=$host port=$port dbname=$db user=$user password=$pass");

/* Validación para la conexion correcta a la base de datos */
if (!$conexion) {
    // Si la base de datos no conecta se enviara este mensaje 
    ?>
    <div style='color:red;font-weight:bold;text-align:center;font-size:12px'>
        Estamos experimentando problemas técnicos que pueden afectar el funcionamiento de nuestros servicios.
        Nuestro equipo está trabajando arduamente para resolver la situación lo más rápido posible.
        Agradecemos su comprensión y paciencia.
    </div>
    <br>
    <img src="img/manutencao.jpg" width="100px">
    <center>
        <a class="btn btn-info btn-sm" href="consecutivo"><i class="fa fa-refresh"></i> Volver A Cargar</a>
    </center>
    <?php
    // Se cancela la conexion a base de datos
    exit;
}else{
    /* En caso contrario conecta a la base de datos exitosamente */ 

    $conexion = @pg_connect("host=$host port=$port dbname=$db user=$user password=$pass");

}


?>
