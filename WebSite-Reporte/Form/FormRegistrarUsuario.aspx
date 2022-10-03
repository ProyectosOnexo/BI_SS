<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormRegistrarUsuario.aspx.cs" Inherits="Form_FormRegistrarUsuario" %>

<!Doctype html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

    <title>Generar reportes</title>
    <link rel="icon" type="image/png" href="img/favicon.png">
    <link rel="stylesheet" href="css/registrarusuarios.css" />
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/StylePerson.css" />

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <style>
        body{
            width:99%
        }
        .card {
            border-left: none !important;
            border-right: none !important;
            border-bottom: none !important;
            border-top: none !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            var lang = '<%=Session["lang"]%>'
            if (lang == 'en') {
                $('#hlEnglish1').hide()
                $('#hlSpanish1').show()
            }
            else {
                $('#hlSpanish1').hide()
                $('#hlEnglish1').show()
            }

            var idioma = '<%=Session["lang"]%>'
            if (idioma == 'en')
                 $('#btnSubmit').attr('value','Register')
            $('#nombrecompleto').focus();
            //$('#divCarga').attr("style", "display: none !important");
            $("#btnSubmit").click(function () {
                // a valid JSON object
                if ($('#nombrecompleto').val() != '' && $('#contrasena').val() != '' && $('#contrasena2').val() != '' && $('#correo').val() != '') {
                    if ($('#contrasena').val() == $('#contrasena2').val()) {
                        var datos = { 'nombre': $('#nombrecompleto').val(), 'contrasena': $('#contrasena').val(), 'correo': $('#correo').val() };
                        $.ajax({
                            beforeSend: function () {
                                // setting a timeout
                                $('#divRegistro').fadeOut(2000);
                                setInterval(function () { $('#divCarga').fadeIn(3000); }, 1700);
                            },
                            url: 'FormRegistrarUsuario.aspx/Registro',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(datos),
                            dataType: "json",
                            method: 'post',
                            success: function (data) {
                                $('#divCarga').fadeOut(2000);
                                $('#divCarga').remove();
                                //$('#divCarga2').fadeOut(2000);
                                //$('#divCarga').attr("style", "display: none !important");
                                if (data.d == "exitoso")
                                    setInterval(function () { $('#divCompleto').fadeIn(2000); }, 1700);
                                else {
                                    
                                    $('#divRegistro').fadeIn(2000);
                                    alert(data.d)
                                }
                            },
                            error: function (err) {
                                alert(err);
                            }
                        });
                    }
                     else {
                        $('#divMsjRegistro').html('Los campos de contraseña no coinciden');
                        $('#divMsjRegistro').slideDown("slow");
                        setTimeout(function(){ $('#divMsjRegistro').slideUp(); }, 3000);
                    }
                }
                else {
                    $('#divMsjRegistro').html('Todos los campos son obligatorios');
                    $('#divMsjRegistro').slideDown("slow");
                    setTimeout(function(){ $('#divMsjRegistro').slideUp(); }, 3000);
                }
            })
        });
    </script>
</head>
<body>

    <script type="text/javascript">
        function openModal() {
            $('#UsuarioAgregadoCorrectamente').modal('show');
        }
    </script>
    <div class="">
    <div class="row">
        <div class="col-sm">
            <img src="img/Imagen-en-registro-exitoso.png" class="img-fluid" alt="Responsive image" style="" />
        </div>
        <div class="col-sm">
            <div class="" style="display: flex; justify-content: center; align-items: center;">
                <div class="justify-content-center" style="width: 350px">
                    <div class="card   mb-3" style="height: 520px; padding-top: 20px;">
                        <a href="../index.aspx">
                            <img src="img/Logo.png" class="img-fluid" alt="Responsive image" style="display: block; margin-left: auto; margin-right: auto; height: 43px; margin-bottom: 20px; margin-top: 20px;"></a>
                        <hr />
                        <br />
                        
    <div style="display:none">
        <asp:HyperLink ID="hlEnglish1" NavigateUrl="?lang=en" runat="server" Text="Español" />
        <asp:HyperLink ID="hlSpanish1" NavigateUrl="?lang=es" runat="server" Text="English" />

    </div>
                        <form runat="server" autocomplete="off">
                            <div id="divRegistro" style="display: block">
                                <asp:Label runat="server" class="grisFuerte ffGalaxie" style="font-size: 23px; margin-bottom: 0" Text="<%$Resources:multi.language,registro_titulo%>"></asp:Label><br />
                                <asp:Label runat="server"  class="verde" style="font-size: 12px; padding-bottom: 10px;" Text="<%$Resources:multi.language,registro_textotitulo%>"></asp:Label>

                                <%--<div class="input-group form-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <img src="img/Man.png" style="width: 16px" /></span>
                                    </div>
                                    <input id="nombrecompleto" runat="server" type="text" class="form-control contornoVerde" placeholder="Nombre completo" autocomplete="off" required>
                                </div>--%>
                                <div class="divMsj" id="divMsjRegistro"></div>
                                 <div class="form-group has-feedback" style="border-radius: 5px">
                                     <span class="ForeColor939393">
                                         <img src="img/Man.png" alt="Alternate Text" class="form-control-feedback"  style="margin-top: 0;height:40px" />
                                     </span>
                                     <input runat="server" id="nombrecompleto" name="" type="text" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,registro_nombre%>" style="font-size: small"  autocomplete="off" />
                                 </div>

                                <div class="form-group has-feedback" style="border-radius: 5px">
                                     <span class="ForeColor939393">
                                         <img src="img/Mail.png" alt="Alternate Text" class="form-control-feedback" style="margin-top: 3px;height:33px" />
                                     </span>
                                     <input runat="server" id="correo" name="" type="email" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,registro_correo%>"  style="font-size: small"  autocomplete="off" />
                                 </div>

                                <!-- <div class="form-group">
                            <Label>Usuario</Label>
						    <input id="usuario" name="usuario" runat="server" type="text" class="form-control" placeholder="usuario" autocomplete="off" >
					    </div>
                        -->
                                <div class="form-group has-feedback" style="border-radius: 5px">
                                     <span class="ForeColor939393">
                                         <img src="img/Key.png" alt="Alternate Text" class="form-control-feedback" style="margin-top: 0;height:35px" />
                                     </span>
                                     <input runat="server" id="contrasena" name="" type="password" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,registro_contrasena%>"  style="font-size: small"  autocomplete="off" />
                                 </div>

                                <div class="form-group has-feedback" style="border-radius: 5px">
                                     <span class="ForeColor939393">
                                         <img src="img/Key.png" alt="Alternate Text" class="form-control-feedback" style="margin-top: 0;height:35px" />
                                     </span>
                                     <input runat="server" id="contrasena2" name="" type="password" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,registro_repitecontrasena%>"  style="font-size: small"  autocomplete="off" />
                                 </div>


                                <div class="form-group" style="display: none">
                                    <select id="tipousuario" runat="server" class="form-control contornoVerde" name="tipousuario" autocomplete="off">
                                        <option>Gerente</option>
                                        <option>Administrador</option>
                                    </select>
                                </div>
                                <div class="SeleccionarFecha">
                                    <div style="float: left; width: 45%">
                                         <asp:Label runat="server"  class="grisClaro" style="font-size: 12px" Text="<%$Resources:multi.language,registro_termions1%>"></asp:Label><span class="grisFuerte"> <asp:Label runat="server" style="font-size: 12px" Text="<%$Resources:multi.language,registro_terminos2%>"> </asp:Label></span> 
                                    </div>
                                    <div style="float: right; width: 55%">
                                        <input type="button" id="btnSubmit" class="btn btn-primary " style="font-size: 12px; width: 100%" value="Registrar" />
                                        <%--<asp:Button runat="server" type="button" class="btn btn-primary " Style="font-size: 12px; width: 100%" Text="Registrarme" OnClick="RegistrarUsuario_Click"></asp:Button>--%>
                                    </div>
                                </div>
                            </div>
                            <div id="divCarga" style="display: none">
                                <img id="divCarga2" src="img/Linea-de-carga.gif" />
                            </div>
                            <div id="divCompleto" style="display: none">
                                <asp:Label runat="server"  class="grisFuerte ffGalaxie" style="font-size: 23px" Text="<%$Resources:multi.language,regitro_exitoso%>"></asp:Label>
                                <a  href="../index.aspx">>
                                    <img src="img/registro-terminado.gif" /></a>
                            </div>
                            <div style="height: 85px"></div>
                            <hr />

                            <!-- Modal usted se ha registrado correctamente -->
                            <div id="ModalUsuarioRegistrado" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header bg-dark" style="justify-content: center; color: white;">
                                            <h5 class="modal-title">
                                                <asp:Label runat="server"  Text="<%$Resources:multi.language,regitro_exitoso%>"></asp:Label>
                                                <i class="fas fa-check-circle" style="font-size: 1em; color: lawngreen"></i>
                                                <!-- SE ESTABLECE EL VALOR DESDE LA CLASE C# DE ESTE MISMO FORM -->
                                            </h5>
                                        </div>

                                        <div class="modal-body">
                                            <asp:Label runat="server"  Text="<%$Resources:multi.language,regitro_exitoso%>"></asp:Label>
                                        </div>

                                        <div class="modal-footer">
                                            <a class="btn btn-success" href="index.aspx">Finalizar</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Modal Popup -->
                            <script type="text/javascript">
                                function ModalUsuarioRegistrado() {
                                    $("#ModalUsuarioRegistrado").modal("show");
                                }
                            </script>

                            <!-- SEGUNDO MODAL -->
                            <!-- MODAL VALIDAR NOMBRE USUARIO-->
                            <div id="ModalValidarUsuario" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header modal-header-danger" style="justify-content: center">
                                            <h2 class="modal-title">
                                                <label>YA EXISTE </label>
                                                <i class="far fa-frown" style="font-size: 1em; color: whitesmoke"></i>
                                                <!-- SE ESTABLECE EL VALOR DESDE LA CLASE C# DE ESTE MISMO FORM -->
                                            </h2>
                                        </div>

                                        <div class="modal-body">
                                            <h4>
                                                <label>Este nombre de usuario ya existe</label></h4>
                                            <label>Ya tienes una cuenta pero no recuerdas tus datos, ingresa tu correo electrónico y recupera tus datos</label>
                                            <hr />

                                            <div class="form-group">
                                                <h5>
                                                    <label>Ingrese su correo electronico</label></h5>
                                                <input id="RecibirCorreo" runat="server" type="text" class="form-control" placeholder="Ingrese su correo electronico">
                                                <br />
                                                <asp:Button class="btn btn-primary form-control" Text="Recuperar contraseña" runat="server" OnClick="RecuperarContrasena_Click"></asp:Button>
                                            </div>


                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">
                                                Cerrar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Popup -->
                            <script type="text/javascript">
                                function ShowModalValidarUsuario() {
                                    $("#ModalValidarUsuario").modal("show");
                                }
                            </script>

                            <!-- CUARTO MODAL -->
                            <!-- MODAL ENVIAR NOMBRE USUARIO Y CONTRASEÑA-->
                            <div id="ModalEnviarCorreo" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header modal-header-enviar" style="justify-content: center">
                                            <h3 class="modal-title">
                                                <label>EL CORREO HA SIDO ENVIADO</label>
                                                <i class="fas fa-envelope-square" style="font-size: 1em; color: lawngreen"></i>
                                                <!-- SE ESTABLECE EL VALOR DESDE LA CLASE C# DE ESTE MISMO FORM -->
                                            </h3>
                                        </div>

                                        <div class="modal-body">
                                            <h4>
                                                <label>Rebice su bandeja de entrada, el correo con la informacion de su cuenta ha sido enviado.</label></h4>
                                            <label>
                                                En caso de que no reciba el correo, intentelo de nuevo, si el problema continua pongase en contacto
                                            con el administrador.
                                            </label>
                                            <hr />

                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">
                                                Cerrar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Popup -->
                            <script type="text/javascript">
                                function ShowEnviarCorreo() {
                                    $("#ModalEnviarCorreo").modal("show");
                                }
                            </script>

                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    </div>
</body>
</html>
