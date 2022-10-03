<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginOrden.aspx.cs" Inherits="Form_LoginOrden" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.3.1.min.js"></script>
    <title></title>
     <script>
        $(document).ready(function () {
            $(".form-signin").keypress(function (e) {
                if (e.which == 13) {
                    login()
                }
            })
            $("#btnSubmit").click(function () {
                login()
            })
            function login() {
                $("#btnSubmit").prop("disabled", true);
                var datos = { 'correo': $('#inputEmail').val(), 'password': $('#inputPassword').val() };
                $.ajax({
                    url: 'LoginOrden/Login',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        console.log(data.Respuesta)
                        if (data.Respuesta == 'OK') {
                            window.location = "ShakeShak.aspx";
                        }
                        else {
                            $('#divMsj').text('Datos incorrectos, vuelve a intentar')
                            $('#divMsj').fadeIn('slow')
                            setInterval(function () { $('#divMsj').fadeOut('slow'); }, 4000);
                        }
                        $("#btnSubmit").prop("disabled", false);
                    },
                    error: function (err) {
                        alert(err);
                        $("#btnSubmit").prop("disabled", false);
                    }
                });
            }
        })
    </script>
    <style>
        .fomulario{
            position: absolute; /*Posicionamiento absoluto*/
            top: 50px; /*Desde arriba, los pixeles que queramos que tenga de separación. o 0 si queremos que este pagado arriba*/
            left: 50%; /*Desde la izquierda, colocar al 50% de la pantalla*/
            margin-left: -181px; /*Restamos la mitad de ancho de la capa para centrarla horizontalmente*/
            width: 361px;
            height: 320px; /*En este caso el height es opcional, si quieres puedes ponerlo, o no*/
            text-align:left;
            background: #ffffff;
        }
    </style>
</head>
<body>
    <form class="form-signin fomulario">

        <div id="divMsj"></div>
        <h1 class="h3 mb-3 font-weight-normal">Login</h1>
        <label for="inputEmail" class="sr-only">Email</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email" required autofocus/><br />
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required/>
        <br />

        <button class="btn btn-lg btn-primary btn-block" type="button" id="btnSubmit">Enviar</button>
        <br />
    <a href="ResgistroOrden.aspx">Registro</a>
    </form>
</body>
</html>
