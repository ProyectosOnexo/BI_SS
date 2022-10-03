<%@ Page Title="" Language="C#" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="GrupoTiendas.aspx.cs" Inherits="Form_GrupoTiendas" %>

<asp:Content ID="Content5" ContentPlaceHolderID="Content4" runat="Server">
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

   
    <div class="" style="padding-left: 10px;padding-top:15px">
        <div style="padding-top: 25px; padding-bottom: 25px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left"><label id="lblTitulotienda">Grupo de Tiendas</label></div>
            <a href="Dashboard.aspx">
                <img src="img/Logo.png" class="img-fluid imgLgo" alt="Responsive image" style="height: 43px; float: right" /></a>
            <div style="clear: both"></div>
        </div>
                <div style="display: none">
               <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
               <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
           </div>
        <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div id="divSolicitudes" class="contornoVerde2 divAdmin" style="margin-bottom: 15px; padding: 30px;">
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

