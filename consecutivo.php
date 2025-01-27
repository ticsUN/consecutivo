<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generación de Consecutivo</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles.css">
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    
    <script>
        /**** SCRIPT PARA INHABILITAR EL ACCESO AL MENU DE CONTEXTO DEL NAVEGADOR ****/
        function inhabilitar(){
            //return false
        }
        document.oncontextmenu = inhabilitar
    </script>      
</head>
<body>
    <div class="login-container mt-5">
        <img src="img/log_coop.png" alt="Logo">
        <?php
            /** ADICIÓN DEL ARCHIVO DE CONEXION A BASE DE DATOS **/
            include 'conexion.php';
        ?>
        <b class="centrado">Generación de Consecutivo</b>

        <form action="controller/consecutivo/controller" method="POST" class="mt-4">
            <div class="form-group">
                <!--<label for="consecutivo"><b>Consecutivo:</b></label>
		
                <input type="text" class="form-control" id="consecutivo" name="consecutivo"  readonly>-->
				
            </div>
            <input type="hidden" name="fecha_hoy" value="<?php echo date('Y-m-d H:i:s'); ?>" >
            <div class="form-group">
                <label for="obs"><b>Observaciones:</b></label>
                <textarea class="form-control"  rows="2" id="obs" name="obs" placeholder="Ingrese Observaciones" rows="3" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="prefijo_id"><b>Prefijo:</b></label>
                <select class="form-control" id="prefijo_id" name="prefijo_id" required>
                    <option value="">--Seleccionar Prefijo--</option>
                    <?php
                    /** CONSULTA PARA EXTRAER LOS OPTIONS DE LOS PREFIJOS DESDE LA BASE DE DATOS **/
                    $consulta_pref = "SELECT prefijo_id, descripcion_prefijo FROM consecutivo.prefijo";
                    $resultado = pg_query($conexion, $consulta_pref);

                    while ($row = pg_fetch_assoc($resultado)) {
                    ?>
                    <option value="<?php echo $row['prefijo_id']; ?>"><?php echo $row['descripcion_prefijo']; ?></option>
                    <?php
                    }
                    ?>
                </select>
            </div>
           
            <button type="submit" name="crear_consecutivo" class="btn btn-info btn-block">Generar</button>
        </form>
    </div>
</body>
</html>
