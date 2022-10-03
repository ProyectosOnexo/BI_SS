<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportesInicio.aspx.cs" Inherits="Form_ForReportesInicio" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>Inicio</title>

    <link rel="stylesheet" href="css/reporteinicio.css"/>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
   
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"/> 

</head>
<body>
    <form runat="server">
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark navbar-custom">
        <!-- Brand -->
          <a class="navbar-brand" style="color: whitesmoke">EKS</a>
          <button class="navbar-toggler mr-3" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
            
          <div class="collapse navbar-collapse" id="navbarNav">
             <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.aspx">Inicio</a>
                </li>
                 <li class="nav-item active">
                    <a class="nav-link" href="ReportesInicio.aspx">Reportes</a>
                </li>
              </ul>

              <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: limegreen; text-decoration: none">
                        <asp:Label runat="server" ID="Usuario"> 
                            
                        </asp:Label>
                    </a>
                    
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                        <asp:Button runat="server" Class="dropdown-item" OnClick="CerrarSesion_Click" Text="Cerrar Sesion"/>
                    </div>
                    
                    
                  </li>
              </ul>

            </div>
        </nav>
    </header>

        
    <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
    <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    <div id="wrapper">
      <!-- Sidebar -->
      <ul class="sidebar navbar-nav navbar-custom2">
        <li class="nav-item" style="text-align: center">
            <h5><label style="color: white; margin-top: 15px">INFORMACION</label></h5>
            <hr style="background-color: darkcyan" />
        </li>

        <li class="nav-item">
            <a class="nav-link" href="FormReporteDiario.aspx">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>REPORTE DIARIO</span></a>
        </li>

          <li class="nav-item" >
            <a class="nav-link" href="FormReporteHora.aspx">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>REPORTE POR HORAS Y LABOR</span></a>
          </li>

          <li class="nav-item">
            <a class="nav-link" href="">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>REPORTE INFORME DE CAJA CHICA</span></a>
          </li>

          <li class="nav-item">
            <a class="nav-link" href="FormReporteVelocidadDelServicio.aspx">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>REPORTE VELOCIDAD DEL SERVICIO</span></a>
          </li>

        </ul>

      <div id="content-wrapper">
        <div class="container-fluid">

          <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="index.html">REPORTES</a>
            </li>
            <li class="breadcrumb-item active">INFORMACION</li>
          </ol>
 
        

        <div class="row">
            <div class="col-md-9">
                    
            </div>

        </div>


        </div>

      </div>
    </div>
    </form>
</body>
</html>
