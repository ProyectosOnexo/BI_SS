<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormIniciarSesion.aspx.cs" Inherits="Form_FormIniciarSesion" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>Generar reportes</title>
    <link rel="stylesheet"  href="css/inisesion.css" />
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/estilos.css"/>
    <link rel="stylesheet" href="css/fontawesome.min.css"/>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">


    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap.min.js"></script>

</head>
<body>
    <div class="container">
	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>Ingrese sus datos</h3>
			</div>
			<div class="card-body">
				<form runat="server">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" class="form-control" placeholder="correo electrónico" required>
						
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input type="password" class="form-control" placeholder="contraseña" required>
					</div>
					<div class="row align-items-center remember">
						<input style="cursor:grab" type="checkbox">Recordar usuario
					</div>
					<div class="form-group">
                        <asp:Button runat="server" type="button" class="btn btn-primary float-right" Text="Iniciar sesión" OnClick="IniciarSesion_Click"></asp:Button>
					</div>
				</form>
			</div>
			<div class="card-footer">
				<div class="d-flex justify-content-center links">
					No tienes una cuenta?<a id="LinkRegistrate" href="#">Registrate</a>
				</div>
				<div class="d-flex justify-content-center">
					<a id="LinkContraseñaOlvidada" href="#">Olvidaste tu contraseña?</a>
				</div>
			</div>
		</div>
	</div>
    </div>
</body>
</html>
