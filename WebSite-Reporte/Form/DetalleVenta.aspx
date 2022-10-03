<%@ Page Title="" Language="C#" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="DetalleVenta.aspx.cs" Inherits="Form_DetalleVenta" %>


<asp:Content ID="Content8" ContentPlaceHolderID="Content8" Runat="Server">
    <style>
        .btn {
            background-color: #fff !important;
            border: 1px solid #6db23f;
            color: #939393 !important;
        }
    </style>
    
    <script src="js/funciones.js"></script>
    <script>
        var pref = "Content8_"
        $(document).ready(function () {
            var fecha = '<%=Session["fecha"]%>'
            var sucursal = '<%=Session["sucursal"]%>'
            //alert(sucursal)
            /**llenar info/ */
            $('#' + pref + "DropDownList12 option[value='"+ sucursal +"']").attr("selected",true);
            /**llenar info/ */
            /*var date_input = $('#' + pref + 'date1'); //our date input has the name "date"
            var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
            var options = {
                format: 'dd/mm/yyyy',
                container: container,
                todayHighlight: true,
                autoclose: true,
                language: 'es',
            };
            date_input.datepicker(options);
            var date_input2 = $('#' + pref + 'date2'); //our date input has the name "date"
            var options2 = {
                format: 'dd/mm/yyyy',
                container: container,
                todayHighlight: true,
                autoclose: true,
                language: 'es'
            };
            date_input2.datepicker(options2);

            $('#' + pref + 'date1').val(fecha)
            $('#' + pref + 'date2').val(fecha)*/
            $('#date1').val(fecha)
            llenadoInfo()
            $("#btn1").click(function () {
                llenadoInfo()
            });

            function llenadoInfo() {
                //var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'tienda': $('#' + pref + 'DropDownList12').val() };
                var datos = { 'f1': $('#date1').val(), 'tienda': $('#' + pref + 'DropDownList12').val() };
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaDashboard_',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        console.log(data.d)
                        $("#txtVentas").html(data.d.Tendencia)
                        $("#txtVentas2").html(data.d.Ventas)
                        $("#txtPresupuesto").html(data.d.Presupuesto)
                        $("#txtTickets").html(data.d.Tickets)
                        $("#txtTicketsProm").html(data.d.TicketsPromedio)
                        $("#txtDescuentos").html(data.d.Descuentos)
                        $("#txtCancelaciones").html(data.d.Cancelaciones)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
            $('input[name="date1"]').daterangepicker({
                    locale: {
                            format: 'DD/MM/YYYY',
                        "daysOfWeek": [
                            "Do",
                            "Lu",
                            "Ma",
                            "Mi",
                            "Ju",
                            "Vi",
                            "Sa"                    
                        ],
                        "monthNames": [
                            "Enero",
                            "Febrero",
                            "Marzo",
                            "Abril",
                            "Mayo",
                            "Junio",
                            "Julio",
                            "Agosto",
                            "Septiembre",
                            "Octubre",
                            "Noviembre",
                            "Diciembre"
                        ]
                    }
            });
        })
         $(document).on('click', '.detalleTickets', function (event) {
             var id = $(this).attr('id')
            var alt = $(this).attr('alt')
            //window.location.assign("Tickets.aspx?fecha1="+ $('#' + pref + 'date1').val()+"&fecha2="+$('#' + pref + 'date2').val()+'&sucursal='+$('#' + pref + 'DropDownList12').val()+'&consulta='+id );
            window.location.assign("Tickets.aspx?fecha1="+ $('#date1').val()+'&sucursal='+$('#' + pref + 'DropDownList12').val()+'&consulta='+id );
         })
         $(document).on('click', '.dashboard', function (event) {
            window.location.assign("Dashboard.aspx?fecha1="+ $('#date1').val()+'&sucursal='+$('#' + pref + 'DropDownList12').val() );
        })
    </script>
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    </div>
    <div class=" divDashboard thisOne" style="padding-top: 15px">
         <div style="padding-top: 10px; padding-bottom: 5px">
            <div class="grisFuerte ffGalaxie titulo" style=" padding-top: 10px"><a id="regresarVentas" href="Ventas.aspx"><img src="img/regresar.png" width="40"/></a> Detalle de ventas</div>
            <%--<div class="counter">0</div>--%>
        <A name="home" id="home"></A>

        </div>
        
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-sm-3">
                 <div class="SeleccionarFecha">
                    <div class="form-group has-feedback date" id="datetimepicker2">
                        <span class="ForeColor939393">
                            <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                        </span>
                        <input type="text" class="form-control BordeRadious" id="date1" name="date1" value="" placeholder="DD/MM/YYYY" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" />
                    </div>
                </div>
                <%--<div class="SeleccionarFecha">
                    <div class="form-group has-feedback date" id="datetimepicker1">
                        <span class="ForeColor939393">
                            <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                        </span>
                        <input runat="server" class="form-control BordeRadious" id="date1" name="date1" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="SeleccionarFecha">
                    <div class="form-group has-feedback date" id="datetimepicker2">
                        <span class="ForeColor939393">
                            <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                        </span>
                        /<input runat="server" class="form-control BordeRadious" id="date2" name="date2" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
                    </div>

                </div>--%>
            </div>
            <div class="col-sm-3" style="display:none">
                <div class="SeleccionarFecha">
                    <div class="form-group has-feedback BordeRadious" style="">
                        <span class="ForeColor939393">
                            <img src="img/Home.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                        </span>
                       
                        <asp:DropDownList CssClass="form-control BordeRadious" ID="DropDownList12" DataSourceID="SqlDataSource1" runat="server" DataTextField="nombre" DataValueField="nombre" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px" >
                            <asp:ListItem Text="<%$Resources:multi.language,dash_todas%>"></asp:ListItem>
                        </asp:DropDownList>
                            
                        <asp:SqlDataSource  ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select T1.nombre from mlocal T1  join relacionGrupoSucursal T2 ON T1.id_local = T2.idlocal  join relacionSucursalUsuario t3 on t2.idgrupo = t3.id_local WHERE T3.id_usuario = @IdUsuario"></asp:SqlDataSource>
                        <asp:SqlDataSource  ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select nombre from mlocal where id_local >= 750"></asp:SqlDataSource>
                        
                        </div>
                </div>
            </div>
            <div class="col-sm-3">
                <input type="button" class="btn" value="Consultar" id="btn1" />
            </div>
        </div>
        <div class="row" id="">            
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div class="row" id="">
                    <div class="col-6" style="">
                        <a href="#" class="detalleTickets" id="21"><div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" Text="Venta neta"/></div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="">
                                    <div class="valor" style="" id="txtVentas">-  </div>
                                    <div class="clean"></div>
                                </div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_ventas.png" />
                                </div>
                            </div>
                        </div></a>
                    </div>
                    <div class="col-6">
                        <div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" Text="Presupuesto"/></div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left;" id="txtPresupuesto">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_presupuesto.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div class="row" id="">
                    <div class="col-6" style="">
                        <a href="#" class="detalleTickets" id="18">
                        <div class="divInfo">
                            <div class="titulo2">Tickets</div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left;" id="txtTickets">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_tickets.png" />
                                </div>
                            </div>
                        </div>
                            </a>
                    </div>
                    <div class="col-6">
                        <div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" Text="Ticket promedio"/></div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="txtTicketsProm">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/icono_descuento.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
            
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div class="row" id="">
                    <div class="col-6" style="">
                        <a href="#" class="detalleTickets" id="20">
                        <div class="divInfo">
                            <div class="titulo2">Descuentos</div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="">
                                    <div class="valor" style="" id="txtDescuentos">-  </div>
                                </div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/descuentos_2.png" />
                                </div>
                            </div>
                        </div>
                            </a>
                    </div>
                    
                    <div class="col-6">
                        <a href="#" class="detalleTickets" id="19">
                        <div class="divInfo">
                            <div class="titulo2"><asp:Label runat="server" />Cancelaciones</div>
                            <div style="padding-left: 10px; padding-right: 10px">
                                <div class="valor" style="float: left" id="txtCancelaciones">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/cancelaciones_2.png" />
                                </div>
                            </div>
                        </div>
                            </a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                <div class="row" id="">
                    <div class="col-6" style="">
                        <div  class="dashboard">
                        <div class="divInfo">
                            <div class="titulo2">Detalles</div>
                            <div style="padding-left: 10px; padding-right: 10px">                          
                                <div class="valor" style="float: left;color:#fff!important" id="">-</div>
                                <div class="imagen" style="float: right">
                                    <img class="img-fluid" style="" src="img/detalles-113px.png" />
                                </div>
                            </div>
                        </div>
                            </div>
                    </div>
                   
                </div>
            </div>
        </div>

    </div>
</asp:Content>

