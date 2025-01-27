
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Número de Consecutivo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white; /* Color de fondo de la página */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .cuadro {
            background-color: #007BFF; /* Color corporativo (azul) */
            color: black; /* Color del texto */
            padding: 20px; /* Espaciado interno */
            border-radius: 10px; /* Bordes redondeados */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra */
            text-align: center; /* Alinear texto al centro */
        }
	
	.button_c{
		background-color:white;
		border-radius: 20px;  
	}
 	.enlace-blanco {
        	color: white;
    	}
    </style>
</head>
<body>
    <div class="cuadro">
	<?php

/* Adicion del archivo de conexion a la base de datos */ 
include '../../conexion.php';

/* Captura del formulario por metodo POST */
if(isset($_POST['crear_consecutivo'])){
    /* Captura de variables desde el formulario */ 
    $consecutivo = $_POST['consecutivo'];
    $prefijo_id = $_POST['prefijo_id'];
    $descripcion = $_POST['obs'];
    $fecha_hoy = $_POST['fecha_hoy'];
        
    /* Insercion a la base de datos */

   
   $consulta_consecutivo = "SELECT consecutivo 
                                 FROM consecutivo.historia_consecutivo 
                                 WHERE consecutivo_id = (SELECT MAX(consecutivo_id) FROM consecutivo.historia_consecutivo);";
$extraer_ultimo_mas_uno = pg_query($conexion, $consulta_consecutivo);

if ($extraer_ultimo_mas_uno) {
    // Obtiene la fila como un array asociativo
    $fila = pg_fetch_assoc($extraer_ultimo_mas_uno);

    // Verifica si se encontró un resultado
    if ($fila) {
        $ultimo = $fila['consecutivo']+1;
    } else {
        echo "No se encontraron resultados.";
    }
} else {
    echo "Error en la consulta: " . pg_last_error($conexion);
}

    
$inserta_maximo = "INSERT INTO consecutivo.historia_consecutivo(
	consecutivo, usuario_id, prefijo_id, descripcion, fecha_generacion)
	VALUES ('$ultimo','1', '$prefijo_id','$descripcion', '$fecha_hoy')";

    $resultado = pg_query($conexion, $inserta_maximo);

?>

	 <img src="../../img/log_coop.png" alt="Logo Cooperativa"> <!-- Asegúrate de que la ruta sea correcta -->
        <h1>Número de Consecutivo: <?php echo $ultimo; ?></h1>
	<a href="../../consecutivo.php" class="enlace-blanco">Generar Nuevo Consecutivo</a>
    </div>
</body>
</html><?php
    
    
}
?>