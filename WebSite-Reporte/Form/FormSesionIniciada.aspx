<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportesInicio.aspx.cs" MasterPageFile="~/Form/MasterPage.master" Inherits="Form_ForReportesInicio" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content2" runat="Server">

    <script>
        var num = 35
        var pref ="Content1_"
        $(document).ready(function () {
            $('.thisOne').sortable({
                revert: true
            });

            var chart = Morris.Donut({
                element: 'dona',
                data: [
                    { value: 15, label: 'Venta' },
                    { value: 50, label: 'Presupuesto' }
                ],
                backgroundColor: '#ccc',
                labelColor: '#606060',
                colors: [
                    '#6db23f',
                    '#939393'
                ],
                formatter: function (x) { return x },
                resize: true,
                redraw: true
            });

            var area = Morris.Area({
                element: 'area',
                behaveLikeLine: true,
                parseTime: false,
                data: [{ y: '2006', a: 50, b: 90 },
                { y: '2007', a: 75, b: 65 },
                { y: '2008', a: 50, b: 40 },
                { y: '2009', a: 75, b: 65 },
                { y: '2010', a: 30, b: 40 },
                { y: '2011', a: 75, b: 65 },
                { y: '2012', a: 50, b: 90 }],
                xkey: 'y',
                ykeys: ['a', 'b'],
                labels: ['Venta', 'Presupuesto'],
                pointFillColors: ['#606060'],
                pointStrokeColors: ['#606060'],
                lineColors: ['#939393', '#6db23f'],
                resize: true,
                redraw: true
            });

            var n = new Date(); y = n.getFullYear(); m = n.getMonth() + 1; d = n.getDate();
            $('#'+pref+'date1').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
            $('#'+pref+'date2').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y)

            $("#btn1").click(function () {

                var datos = { 'f1': $('#'+pref+'date1').val(), 'f2': $('#'+pref+'date2').val(), 'tienda': 0 };
                console.log(datos)
                $.ajax({
                    url: 'AdministrarCuentas.aspx/ConsultaDashboard',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        console.log(data.d)
                        var html = ''
                        $.each(data.d.ListTabla, function (index, value) {
                            html += '<table class="table">'
                            html += '<tr >'
                            html += '<td width="25%">' + value.Sucursal
                            html += '</td>'
                            html += '<td width="10%">' + value.VentaBruta
                            html += '</td>'
                            html += '<td width="25%">' + value.VentaNeta
                            html += '</td>'
                            html += '<td width="20%">' + value.Tickets
                            html += '</td>'
                            html += '</tr>'
                            html += '</table>'
                        })
                        $("#divDashContenido").html(html)
                        chart.setData([
                            { label: "Venta", value: data.d.Dona.Venta },
                            { label: "Presupuesto", value: data.d.Dona.Presupuesto },
                        ]);
                        $("#txtVentas").html(data.d.Ventas)
                        $("#txtPresupuesto").html(data.d.Presupuesto)
                        $("#txtTickets").html(data.d.Tickets)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        });

    </script>
    <style>
        .form-control {
            height: 32px !important;
        }
    </style>
    
    <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
    <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    <div class=" divDashboard thisOne">
        <div style="padding-top: 25px; padding-bottom: 25px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left">Dashboard</div>
            <a href="index.aspx">
                <img src="img/Logo.png" class="img-fluid" alt="Responsive image" style="display: block; height: 43px; float: right" /></a>
            <div style="clear: both"></div>
        </div>
        <div style="margin-bottom: 15px;">
            <input type="button" value="cambio" id="btn1" />
            <div class='input-group date' id='datetimepicker1' style="width: 150px; float: left; margin-right: 5px;">
                <span class="input-group-text input-group-text2">
                    <img src="img/calendario.png" style="width: 15px" /></span>
                <input runat="server" class="form-control contornoVerde" id="date1" name="date1" placeholder="DD/MM/YYYY" type="text" style="height: 30px; font-size: 13px" autocomplete="off" />

            </div>
            <script>
                $(document).ready(function () {
                    var date_input = $('#'+pref+'date1'); //our date input has the name "date"
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
            <div class='input-group date' id='datetimepicker2' style="width: 150px; float: left; margin-right: 5px;">
                <span class="input-group-text input-group-text2">
                    <img src="img/calendario.png" style="width: 15px" /></span>
                <input runat="server" class="form-control contornoVerde" id="date2" name="date2" placeholder="DD/MM/YYYY" type="text" style="height: 30px; font-size: 13px" autocomplete="off" />

            </div>
            <script>
                $(document).ready(function () {
                    var date_input = $('#'+pref+'date2'); //our date input has the name "date"
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
            <div class="input-group form-group" style="width: 150px; float: left; margin-right: 5px;">
                <div class="input-group-prepend">
                    <span class="input-group-text">
                        <img src="img/lupa.png" style="width: 15px" /></span>
                </div>
                <input style="padding: 2px!important" runat="server" id="txtNombreSolicitudes" name="" type="text" class="form-control contornoVerde" placeholder="nombre" />
            </div>
        </div>
        <div class="clean"></div>
        <div class="row" id="thisOne">
            <div class="col" style="">
                <div class="divInfo">
                    <div class="titulo2">Venta</div>
                    <div style="padding-left: 10px; padding-right: 10px">
                        <div class="valor" style="float: left" id="txtVentas">150</div>
                        <div class="imagen" style="float: right">
                            <img class="img-fluid" style="" src="img/barraVerde.png" />
                        </div>
                        <div class="clean"></div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="divInfo">
                    <div class="titulo2">Presupuesto</div>
                    <div style="padding-left: 10px; padding-right: 10px">
                        <div class="valor" style="float: left" id="txtPresupuesto">180</div>
                        <div class="imagen" style="float: right">
                            <img class="img-fluid" style="" src="img/barraGris.png" />
                        </div>
                        <div class="clean"></div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="divInfo">
                    <div class="titulo2">Tendencia</div>
                    <div style="padding-left: 10px; padding-right: 10px">
                        <div class="valor" style="float: left" id="txtTendencia">180</div>
                        <img class="img-fluid" style="" src="img/fondo.png" />
                        <div class="clean"></div>
                    </div>
                </div>
            </div>
            <div class="col" style="">
                <div class="divInfo">
                    <div class="titulo2">Tickets</div>
                    <div style="padding-left: 10px; padding-right: 10px">
                        <div class="valor" style="float: left" id="txtTickets">180</div>
                        <img class="img-fluid" style="" src="img/fondo.png" />
                        <div class="clean"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clean"></div>
        <div class="divGrafica1">
            <div class="titulo">Barra de status</div>
            <div id="area"></div>
            <div>
                <div class="cuadroVerde" style="float: left; margin-right: 10px; margin-left: 10px"></div>
                <div class="droidSans grisClaro texto" style="float: left; margin-right: 10px">Ventas</div>
                <div class="cuadroGris" style="float: left; margin-right: 10px"></div>
                <div class="droidSans grisClaro texto" style="float: left">Presupuesto</div>
            </div>
        </div>
        <div class="clean"></div>
        <%--<div class="">--%>
            <div class="row" style="margin-right:0!important">
                <div class="col" >
                    <div class="divReportes">
                        <div class="titulo"><asp:Label runat="server" Text="<%$Resources:multi.language,reportes%>"></asp:Label></div>
                        <div style="padding: 10px">
                            <table id="" class="table tablaAdmin" style="font-weight: normal!important">
                                <thead>
                                    <tr>
                                        <th scope="col" width="25%">Sucursal</th>
                                        <th scope="col" width="25%">Venta bruta</th>
                                        <th scope="col" width="25%">Venta neta</th>
                                        <th scope="col" width="25%">Tickets</th>
                                    </tr>
                                </thead>
                            </table>
                            <div id="divDashContenido" class="divContenidosTablas">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col col-lg-3">
                    <div class="divPresupuesto">
                        <div class="titulo">Presupuesto</div>
                        <div style="margin: 0 15px 0 15px">
                            <div style="float: left" class="grisClaro texto droidSans">Total</div>
                            <div class="verde texto droidSans" style="float: right" id="txtTotal">0</div>
                            <div class="clean"></div>
                            <hr />
                        </div>
                        <div id="graficaPres">
                            <div id="dona" style="margin-top: -30px;"></div>
                            <div style="margin-left: 15px; margin-right: 15px; margin-top: -30px;">
                                <div class="cuadroVerde" style="float: left; margin-right: 10px; margin-left: 10px"></div>
                                <div class="droidSans grisClaro texto" style="float: left; margin-right: 10px">Ventas</div>
                                <div class="cuadroGris" style="float: left; margin-right: 10px"></div>
                                <div class="droidSans grisClaro texto" style="float: left">Presupuesto</div>
                                <div class="clean"></div>
                                <hr />
                            </div>
                        </div>
                    </div>
                </div>
                <div class=" col col-lg-3" style="padding-right: 0">
                    <div class="divCumpleaños">
                    </div>
                </div>
                <div>
                </div>
            </div>
        <%--</div>--%>
    </div>
</asp:Content>
