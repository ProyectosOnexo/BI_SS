<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IndexPlantilla.aspx.cs" Inherits="Form_IndexPlantilla" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>Generar reportes</title>

    <link rel="stylesheet" href="css/DiseñosAll.css"/>
    <link rel="stylesheet" href="css/StyloIndexPlantilla.css"/>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"/>

    <script src="js/popper.min.js"></script>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />


    <link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />
   
    <script src="js/bootstrap-datepicker.fr.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
    
</head>
<body>
    <form runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"/>

    <div class="wrapper">

        <div id="sidebar">
        <div class="sidebar-header">
            <label id="MenuTitulo">Menu</label>
        </div>

        <ul id="sideBarMenu" class="list-unstyled components">
            <li class="nav-item active">
                <a href="#">
                    <span style="color: #6db23f"><i class="fas fa-file-alt"></i></span>
                </a>
            </li>
        </ul>
    </div>

    <div>
        <button type="button" id="sidebarCollapse" class="btn" style="background: #6db23f; color: white; width: 60px;">
            <i class="fas fa-align-justify"></i>
        </button>
    </div>
       
       <div id="content-wrapper">
         
          <div class="container">
            <nav class="navbar navbar-expand-lg navbar-custom navbar-light" style="margin-top: 10px">

                <button class="navbar-toggler ml-auto hidden-sm-up float-xs-right" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span><i class="navbar-toggler-icon"></i></span>
                </button>

                <div class="collapse navbar-collapse justify-content-betwee" id="navbarNav">
                    <ul class="navbar-nav mr-auto">
                     
                    </ul>

                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="dropdown-toggle TipodeLetraDroid" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: black; text-decoration: none; font-size: 13px; text-align:center">
                                <asp:Label runat="server" ID="Usuario"> 
                                Usuario
                                </asp:Label>
                            </a>
                    
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink" style="text-align: center">
                                <asp:Button runat="server" Font-Size="13px" Class="dropdown-item" Text="Cerrar Sesion" BackColor="White" ForeColor="Black"/>
                            </div>
              
                        </li>

                        <li class="nav-item avatar">
                            <asp:Image id="AvatarImg" src="https://www.tribuna.com.mx/__export/1532138431386/sites/tribuna/img/2018/07/20/broly_2_2.jpg_1201711668.jpg" 
                            style="margin-left: 10px; margin-top: -10px" width="45" height="45"
                            class="rounded-circle z-depth-0" alt="avatar image" runat="server" />
                        </li>
                    </ul>

                </div>
            </nav>
          </div>
          
        <hr />  
        <br />
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate> 

        </ContentTemplate>
        </asp:UpdatePanel>
    </div>   
</div>



     <!-- MODAL MENSAJE POPUP-->
    <div id="MyPopup" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header modal-header-danger" style="justify-content:center; background-color: darkorange; height: 30px;">   
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding-top: 0; color: white; font-size: 20px">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <h4><Label>INGRESE LA INFORMACION SOLICITADA</Label></h4>
                    <Label>Por favor ingrese la fecha y seleccione una tienda</Label>
                    <br />

                </div>
            </div>
        </div>
    </div>

      <script>		
            $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
        });
	</script>
    </form>
</body>
</html>
