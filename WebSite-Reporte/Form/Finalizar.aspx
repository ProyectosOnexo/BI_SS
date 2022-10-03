<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Finalizar.aspx.cs" Inherits="Form_Finalizar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <link href="css/EstiloOrden.css" rel="stylesheet" />
    <script src="js/Orden.js"></script>
    <title></title>
    <script>
        $(document).ready(function () {
            Terminar() 
        })
    </script>
</head>
<body>
    <a class="logo float-left" href="ShakeShak.aspx">
        <img src="https://koala-marketing-api-staging.s3.amazonaws.com/shake-shack/assets/shake-shack-logo-2.svg"></img>
    </a>
    <div style="clear:both"></div>
    <h5>¡Presenta el código siguiente en caja y listo!</h5>
    <div id="qr"></div>
    <a class="logo float-left" href="ShakeShak.aspx">
        <img src="https://koala-marketing-api-staging.s3.amazonaws.com/shake-shack/assets/shake-shack-logo-2.svg"></img>
    </a>
</body>
</html>
