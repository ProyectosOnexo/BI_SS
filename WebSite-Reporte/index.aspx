<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Form_Inicio" %>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>Inicio</title>
    <link rel="icon" type="image/png" href="Form/img/favicon.png">
    <link rel="stylesheet" href="Form/css/Inicio.css" />
    <link rel="stylesheet" href="Form/css/bootstrap.css" />
    <link rel="stylesheet" href="Form/css/bootstrap.min.css" />
    <link rel="stylesheet" href="Form/css/StylePerson.css" />

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" />

    <script src="Form/js/popper.min.js"></script>
    <script src="Form/js/jquery-3.3.1.min.js"></script>
    <script src="Form/js/bootstrap.js"></script>
    <script src="Form/js/bootstrap.min.js"></script>
    <style>
        
    </style>
    <script>

        $(document).ready(function () {
            $('#correo').focus();
            var lang = '<%=Session["lang"]%>'
            if (lang == 'en') {
                $('#hlEnglish1').hide()
                $('#hlSpanish1').show()
            }
            else {
                $('#hlSpanish1').hide()
                $('#hlEnglish1').show()
            }
           $("#btnRecuperar").click(function () {
                // a valid JSON object
                
               if ($('#RecibirCorreo').val() != '') {
                    var datos = { 'RecibirCorreo': $('#RecibirCorreo').val() };
                    $.ajax({
                        //beforeSend: function () {
                        //    // setting a timeout
                        //    $('#divRegistro').fadeOut(2000);
                        //    setInterval(function () { $('#divCarga').fadeIn(3000); }, 1700);
                        //},
                        url: 'index.aspx/EnviarCorreoElectronico_Click',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            mcxDialog.alert(data.d, {
                                titleText: "Shake shack",
                                sureBtnText: "Ok"
                            });
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            })
        });

    </script>
</head>
<body>

    <div id="EnviarCorreoModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content fondoGrisFuerte" style="padding: 15px;">
                <div class="ffGalaxie titulo">Error</div>
                <div class="verde texto"></div>
                <%--<i class="fas fa-exclamation-circle" style="font-size: 25px; color: red"></i>--%>
                <%--<div class="input-group form-group">
                                            <div class="input-group-prepend ">
                                                <span class="input-group-text fondoGrisFuerte" style="border:none!important">
                                                    <img src="img/Mail.png" style="width: 18px" /></span>
                                            </div>
                                            <input id="RecibirCorreo" runat="server" type="text" class="form-control contornoVerde fondoGrisRecuperar grisClaro" placeholder="Ingrese su correo electronico">
                                            <br />
                                        </div> --%>
                <div class="form-group has-feedback" style="border-radius: 5px">
                    <span class="ForeColor939393">
                        <img src="Form/img/Mail.png" alt="Alternate Text" class="form-control-feedback" style="margin-top: 3px; height: 33px" />
                    </span>
                    <input  id="RecibirCorreo" name="" type="email" class="form-control BordeRadious fondoGrisRecuperar grisClaro" placeholder="correo electrónico" style="font-size: small" autocomplete="off" />
                </div>
                <button class="btn btn-primary form-control" id="btnRecuperar">Recuperar contraseña</button>

            </div>
        </div>
    </div>
    <img src="Form/img/Logo2.jpg" class="img-fluid" alt="Responsive image">
    <div class="container">
        <img src="Form/img/Logo.png" class="img-fluid" alt="Responsive image" style="display: block; margin-left: auto; margin-right: auto; height: 43px; margin-bottom: 20px; margin-top: 20px;">
        <div style="clear: both"></div>
        <hr />
        <div class="row">
            <div class="col-md-6">
                <div>
                    <div class="card-body card-body2">
                        <form runat="server" autocomplete="off">
                            <div class="form-group" style="text-align: left">

                                <div style="display: none">
                                    <asp:HyperLink ID="hlEnglish1" NavigateUrl="?lang=en" runat="server" Text="Español" />
                                    <asp:HyperLink ID="hlSpanish1" NavigateUrl="?lang=es" runat="server" Text="English" />
                                </div>

                                <label class="grisFuerte ffGalaxie titulo" style="">Login</label>
                                <br />
                                <%--<label class="verde texto" style="">introduce tu información</label>--%>
                                <asp:Label runat="server" class="verde texto" Text="<%$Resources:multi.language,login_introduceinformacion%>"></asp:Label>
                            </div>



                            <div class="form-group has-feedback" style="border-radius: 5px">
                                <span class="ForeColor939393">
                                    <img src="Form/img/Mail.png" alt="Alternate Text" class="form-control-feedback" style="margin-top: 3px; height: 33px" />
                                </span>
                                <input runat="server" id="correo" name="correo" type="email" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,login_correo%>" style="font-size: small" autocomplete="off" required />
                            </div>

                            <div class="form-group has-feedback" style="border-radius: 5px">
                                <span class="ForeColor939393">
                                    <img src="Form/img/kEY.png" alt="Alternate Text" class="form-control-feedback" style="margin-top: 3px; height: 33px" />
                                </span>
                                <input runat="server" id="contrasena" name="contrasena" type="password" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,login_contrasena%>" style="font-size: small" autocomplete="off" required />
                            </div>

                            <div class="SeleccionarFecha">
                                <div style="float: left; width: 50%">
                                    <a href="#" style="text-decoration: none; font-size: 12px" data-toggle="modal" data-target="#EnviarCorreoModal" class="grisClaro">
                                        <asp:Label runat="server" Text="<%$Resources:multi.language,login_olvidaste%>"></asp:Label>
                                    </a>
                                </div>
                                <div style="float: right; width: 50%">
                                    <asp:Button runat="server" type="button" class="btn btn-primary" OnClick="IniciarSesion_Click" Style="font-size: 12px; width: 100%" Text="<%$Resources:multi.language,login_botoninicio%>" ID="btnLogin" />
                                    <%--<asp:Button type="button" runat="server" cssclass="button" text="login" id="btnLogin"/>--%>
                                </div>
                            </div>
                            <div style="clear: both"></div>
                            <hr class="">
                            <div class="SeleccionarFecha">
                                <div style="float: left; width: 50%">
                                    <%--<label class="grisFuerte texto" style="">¿No tienes cuenta?</label>--%>
                                    <asp:Label runat="server" class="grisFuerte texto" Text="<%$Resources:multi.language,login_nocuenta%>"></asp:Label>
                                </div>
                                <div style="float: right; width: 50%">
                                    <a href="Form/FormRegistrarUsuario.aspx">
                                        <input runat="server" type="button" class="btn btn-primary" style="font-size: 12px; width: 100%" value="<%$Resources:multi.language,login_botonregistrate%>" /></a>
                                </div>

                            </div>
                            <!-- MODAL PARA ENVIAR CORREO   -->

                            <!-- MODAL ERROR CORREO  -->
                            <div id="CorreoErroneo" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header bg-dark" style="justify-content: center; color: white;">
                                            <h5 class="modal-title">
                                                <asp:Label runat="server" Text="<%$Resources:multi.language,login_invalido%>"></asp:Label>
                                                <i class="fas fa-exclamation-circle" style="font-size: 25px; color: red"></i>
                                            </h5>
                                        </div>

                                        <div class="modal-body">
                                            <div class="form-group">
                                                <h5>
                                                    <asp:Label runat="server" Text="<%$Resources:multi.language,login_mensajeinvalido%>"></asp:Label></h5>
                                                <br />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Modal Popup -->
                            <script type="text/javascript">
                                function CorreoErroneo() {
                                    $("#CorreoErroneo").modal("show");
                                }
                            </script>
                            <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content fondoGrisFuerte" style="padding: 15px">
                                        <%--<i class="fas fa-exclamation-circle" style="font-size: 25px; color: red"></i>--%>
                                        <div class="verde ffGalaxie titulo">
                                            <asp:Label runat="server" Text="<%$Resources:multi.language,login_datosincorrectos%>"></asp:Label></div>
                                        <div class="verde droidSans texto">
                                            <asp:Label runat="server" Text="<%$Resources:multi.language,login_verificar%>"></asp:Label></div>
                                        <div class="grisClaro droidSans texto">
                                            <asp:Label runat="server" Text="<%$Resources:multi.language,login_incorrectos%>"></asp:Label></div>
                                    </div>
                                </div>
                            </div>
                            <!-- Modal Popup -->
                            <script type="text/javascript">
                                function ShowModal() {
                                    $("#myModal").modal("show");
                                }
                            </script>
                            <!-- MODAL ENVIAR NOMBRE USUARIO Y CONTRASEÑA-->
                            <div id="ModalCorreoEnviado" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header bg-dark" style="justify-content: center">
                                            <h3 class="modal-title">
                                                <asp:Label runat="server" Text="<%$Resources:multi.language,login_correoenviado%>"></asp:Label>
                                                <i class="fas fa-envelope-square" style="font-size: 1em; color: lawngreen"></i>
                                                <!-- SE ESTABLECE EL VALOR DESDE LA CLASE C# DE ESTE MISMO FORM -->
                                            </h3>
                                        </div>
                                        <div class="modal-body" style="color: black">
                                            <h4>
                                                <asp:Label runat="server" Text="<%$Resources:multi.language,login_revise%>"></asp:Label>
                                            </h4>
                                            <asp:Label runat="server" Text="<%$Resources:multi.language,login_mensajerevise%>"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Popup -->
                            <script type="text/javascript">
                                function ModalCorreoEnviado() {
                                    $("#ModalCorreoEnviado").modal("show");
                                }
                            </script>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6" style="">
                <%--<div class="card border-primary text-white mb-3 bg-dark">--%>
                <div>
                    <div class="card-body card-body3">
                        <%--<label class="grisFuerte ffGalaxie" style="font-size: 23px">Sistema de generación de reportes</label>--%>
                        <asp:Label runat="server" class="grisFuerte ffGalaxie" Style="font-size: 23px" Text="<%$Resources:multi.language,login_sistema%>"></asp:Label>
                        <div class="form-inline">
                            <!--
                                <div id="fb-root"></div>
                                <script>(function(d, s, id) {
                                  var js, fjs = d.getElementsByTagName(s)[0];
                                  if (d.getElementById(id)) return;
                                  js = d.createElement(s); js.id = id;
                                  js.src = 'https://connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v3.2';
                                  fjs.parentNode.insertBefore(js, fjs);
                                }(document, 'script', 'facebook-jssdk'));</script>
                                <div class="fb-page" data-href="https://www.facebook.com/facebook" data-tabs="timeline" data-width="400" data-height="200" data-small-header="true" data-adapt-container-width="true" data-hide-cover="true" data-show-facepile="true"><blockquote cite="https://www.facebook.com/facebook" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/facebook">Facebook</a></blockquote></div>
                                -->
                            <p class="grisClaro" style="font-size: 14px">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,login_sistemadesc1%>"></asp:Label>&nbsp;<span class="grisFuerte"><asp:Label runat="server" class="" Text="<%$Resources:multi.language,login_sistemadesc2%>"></asp:Label></span>&nbsp;<asp:Label runat="server" class="" Text="<%$Resources:multi.language,login_sistemadesc3%>"></asp:Label>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>


</html>
