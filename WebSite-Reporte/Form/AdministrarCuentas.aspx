<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdministrarCuentas.aspx.cs" Inherits="Form_AdministrarCuentas" MasterPageFile="~/Form/MasterPage.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content2" runat="Server">
    <link href="css/StyleReporteDiario.css" rel="stylesheet" />
    <style>
        .form-control {
            height: 32px !important;
        }

        .btn {
            background-color: #fff !important;
            border: 1px solid #6db23f;
            color: #939393 !important;
        }

        .prueba {
            width: 80px;
            /*height:100px;*/
            background-color: #fff;
            display: none;
            position: absolute;
            border: 1px solid #939393;
            padding-left: 10px;
            padding-right: 10px;
        }

        .vertical-menu a {
            background-color: #fff;
            color: black;
            display: block;
            padding: 5px;
            text-decoration: none;
            font-size: 12px;
        }

            .vertical-menu a:hover {
                background-color: #6db23f !important;
                color: #fff;
            }

            .vertical-menu a.active {
                background-color: #6db23f;
                color: white;
            }
    </style>
    <script>        
        var pref = "Content2_"
        $(document).ready(function () {
            var idioma = '<%=Session["lang"]%>'
            var tiendas = 'Tiendas'
            if (idioma == 'en') {
                $('#btnRegistrados').attr('value', 'Search')
                $('#btnSolicitudes').attr('value', 'Search')
                $('#divUsuariosPendientes').text('0 Records')
                $('#divUsuariosActivos').text('0 Records')
                tiendas = 'Stores'
            }

            n = new Date(); y = n.getFullYear(); m = n.getMonth() + 1; d = n.getDate();
            $('#' + pref + 'date1').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date2').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date3').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date4').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            $("#btnSolicitudes").click(function () {
                //var datos = {'f1':$('#'+pref+'date1').val(),'f2':$('#'+pref+'date2').val(),'nombre':$('#'+pref+'txtNombreSolicitudes').val(),'opcion':1};
                var datos = { 'f1': '', 'f2': '', 'nombre': $('#' + pref + 'txtNombreSolicitudes').val(), 'opcion': 1 };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaSolicitudes',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = ''
                        if (data.d.length > 0) {
                            $("#divUsuariosPendientes ").html('Registros ' + data.d.length)
                            $.each(data.d, function (index, value) {
                                html += '<tbody>'
                                html += '<tr >'
                                html += '<td width="30%">' + value.Nombre
                                html += '</td>'
                                html += '<td width="10%">' + value.Rol
                                html += '</td>'
                                html += '<td width="30%">' + value.Correo
                                html += '</td>'
                                html += '<td width="10%">' + value.Fecha
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button" id="btnR_' + value.Id + '" value="Rechazar" class=" btnRechazar "/>'
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button" id="btnA_' + value.Id + '" value="Aceptar" class=" btnAceptar "/>'
                                html += '</td>'
                                html += '</tr>'
                                html += '</tbody>'
                                if (idioma == 'en') {
                                    $("#divUsuariosPendientes ").html(data.d.length + ' Redords')
                                }
                                else
                                    $("#divUsuariosPendientes ").html(data.d.length + ' Registros')
                            })
                        }
                        else {
                            html += '<tbody>'
                            html += '<tr >'
                            html += '<td alig="center">' + '-'
                            html += '</td>'
                            html += '</tr>'
                            html += '</tbody>'
                        }
                        $("#tablaSolicitudes tbody").empty()
                        $("#tablaSolicitudes").append(html)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            })
            $("#btnRegistrados").click(function () {
                //var datos = {'f1':$('#'+pref+'date3').val(),'f2':$('#'+pref+'date4').val(),'nombre':$('#'+pref+'txtNombreRegistrado').val(),'opcion':2};
                var datos = { 'f1': '', 'f2': '', 'nombre': $('#' + pref + 'txtNombreRegistrado').val(), 'opcion': 2 };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaSolicitudes',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {

                        var html = ''
                        if (data.d.length > 0) {
                            $.each(data.d, function (index, value) {
                                //html += '<table class="table">'
                                html += '<tbody  class="table">'
                                html += '<tr >'
                                html += '<td width="20%">' + value.Nombre
                                html += '</td>'
                                html += '<td width="10%" class="tdOcultar">' + value.Rol
                                html += '</td>'
                                html += '<td width="20%" class="tdOcultar">' + value.Correo
                                html += '</td>'
                                html += '<td width="10%" class="tdOcultar">' + value.Fecha
                                html += '</td>'
                                html += '<td width="10%">' + value.Fechaacceso
                                html += '</td>'
                                html += '<td width="10%" class="tdOcultar">' + value.Estado
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button" id="btnA_' + value.Id + '" value="Admin" class=" btnMenu "/>'//<br/> <div class="vertical-menu prueba" id="prueba_' + value.Id + '">  <a href="#" class="btnMMenu" name="act_1_' + value.Id + '">Activar</a>  <a href="#" style="border-top:1px solid #939393;border-bottom:1px solid #939393;" class="btnMMenu" name="del_3_' + value.Id + '">Eliminar</a>  <a href="#" class="btnMMenu" name="blo_4_' + value.Id + '">Bloquear</a> </div>'
                                html += '</td>'
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button" id="btnS_' + value.Id + '" value="' + tiendas + '" class="  btnSucursales"/> </div>'
                                html += '</td>'
                                html += '</tr>'
                                html += '</tbody >'
                                //html += '</table>'
                                if (idioma == 'en') {
                                    $("#divUsuariosActivos ").html(data.d.length + ' Redords')
                                }
                                else
                                    $("#divUsuariosActivos ").html(data.d.length + ' Registros')
                            })
                        }
                        else {
                            html += '<tbody>'
                            html += '<tr >'
                            html += '<td alig="center">' + '-'
                            html += '</td>'
                            html += '</tr>'
                            html += '</tbody>'
                        }
                        $("#tablaRegistrados tbody").empty()
                        $("#tablaRegistrados").append(html)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            })

            //$('body').click(function () {

            //     $('.btnMenu').attr('value', 'Admin');
            //    $(".prueba").hide()
            //   // do something here
            //});
            $('#btnGuardarSucursales').click(function () {
                var id = $('#idUsuario').val()
                var sucursales = '';
                $("input[name=cmbSucursales]").each(function (index) {
                    if ($(this).is(':checked')) {
                        sucursales += $(this).val() + ",";
                    }
                });
                if (id > 0) {
                    var datos = { 'usuario': id, 'sucursales': sucursales };
                    $.ajax({
                        url: 'AdministrarCuentas.aspx/GuardarSucursales',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            mcxDialog.alert(data.d, {
                                titleText: "Shake shack",
                                sureBtnText: "Ok"
                            });
                            $('#btnCloseSucursales').click()
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });
        });
        $(document).on('click', '.btnMenu', function (event) {
            var id = $(this).attr('id')

            $("#modalAdmin").modal();
            $('#idUsuarioAdmin').val(id.split('_')[1])
            //var texto = $(this).attr('value')
            //var a = id.split('_')
            //if (texto != 'Cerrar') {
            //    $(this).attr('value', 'Cerrar');
            //    $('#prueba_' + a[1]).show();
            //}
            //else {
            //     $(this).attr('value', 'Admin');
            //    $(".prueba").hide()
            //}
        });
        $(document).on('click', '.btnAceptar', function (event) {
            var id = $(this).attr('id')
            var a = id.split('_')
            if (a.length > 0) {
                var datos = { 'id': a[1], 'respuesta': 1 };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/Procesar',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        mcxDialog.alert("¡Solicitud atendida!", {
                            titleText: "Shake shack",
                            sureBtnText: "Ok"
                        });
                        $("#btnSolicitudes").click()
                        $("#btnRegistrados").click()
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
        });
        $(document).on('click', '.btnRechazar', function (event) {
            var id = $(this).attr('id')
            var a = id.split('_')
            if (a.length > 0) {
                var datos = { 'id': a[1], 'respuesta': 2 };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/Procesar',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        mcxDialog.alert("¡Solicitud atendida!", {
                            titleText: "Shake shack",
                            sureBtnText: "Ok"
                        });
                        $("#btnSolicitudes").click()
                        $("#btnRegistrados").click()
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
        });
        $(document).on('click', '.btnMMenu', function (event) {
            var opcion = $(this).attr('name')
            var idAdmin = $('#idUsuarioAdmin').val()
            var a = opcion.split('_')
            var datos = { 'opcion': a[1], 'id': idAdmin };
            mcxDialog.confirm("¿Desea realizar esta acción?", {
                sureBtnText: "Si",
                sureBtnClick: function () {

                    $.ajax({
                        url: 'AdministrarCuentas.aspx/ProcesarRegistrado',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            mcxDialog.alert("¡Solicitud atendida!", {
                                titleText: "Shake shack",
                                sureBtnText: "Ok"
                            });
                            $("#btnRegistrados").click()
                            $('#btnCloseAdmin').click()
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });/*
            if (r == true) {
                var opcion = $(this).attr('name')
                var idAdmin =$('#idUsuarioAdmin').val()
                var a = opcion.split('_')
                console.log('opcion '+ a[1]+ ' id '+ idAdmin )
                var datos = { 'opcion': a[1],'id': idAdmin };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ProcesarRegistrado',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        mcxDialog.alert("¡Solicitud atendida!", {
				                        titleText: "Shake shack",
				                        sureBtnText: "Ok"
			                        });
                        $("#btnRegistrados").click()
                         $('#btnCloseAdmin').click()
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            } */
            $(".prueba").hide()
        });
        $(document).on('click', '.btnSucursales', function (event) {
            var id = $(this).attr('id')
            var a = id.split('_')
            if (a.length > 0) {
                var datos = { 'usuario': a[1] };
                $('#idUsuario').val(a[1])
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaSucursales',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        $("#myModal").modal();
                        var html = ''
                        $.each(data.d, function (index, value) {
                            html += '<input type="checkbox" name="cmbSucursales" id="' + value.Id_local + '" value="' + value.Id_local + '" '
                            if (value.Estado == true) html += 'checked = checked'
                            html += '> <label for="' + value.Id_local + '">' + value.Nombre + '</label><br>'
                        })
                        $("#divSucursales").html(html)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
        });

    </script>
    <style>
        .btn {
            background-color: #fff !important;
            border: 1px solid #6db23f;
            color: #939393 !important;
        }
        .table-cont{
            /**make table can scroll**/
            max-height: 210px;
            overflow: auto;
            margin-top: 10px;
            margin-left: 0;
            /*box-shadow: 0 0 2px 3px #ddd;*/
        }
    </style>
    <script>
        $(document).ready(function () {
            var idioma = '<%=Session["lang"]%>'
            var editar ='Editar'
            var eliminar ='Eliminar'
            var detalle = 'Detalle'
            if (idioma == 'en') {
                $('#lblTitulotienda').text("Groups of stores");
                $('#lbltiendanombre').text("Name");
                $('#lbltiendadetalle').text("Detail");
                $('#lbltiendaeditar').text("Edit");
                $('#lbltiendaeliminar').text("Delete");
                $('#lbltiendasucursles').text("Stores");
                $('#lbltiendanuevo').text("New group");
                $('#lbltiendaasignacion').text("Stores assignment");
                $('#btnCloseAdmin').attr('value', 'Close')
                $('#btnContinuar').attr('value', 'Continue')
                $('#btnGuardar').attr('value', 'Save')
                $('#btnGrupoTiendas').attr('value', 'Search')
                $('#btnAgregar').attr('value', 'Add')
             editar ='edit'
             eliminar ='delete'
             detalle ='detail'
            }
            $("#btnGrupoTiendas").click(function () {
                $.ajax({
                    url: 'GrupoTiendas.aspx/ConsultaGrupos',
                    contentType: "application/json; charset=utf-8",
                    //data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {

                        var html = ''
                        if (data.d.length > 0) {
                            $.each(data.d, function (index, value) {
                                html += '<tbody  class="table">'
                                html += '<tr >'
                                html += '<td width="50%">' + value.Sucursal
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button" class="detalle" id="det_' + value.Id + '" value="' + detalle + '" class="  btnSucursales"/> </div>'
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button"  class="editar" id="up_' + value.Id + '" value="' + editar + '" name="'+ value.Sucursal+'" class="  btnSucursales"/> </div>'
                                html += '</td>'
                                html += '<td width="10%">' + '<input type="button"  class="eliminar" id="del_' + value.Id + '" value="' + eliminar + '" class="  btnSucursales"/> </div>'
                                html += '</td>'
                                html += '</tr>'
                                html += '</tbody >'
                            })
                        }
                        else {
                            html += '<tbody>'
                            html += '<tr >'
                            html += '<td alig="center">' + 'Sin resultados'
                            html += '</td>'
                            html += '</tr>'
                            html += '</tbody>'
                        }
                        $("#tablaGrupos tbody").empty()
                        $("#tablaGrupos").append(html)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            })
            $(document).on('click', '#btnAgregar', function (event) {
                $("#divSucursalesTiendasNombres").empty()
                $("#divNombre").show();
                $("#btnContinuar").show();
                $("#divSucursalesTiendas").hide();
                $("#btnGuardar").hide();
                $("#txtNombreGrupoTiendas").val('');
                $("#txtNombreGrupoTiendas").focus();
                $("#modalAgregar").modal();
            });
            $(document).on('click', '#btnGuardar', function (event) {
                var a = $("#txtNombreGrupoTiendas").val();
                var id = $('#txtIdGrupoTiendas').val() 
                var sucursales = '';
                $("input[name=cmbSucursales]").each(function (index) {
                    if ($(this).is(':checked')) {
                        sucursales += $(this).val() + ",";
                    }
                });
                if (a.length > 0 ) {
                    var datos = { 'id':(id === null || typeof id === "object" || id =='' ? 0:id ),'grupo': a, 'sucursales': sucursales };
                    $.ajax({
                        url: 'GrupoTiendas.aspx/GuardarGrupos',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            mcxDialog.alert(data.d, {
				                        titleText: "Shake shack",
				                        sureBtnText: "Ok"
			                        });
                            $('#txtIdGrupoTiendas').val(0)
                            $('#btnCloseAdmin').click()
                            $("#btnGrupoTiendas").click()
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });
            $(document).on('click', '.editar', function (event) {
                var id = $(this).attr('id')
                var nombre = $(this).attr('name')
                var a = id.split('_')
                console.log(a)
                $("#divSucursalesTiendasNombres").empty()
                $("#divNombre").show();
                $("#btnContinuar").show();
                $("#divSucursalesTiendas").hide();
                $("#btnGuardar").hide();
                $("#txtNombreGrupoTiendas").val(nombre);
                $("#txtIdGrupoTiendas").val(a[1]);
                $("#txtNombreGrupoTiendas").focus();
                $("#modalAgregar").modal();
            });

            $(document).on('click', '.detalle', function (event) {
                var id = $(this).attr('id')
                var a = id.split('_')
                var datos = { 'grupo': a[1] };
                console.log(a)
                if (a.length > 0) {
                    $.ajax({
                        url: 'GrupoTiendas.aspx/SucursalesGrupo',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            var html = ''
                            if (data.d.length > 0) {
                                $.each(data.d, function (index, value) {
                                    html += '<label>' + value.Sucursal + '</label><br>'
                                })
                            }
                            else {
                                html += '<label>Sin resultados</label>'
                            }
                            $("#divSucursalesTiendasGrupo").html('')
                            $("#divSucursalesTiendasGrupo").html(html)

                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
            });
            $(document).on('click', '.eliminar', function (event) {
					    var id = $(this).attr('id')
                        console.log(id)
                mcxDialog.confirm("¿Desea eliminar el registro?", {
				    titleText: "Shake shacke",
				    sureBtnText: "Si",
				    cancelBtnText: "No",
				    sureBtnClick: function() {  // Confirm button click callbac
                        var a = id.split('_')
                        var datos = { 'grupo': a[1] };
                        if (a.length > 0) {
                            $.ajax({
                                url: 'GrupoTiendas.aspx/EliminarGrupos',
                                contentType: "application/json; charset=utf-8",
                                data: JSON.stringify(datos),
                                dataType: "json",
                                method: 'post',
                                success: function (data) {
                                    mcxDialog.alert(data.d, {
				                        titleText: "Shake shack",
				                        sureBtnText: "Ok"
			                        });
                                    $("#btnGrupoTiendas").click()

                                },
                                error: function (err) {
                                    alert(err);
                                }
                            });
                        }
				    }
                });

                //var res = confirm('¿Desea eliminar el registro?')
                //if (res) {
                //    var id = $(this).attr('id')
                //    var a = id.split('_')
                //    var datos = { 'grupo': a[1] };
                //    console.log(a)
                //    if (a.length > 0) {
                //        $.ajax({
                //            url: 'GrupoTiendas.aspx/EliminarGrupos',
                //            contentType: "application/json; charset=utf-8",
                //            data: JSON.stringify(datos),
                //            dataType: "json",
                //            method: 'post',
                //            success: function (data) {
                //                alert(data.d)
                //                $("#btnGrupoTiendas").click()

                //            },
                //            error: function (err) {
                //                alert(err);
                //            }
                //        });
                //    }
                //}
            });
            $(document).on('click', '#btnContinuar', function (event) {
                continuarGrupo()                 
            });
            $("#modalAgregar").keypress(function(e) {
                if (e.which == 13) {
                    return false;
                }
            });
            //$("#txtNombreGrupoTiendas").keypress(function (e) {              });
            
        })
        function continuarGrupo() {
            var a = $("#txtNombreGrupoTiendas").val();
                if (a.length > 0) {
                    $("#divNombre").hide();
                    $("#btnContinuar").hide();
                    $("#divSucursalesTiendas").show();
                    $("#btnGuardar").show();
                    var id = $('#txtIdGrupoTiendas').val()
                    var datos = { 'grupo': (id === null || typeof id === "object" || id =='' ? 0:id ) };
                    console.log(datos)
                    $.ajax({
                        url: 'GrupoTiendas.aspx/ConsultaSucursales',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            var html = ''
                            $.each(data.d, function (index, value) {
                                html += '<input type="checkbox" name="cmbSucursales" id="' + value.Id + '" value="' + value.Id + '" '
                                if (value.Estado == 1) html += 'checked = checked'
                                html += '> <label for="' + value.Id + '">' + value.Sucursal + '</label><br>'
                            })
                            $("#divSucursalesTiendasNombres").html(html)
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }
                else {
                    $("#divMsj").html('El nombre debe ser válido')
                    $("#divMsj").slideDown()
                    setTimeout(function () { $("#divMsj").slideUp() }, 3000);
                }
        }
        window.onload = function () {
            var tableCont = document.querySelector('#table-cont')
                
            function scrollHandle(e) {
                console.log('a')
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }
            tableCont.addEventListener('scroll', scrollHandle)
        }
    </script>
    <div id="modalAgregar" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <label id="lbltiendanuevo">Nuevo grupo</label>
                </div>
                <div class="modal-body contornoVerde2 divAdmin" style="margin-left: 5px; margin-right: 5px;">
                    <div id="divNombre">
                        <span class="ForeColor939393">
                            <img src="img/Recurso3.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                        </span>
                        <input id="txtNombreGrupoTiendas" name="" type="text" class="form-control BordeRadious" placeholder="Nombre" style="font-size: small" />
                        <input id="txtIdGrupoTiendas" name="txtIdGrupoTiendas" type="hidden" />
                        <div id="divMsj"></div>
                    </div>
                    <div id="divSucursalesTiendas" style="display: none">
                        <label id="lbltiendaasignacion">Asignación de sucursales</label>
                         <div id="divSucursalesTiendasNombres" style="height: 150px; min-width: 100%; overflow-y: scroll; margin-top: 10px;"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCloseAdmin">Cerrar</button>
                    <button type="button" class="btn " data-dismiss="" id="btnContinuar">Continuar</button>
                    <button type="button" class="btn " data-dismiss="" id="btnGuardar" style="display: none;">Guardar</button>
                </div>
            </div>

        </div>
    </div>
    <div id="modalAdmin" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <p>
                        <asp:Label runat="server" Text="<%$Resources:multi.language,admin_acciones%>" /></p>
                </div>
                <div class="modal-body contornoVerde2 divAdmin" style="margin-left: 5px; margin-right: 5px;">
                    <div style="height: 80px;" class="texto droidSans">
                        <input type="hidden" id="idUsuarioAdmin" />
                        <div id="divOpciones">
                            <%--<div class="vertical-menu prueba" id="prueba_">--%>
                            <a href="#" class="btnMMenu" name="act_1_">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_activar%>" /></a>
                            <br />
                            <a href="#" style="border-top: 1px solid #939393; border-bottom: 1px solid #939393;" class="btnMMenu" name="del_3_">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_bloquear%>" /></a>
                            <br />
                            <a href="#" class="btnMMenu" name="blo_4_">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_eliminar%>" /></a>

                            <%--</div>--%>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCloseAdmin">
                        <asp:Label runat="server" Text="<%$Resources:multi.language,admin_cerrar%>" /></button>
                </div>
            </div>

        </div>
    </div>

    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <p>
                        <asp:Label runat="server" Text="<%$Resources:multi.language,admin_asignacion%>" /></p>
                </div>
                <div class="modal-body contornoVerde2 divAdmin" style="margin-left: 5px; margin-right: 5px;">
                    <div style="height: 200px; overflow: scroll; overflow-x: hidden" class="texto droidSans ">
                        <input type="hidden" id="idUsuario" />
                        <div id="divSucursales"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCloseSucursales">
                        <asp:Label runat="server" Text="<%$Resources:multi.language,admin_cerrar%>" /></button>
                    <button type="button" class="btn btn-default" id="btnGuardarSucursales">
                        <asp:Label runat="server" Text="<%$Resources:multi.language,admin_guardar%>" /></button>
                </div>
            </div>

        </div>
    </div>
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    </div>
    <div class="" style="padding-left: 10px; padding-top: 15px">
        <div style="padding-top: 15px; padding-bottom: 5px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left"><label id="">Administrador</label></div>
            <div style="clear: both">

            </div>
            </div>
        <div id="divSolicitudes" class="contornoVerde2 divAdmin" style="margin-bottom: 15px; padding: 10px; height: 30%;">
            <div>
                <div class="droidSans grisFuerte" style="font-weight: bold">
                    <asp:Label runat="server" Text="<%$Resources:multi.language,admin_subtitutlo1%>" /></div>
            </div>
            <div class="row" style="margin-bottom: 15px;">
                <%--  <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        <div class="form-group has-feedback date" id="datetimepicker1">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control BordeRadious" id="date1" name="date1" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height:30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True"/>
                        </div>
                        
                    </div>
                </div>
                <script>
                    $(document).ready(function () {
                        var date_input = $('#' + pref + 'date1'); //our date input has the name "date"
                        var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                        var options = {
                            format: 'dd/mm/yyyy',
                            container: container,
                            todayHighlight: true,
                            autoclose: true,
                            language: 'es',
                        };
                        date_input.datepicker(options);
                    })
                </script>
                <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        <div class="form-group has-feedback date" id="datetimepicker2">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control BordeRadious" id="date2" name="date2" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height:30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True"/>
                        </div>                        
                    </div>
                </div>
                <script>
                    $(document).ready(function () {
                        var date_input = $('#' + pref + 'date2'); //our date input has the name "date"
                        var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                        var options = {
                            format: 'dd/mm/yyyy',
                            container: container,
                            todayHighlight: true,
                            autoclose: true,
                            language: 'es'
                        };
                        date_input.datepicker(options);
                    })
                </script>--%>
                <div class="col-sm-3">

                    <div class="form-group has-feedback" style="border-radius: 5px">
                        <span class="ForeColor939393">
                            <img src="img/lupa.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                        </span>
                        <input runat="server" id="txtNombreSolicitudes" name="" type="text" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,admin_filltro1%>" style="font-size: small" /><%--<%$Resources:multi.language,nombre%>--%>
                    </div>
                </div>
                <div class="col-sm-3">
                    <input type="button" id="btnSolicitudes" value="Buscar" class="btn " style="float: left" />

                </div>
            </div>
            <div style="width: 100%; overflow-x: scroll; height: 250px;">
                <table id="tablaSolicitudes" class="table tablaAdmin" style="font-weight: normal!important">
                    <thead>
                        <tr>
                            <th scope="col" width="25%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1nombre%>"></asp:Label>
                            </th>
                            <th scope="col" width="10%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1rol%>" /></th>
                            <th scope="col" width="25%" >
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1correo%>" /></th>
                            <th scope="col" width="20%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1fecha%>" /></th>
                            <th scope="col" width="10%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_tiinactividad%>" /></th>
                            <th scope="col" width="10%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1activacion%>" /></th>
                        </tr>
                    </thead>
                </table>
            </div>
            <div style="text-align: right" id="divUsuariosPendientes">0 Registros</div>
        </div>
        <div id="divRegistrados" class="contornoVerde2 divAdmin" style="margin-top: 15px; padding: 10px; height: 30%">
            <div>
                <div class="droidSans grisFuerte" style="font-weight: bold">
                    <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t2subtitulo2%>" /></div>
            </div>
            <div class="row" style="margin-bottom: 15px;">
                <%-- <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        <div class="form-group has-feedback date" id="datetimepicker3">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control BordeRadious" id="date3" name="date3" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height:30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True"/>
                        </div>
                        
                    </div>
                </div>
                <script>
                    $(document).ready(function () {
                        var date_input = $('#' + pref + 'date3'); //our date input has the name "date"
                        var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                        var options = {
                            format: 'dd/mm/yyyy',
                            container: container,
                            todayHighlight: true,
                            autoclose: true,
                            language: 'es'
                        };
                        date_input.datepicker(options);
                    })
                </script>
                <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        <div class="form-group has-feedback date" id="datetimepicker4">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control BordeRadious" id="date4" name="date4" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height:30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True"/>
                        </div>
                        
                    </div>
                </div>
                <script>
                    $(document).ready(function () {
                        var date_input = $('#' + pref + 'date4'); //our date input has the name "date"
                        var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                        var options = {
                            format: 'dd/mm/yyyy',
                            container: container,
                            todayHighlight: true,
                            autoclose: true,
                            language: 'es'
                        };
                        date_input.datepicker(options);
                    })
                </script>--%>
                <div class="col-sm-3">
                    <div class="form-group has-feedback" style="border-radius: 5px">
                        <span class="ForeColor939393">
                            <img src="img/lupa.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                        </span>
                        <input runat="server" id="txtNombreRegistrado" name="" type="text" class="form-control BordeRadious" placeholder="<%$Resources:multi.language,admin_filltro1%>" style="font-size: small" />
                    </div>
                </div>

                <div class="col-sm-3">

                    <input type="button" id="btnRegistrados" value="Buscar" class="btn " />

                </div>
            </div>
            <div style="width: 100%; overflow-x: scroll; height: 250px;">
                <table id="tablaRegistrados" class="table tablaAdmin">
                    <thead>
                        <tr>

                            <th scope="col" width="20%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1nombre%>" /></th>
                            <th scope="col" width="10%" class="tdOcultar">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1rol%>" /></th>
                            <th scope="col" width="20%" class="tdOcultar">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1correo%>" /></th>
                            <th scope="col" width="10%" class="tdOcultar">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t1fecha%>" /></th>
                            <th scope="col" width="10%">
                                <asp:Label runat="server" Text="Acceso" /></th>
                            <th scope="col" width="10%" class="tdOcultar">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t2estado%>" /></th>
                            <th scope="col" width="10%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,admin_t2accion%>" /></th>
                            <th scope="col" width="10%">
                                <asp:Label runat="server" Text="<%$Resources:multi.language,adin_t2sucursales%>" /></th>
                        </tr>
                    </thead>
                </table>
                <%--<div id="divContenidoRegistrados" class="divContenidosTablas">

                </div>--%>
            </div>
            <div style="text-align: right" id="divUsuariosActivos">0 Registros </div>
        </div>
        <div style="height: 50px"></div>
    </div>
    
    <div class="" style="padding-left: 10px;padding-top:15px">
        <div style="padding-top: 15px; padding-bottom: 5px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left"><label id="lblTitulotienda">Grupo de Tiendas</label></div>
            <div style="clear: both"></div>
        </div>
                <div style="display: none">
               <asp:HyperLink ID="HyperLink1" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
               <asp:HyperLink ID="HyperLink2" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
           </div>
        <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div id="divSolicitudesTiendas" class="contornoVerde2 divAdmin" style="margin-bottom: 15px; padding: 30px;">
                    <div class="row">
                        <div class="col">
                            <input type="button" id="btnGrupoTiendas" value="Consultar" class="btn " style="" />

                        </div>
                        <div class="col">
                            <input type="button" id="btnAgregar" value="Agregar" class="btn " style="" />

                        </div>
                        <div class="col">
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div style="width: 100%;  height: 200px;margin-top:10px">
                        <div class='table-cont' id='table-cont'>
                            <table id="tablaGrupos" class="table tablaAdmin" style="font-weight: normal!important">
                                <thead>
                                    <tr>
                                        <th scope="col" width="50%"><label id="lbltiendanombre">Nombre</label></th>
                                        <th scope="col" width="10%"><label id="lbltiendadetalle">Detalle</label></th>
                                        <th scope="col" width="10%"><label id="lbltiendaeditar">Editar</label></th>
                                        <th scope="col" width="10%"><label id="lbltiendaeliminar">Eliminar</label></th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div id="" class="contornoVerde2 divAdmin" style="margin-bottom: 15px; padding: 33px;">
                    <div class="row">
                        <div class="col">
                            <input type="button" id="" value="Consultar" class="btn " style="display:none" />

                        </div>
                        <div class="col">
                            <input type="button" id="" value="Agregar" class="btn " style="display:none" />

                        </div>
                        <div class="col">
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <label id="lbltiendasucursles">Sucursales</label>
                    <div style="width: 100%; overflow-x: scroll; height: 200px;margin-top:10px" id="divSucursalesTiendasGrupo">
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
