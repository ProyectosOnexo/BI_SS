<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShakeShak.aspx.cs" Inherits="Form_ShakeShak" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <link href="css/EstiloOrden.css" rel="stylesheet" />
    <script src="js/funciones.js"></script>
    <script src="js/Orden.js"></script>
    <title></title>
</head>
<body>
    <div id="mySidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <h1>Orden</h1>
        <div id="divOrden">
        </div>
        <div>
            <button class="btn btn-primary" id="btnTerminar">Terminar</button>
        </div>
        
    </div>
    <div class="header">
        <div class="logo float-left">
            <img src="https://koala-marketing-api-staging.s3.amazonaws.com/shake-shack/assets/shake-shack-logo-2.svg"></img>
        </div>
        <div class="cuenta float-right">
            <button id="cuenta">Cuenta</button>
            <a href="LoginOrden.aspx">Login</a>
            
        </div>
        <div class="carrito float-right">
            <span style="font-size: 30px; cursor: pointer;" onclick="openNav()">&#9776; Orden</span>
        </div>
    </div>
    <div class="banner">
        <img src="https://koala-marketing-api-staging.s3.amazonaws.com/shake-shack/assets/shake-shack-hero.jpeg" class="img-fluid" />
    </div>
    <div class="menu" id="menu">
        <nav class="">
            <ul id="listaMenu">
                <li><a href="#catBurger" data-ancla="pagos" class="ancla">Hamburguesas</a></li>
                <li><a href="#catPapas">Papas</a></li>
                <li><a href="#catHotdogs">Hot dogs</a></li>
                <li><a href="#catPostres">Postres</a></li>
                <li><a href="#catBbidas">Bebidas</a></li>
            </ul>
        </nav>
    </div>
    <div style="clear: both"></div>
    <div class="menu" id="contenido">
        <div class="tituloCategoria" id="catBurgers">
            <h2>Hamburguesas</h2>
        </div>
        <div class="row" id="divHamburguesas">

            <div class="card col-sm-4 col-xs-6">
                <div class="card " style="width: 100%;">
                    <div class="card-body" id="producto_2771">
                        <img class="card-img-top" src="https://media.koala.fuzzhq.com/resize?source=https://koala-api-production.s3.amazonaws.com/global-products/1x1_5a813616-599f-40f8-95e4-413ac3cce3b4.jpeg&height=400&width=9999&max_quality=85" alt="Card image cap" />
                        <h5 class="card-title" id="nombre_2771">ShackBurger</h5>
                        <input type="hidden" id="modif_2771" value="-1"/>
                        <h4 id="price_2771">$98.00</h4>
                    </div>
                    <div class="card-footer oculta" style="" id="footer_2771">
                        <table id="m_2771">
                            <tr class="numero">
                                <td class="float-left m_934 "><div id="m_934" class="modificador select">LTOP</div></td>
                                <td class="float-left m_935 "><div id="m_935" class="modificador select">Lechuga</div></td>
                            </tr>
                            <tr class="numero">
                                <td class="float-left m_936 "><div id="m_936" class="modificador select">Jitomate</div></td>
                                <td class="float-left m_937 "><div id="m_937" class="modificador select">Cebolla</div></td>
                            </tr>
                            <tr class="numero">
                                <td class="float-left m_2771 "><div id="m_942" class="modificador select costo">Queso Amarillo | 15</div></td>
                                <td class="float-left m_2771 "><div id="m_943" class="modificador select">Mantequilla</div></td>
                            </tr>
                        </table>
                        <input type="number" name="edad" min="1" max="99" step="1" value="1" required="required" id="quan_2771" />
                        <button class="addProducto btn btn-primary" id="pro_2771">+ Agregar</button>
                    </div>
                </div>
            </div>

            
        </div>
        <!-- fin row -->

        <div class="tituloCategoria" id="catPostres">
            <h2>Postres</h2>
        </div>
        <div class="row">
            
        </div>
        <!-- fin row -->
        <div class="tituloCategoria" id="catBbidas">
            <h2>Bebidas</h2>
        </div>
        <div class="row">
        </div>
        <!-- fin row -->
    </div>
</body>
</html>
