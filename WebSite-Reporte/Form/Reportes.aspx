<%@ Page Title="" Language="C#" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="Reportes.aspx.cs" Inherits="Form_Reportes" %>

<asp:Content ID="Content7" ContentPlaceHolderID="Content6" runat="Server">
    <link href="css/StyleReporteDiario.css" rel="stylesheet" />
    <script src="https://unpkg.com/jspdf@latest/dist/jspdf.min.js"></script>
    <script src="../Scripts/linq.js"></script>
    <script src="js/excel/jquery.table2excel.js"></script>
    <link rel="stylesheet" href="js/colapse/bootstrap-treefy.min.css">
    <script src="js/colapse/bootstrap-treefy.js"></script>

    <script src="js/funciones.js"></script>
    <style>
        .centrar {
            position: absolute;
            /*nos posicionamos en el centro del navegador*/
            top: 50%;
            left: 50%;
            /*determinamos una anchura*/
            width: 400px;
            /*indicamos que el margen izquierdo, es la mitad de la anchura*/
            margin-left: -200px;
            /*determinamos una altura*/
            height: 300px;
            /*indicamos que el margen superior, es la mitad de la altura*/
            margin-top: -150px;
            padding: 5px;
            z-index: 101;
            background: transparent;
        }

        .form-control {
            height: 32px !important;
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
                background-color: #ededed !important;
                color: #fff;
            }

            .vertical-menu a.active {
                background-color: #ededed;
                color: white;
            }

        .table-cont {
            max-height: 400px;
            overflow: auto;
            /*margin: 20px 10px;*/
        }

        .table-cont2 {
            max-height: 150px;
            overflow: auto;
            /*margin: 20px 10px;*/
        }

        #tablaRporteProductos tr:hover {
            background-color: #ededed;
        }

        .tablaAdmin tr:hover {
            background-color: #ededed;
        }

        #tablaRporteProductos {
            color: #000 !important;
            background-color: #fff !important;
        }

            #tablaRporteProductos .table {
                background-color: #000 !important;
            }

        #tablaRporteProductosEmpleados tr:hover {
            background-color: #ededed;
        }

        #tablaRporteProductosEmpleados {
            color: #000 !important;
            background-color: #fff !important;
        }

            #tablaRporteProductosEmpleados .table {
                background-color: #fff !important;
            }

        #tablaRporteProductosEmpleadosSumatorias tr:hover {
            background-color: #ededed;
        }

        #tablaRporteProductosEmpleadosSumatorias {
            color: #000 !important;
            background-color: #fff !important;
        }

            #tablaRporteProductosEmpleadosSumatorias .table {
                background-color: #000 !important;
            }

        .hiddenRow {
            padding: 0px !important;
            border: 0px !important
        }

        .borde {
            padding: 10px !important;
            border-top: 1px solid #dee2e6
        }
    </style>
    <script>   

        var colores = ['#6db23f', '#92c164', '#b1d18d', '#cde1b6', '#6db23f', '#92c164', '#b1d18d', '#cde1b6']



        var myBarDesHorizontalMP3
        $(document).ready(function () {



        })
        $("body").on("click", "#btnExportpdf", function () {
            if ($('#' + pref + 'lista').val() == 2) {
                exportPDF()
            }
        })
        $("body").on("click", "#btnExcel", function () {
            if ($('#idReporte').val() == 1) {
                $("#tablaRporteProductos").table2excel({
                    // exclude CSS class
                    //exclude: ".noExl",
                    name: "Worksheet Name",
                    filename: "Productos", //do not include extension
                    fileext: ".xls", // file extension
                    preserveColors: true
                });
            }
            if ($('#idReporte').val() == 2) {
                $("#frame").attr("src", "MasterDetail.aspx?fecha=" + $('#' + pref + 'date1').val() + "&fecha2=" + $('#' + pref + 'date2').val() + '&nombre=' + $('#' + pref + 'DropDownList12').val() + '&Reporte=2');
            }
            if ($('#idReporte').val() == 3) {
                //window.open("exelejemplo.aspx", '_blank');
                $("#frame").attr("src", "MasterDetail.aspx?fecha=" + $('#' + pref + 'date1').val() + "&fecha2=" + $('#' + pref + 'date2').val() + '&nombre=' + $('#' + pref + 'DropDownList12').val() + '&Reporte=3');
            }
        })
        var specialElementHandlers = {
            // element with id of "bypass" - jQuery style selector
            '.no-export': function (element, renderer) {
                // true = "handled elsewhere, bypass text extraction"
                return true;
            }
        };
        function exportPDF() {
            var doc = new jsPDF('p', 'pt', 'a4');
            //Html source 
            var source = document.getElementById('table-cont2').innerHTML;

            var margins = {
                top: 10,
                bottom: 10,
                left: 10,
                width: 595
            };

            doc.fromHTML(
                source, // HTML string or DOM elem ref.
                margins.left,
                margins.top, {
                'width': margins.width,
                'elementHandlers': specialElementHandlers
            },
                function (dispose) {
                    doc.save('ProductosEmpleados.pdf');
                }, margins);
        }
        window.onload = function () {
            var tableCont = document.querySelector('#table-cont')
            function scrollHandle(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }
            tableCont.addEventListener('scroll', scrollHandle)

            var tableCont2 = document.querySelector('#table-cont2')
            function scrollHandle2(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }
            tableCont2.addEventListener('scroll', scrollHandle2)

            var tableCont3 = document.querySelector('#table-cont3')
            function scrollHandle3(e) {
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }
            tableCont3.addEventListener('scroll', scrollHandle3)
        }
        var pref = "Content6_"
        $(document).ready(function () {
            $('#divTituloReporte').html('')
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
            $('#' + pref + 'date1').val(d + "/" + (m >= 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date2').val(d + "/" + (m >= 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date3').val(d + "/" + (m >= 10 ? m : '0' + m) + "/" + y)
            $('#' + pref + 'date4').val(d + "/" + (m >= 10 ? m : '0' + m) + "/" + y)
            /*
            $("#btnSolicitudes").click(function () {
                //$("#carga").show();     
               var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'nombre': $('#' + pref + 'DropDownList12').val(), 'opcion': $('#' + pref + 'lista').val() };
                if ($('#' + pref + 'lista').val() == 1) {
                   
                     $("#tablaRporteProductosEmpleados ").empty()
                     $("#table-cont2").hide()
                     $("#table-cont3").hide()
                     $("#table-cont4").hide()
                     $("#table-cont ").show()
                    $.ajax({
                        url: 'Reportes.aspx/Consulta',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            var html = ''
                            if (data.d.length > 0) {
                                html += '<thead>'
                                for (var i = 0; i < 1; i++) {
                                    var x = data.d[i].split('_');
                                    html += '<tr >'
                                    for (var y = 0; y < x.length-1; y++) {
                                        html += '<th id="facility_header">' + x[y]
                                        html += '</th>'
                                    }
                                    html += '</tr>'
                                }
                                html += '</thead>'
                            }
                            $("#tablaRporteProductos thead").empty()
                            $("#tablaRporteProductos ").append(html)
                            html = ""
                            if (data.d.length > 0) {
                                html += '<tbody>'
                                for (var i = 1; i < data.d.length; i++) {
                                    var x = data.d[i].split('_');
                                    html += '<tr >'
                                    for (var y = 0; y < x.length-1; y++) {
                                        html += '<td>' + x[y]
                                        html += '</td>'
                                    }
                                    html += '</tr>'
                                }
                                html += '</tbody>'
                            }
                            $("#tablaRporteProductos tbody").empty()
                            $("#tablaRporteProductos ").append(html)
                            $("#carga").hide();       
                        },
                        error: function (err) {
                            $("#carga").hide();  
                        }
                    });
                }
                if ($('#' + pref + 'lista').val() == 2) {
                    $("#tablaRporteProductos ").empty()
                    $("#table-cont").hide()
                    $("#table-cont4").hide()
                    $("#table-cont2").show()
                    $("#table-cont3").show()
                    var sumatorias = [];
                    var producto_x = ""
                    var porciones_x = 0
                    var precio_x = 0

                    $.ajax({
                        url: 'Reportes.aspx/ReporteCVerde',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            var html = ''
                            html = ""
                            var html2 = ''
                            html2 = ""
                            if (data.d.length > 0) {
                                 html += '<thead>'
                                    html += '<tr >'
                                    html += '<th width="25%">Nombre' 
                                    html += '</th>'
                                    html += '<th width="25%">Producto' 
                                    html += '</th>'
                                    html += '<th width="20%">Precio' 
                                    html += '</th>'
                                    html += '<th width="10%">Porciones'
                                    html += '</th>'
                                    html += '<th width="10%">Folio'
                                    html += '</th>'
                                    html += '<th width="10%">Fecha'
                                    html += '</th>'
                                    html += '</tr>'
                                html += '</thead>'

                               html += '<tbody>'
                                $.each(data.d, function (index, value) {
                                    html += '<tr >'
                                    html += '<td >' + value.Nombre
                                    html += '</td>'
                                    html += '<td >' + value.Producto
                                    html += '</td>'
                                    html += '<td >' + value.Precio
                                    html += '</td>'
                                    html += '<td>' + value.Porcion
                                    html += '</td>'
                                    html += '<td >' + value.Folio
                                    html += '</td>'
                                    html += '<td >' + value.Hora
                                    html += '</td>'
                                    html += '</tr>'
                                    //if (idioma == 'en') {
                                    //    $("#divUsuariosPendientes ").html(data.d.length + ' Redords')
                                    //}
                                    //else
                                    //    $("#divUsuariosPendientes ").html(data.d.length + ' Registros')
                                })
                                html += '</tbody>'

                                html2 += '<thead>'
                                    html2 += '<tr >'
                                    html2 += '<th width="25%">Producto' 
                                    html2 += '</th>'
                                    html2 += '<th width="20%">Precio' 
                                    html2 += '</th>'
                                    html2 += '<th width="10%">Porciones'
                                    html2 += '</th>'
                                    html2 += '<th width="10%">Total'
                                    html2 += '</th>'
                                    html2 += '</tr>'
                                html2 += '</thead>'
                            }

                            var queryResult = Enumerable.From(data.d)
                                .Distinct(function (x) { return x.Producto })
                                .OrderBy(function (x) { return x.Producto })
                                .ToArray();
                            $.each(queryResult, function (index, value) {
                                producto_x = value.Producto
                                    html2 += '<tr >'
                                    html2 += '<td >' + value.Producto
                                    html2 += '</td>'
                                    html2 += '<td >' + value.Precio 
                                            
                                    html2 += '</td>'
                                    html2 += '<td>' + Enumerable.From(data.d)
                                        .Where(function (x) {return x.Producto == producto_x })
                                        .Sum(function (x) { return x.Porcion })
                                    html2 += '</td>'
                                    html2 += '<td >' + (value.Precio  *Enumerable.From(data.d)
                                        .Where(function (x) {return x.Producto == producto_x })
                                        .Sum(function (x) { return x.Porcion }))
                                    html2 += '</td>'
                                    html2 += '</tr>'
                            })

                            console.log(queryResult)
                            $("#tablaRporteProductosEmpleados ").empty()
                            $("#tablaRporteProductosEmpleados ").append(html)
                            $("#tablaRporteProductosEmpleadosSumatorias ").empty()
                            $("#tablaRporteProductosEmpleadosSumatorias ").append(html2)
                            var column1 = $('#tablaRporteProductosEmpleados td:first-child');                            
                            modifyTableRowspan(column1);
                        },
                        error: function (xhr, status, error) {
                            alert(error)
                            console.log(xhr.responseText);
                        }
                    }); 
                }

                if ($('#' + pref + 'lista').val() == 3) {
                            var html = ''
                    $("#tablaRporteProductosCateforias ").empty()
                    $("#table-cont").hide()
                    $("#table-cont2").hide()
                    $("#table-cont3").hide()
                    $("#table-cont4").show()
                    var sumatorias = [];
                    var producto_x = ""
                    var porciones_x = 0
                    var precio_x = 0
                    var cont = 0
                    var contpadre = 0
                    $.ajax({
                        url: 'Reportes.aspx/ReportePCategorias',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(datos),
                        dataType: "json",
                        method: 'post',
                        success: function (data) {
                            html = ""
                            var html2 = ''
                            html2 = ""
                            if (data.d.length > 0) {
                                 html += '<thead>'
                                    html += '<tr >'
                                    html += '<th width="25%">Categoría' 
                                    html += '</th>'
                                    html += '<th width="25%">Producto' 
                                    html += '</th>'
                                    html += '<th width="15%">Porciones'
                                    html += '</th>'
                                    html += '<th width="15%">Participación'
                                    html += '</th>'
                                html += '</thead>'

                               html += '<tbody>'
                                $.each(data.d, function (index, value) {
                                    
                                    if (value.Orden.includes('_a')) {
                                        contpadre++
                                        cont = contpadre
                                        html += '<tr data-toggle="collapse" data-target=".demo' + contpadre + '" id="colap_' + contpadre + '" class="collap">'
                                            html += '<td >' + value.Nombre
                                            html += '</td>'
                                            html += '<td >' + value.Producto
                                            html += '</td>'
                                            html += '<td >' + value.Porcion
                                            html += '</td>'
                                            html += '<td >' + value.Participacion
                                            html += '</td>'
                                        html += '</tr>'
                                    }
                                    else {
                                        html += '<tr class="">'
                                            html += '<td class="hiddenRow">'
                                                html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '"></div>'
                                            html += '</td>'
                                            html += '<td class="hiddenRow">'
                                                html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '">' + value.Producto + '</div>'
                                            html += '</td>'
                                            html += '<td class="hiddenRow">'
                                                html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '">' + value.Porcion + '</div>'
                                            html += '</td>'
                                            html += '<td class="hiddenRow">'
                                                html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '">' + value.Participacion + '</div>'
                                            html += '</td>'
                                        html += '</tr>'
                                    }
                                    //if (idioma == 'en') {
                                    //    $("#divUsuariosPendientes ").html(data.d.length + ' Redords')
                                    //}
                                    //else
                                    //    $("#divUsuariosPendientes ").html(data.d.length + ' Registros')
                                })
                                html += '</tbody>'                                
                            }
                            $("#tablaRporteProductosCategorias").empty()
                            $("#tablaRporteProductosCategorias").append(html)                            
                            //var column1 = $('#tablaRporteProductosCategorias td:first-child');                            
                            //modifyTableRowspan(column1);
                        },
                        error: function (xhr, status, error) {
                            alert(error)
                            console.log(xhr.responseText);
                        }
                    }); 
                }
            })
            */
            $('#btnReporteHoras').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").show()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteHoras',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total = 0
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th width="25%" align="center">Hora</th>'
                        html += '<th width="25%" align="center">Venta</th>'
                        html += '<th width="25%" align="center">Tickets</th>'
                        html += '<th width="25%" align="center">Promedio</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td>' + a[0]
                            html += '</td>'
                            html += '<td align="right">' + formatDollar(a[1])
                            html += '</td>'
                            html += '<td align="right">' + a[2]
                            html += '</td>'
                            html += '<td align="right">' + formatDollar(a[3])
                            html += '</td>'
                            html += '<tr>'
                        }
                        html += '</table>'
                        $("#divContenidoReporte").empty();
                        $('#divContenidoReporte').html(html)
                        $('#divTituloReporte').html('Por horas')
                        $("#carga").hide();
                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReporteVDSII').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").show()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteVDSII',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total = 0
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th  align="center">Day part</th>'
                        html += '<th  align="center">Count</th>'
                        html += '<th  align="center"><=8</th>'
                        html += '<th align="center">>8</th>'
                        html += '<th align="center">Avg time</th>'
                        html += '<th  align="center">Avg under</th>'
                        html += '<th  align="center">Avg over</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td>' + a[0]
                            html += '</td>'
                            html += '<td align="right">' + a[1]
                            html += '</td>'
                            html += '<td align="right">' + a[2]
                            html += '</td>'
                            html += '<td align="right">' + a[3]
                            html += '</td>'
                            html += '<td align="center">' + a[8]
                            html += '</td>'
                            html += '<td align="center">' + a[4]
                            html += '</td>'
                            html += '<td align="center">' + a[6]
                            html += '</td>'
                            html += '<tr>'
                        }
                        html += '</table>'
                        $("#divContenidoReporte").empty();
                        $('#divContenidoReporte').html(html)
                        $('#divTituloReporte').html('Velocidad del servicio II')
                        $("#carga").hide();
                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReporteConsolidado').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#idReporte").val(4);
                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").show()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteConsolidadoVDS',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total = 0
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th  align="center">Fecha</th>'
                        html += '<th  align="center">Verde</th>'
                        html += '<th  align="center">%</th>'
                        html += '<th align="center">Amarillo</th>'
                        html += '<th align="center">%</th>'
                        html += '<th align="center">Rojo</th>'
                        html += '<th  align="center">%</th>'
                        html += '<th  align="center">Verde</th>'
                        html += '<th  align="center">%</th>'
                        html += '<th align="center">Amarillo</th>'
                        html += '<th align="center">%</th>'
                        html += '<th align="center">Rojo</th>'
                        html += '<th  align="center">%</th>'
                        html += '<th  align="center">Tickets</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td>' + a[0] + ' ' + a[1]
                            html += '</td>'
                            html += '<td align="right">' + a[2]
                            html += '</td>'
                            html += '<td align="right">' + a[3]
                            html += '</td>'
                            html += '<td align="right">' + a[4]
                            html += '</td>'
                            html += '<td align="center">' + a[5]
                            html += '</td>'
                            html += '<td align="center">' + a[6]
                            html += '</td>'
                            html += '<td align="center">' + a[7]
                            html += '</td>'
                            html += '<td align="center">' + a[9]
                            html += '</td>'
                            html += '<td align="center">' + a[10]
                            html += '</td>'
                            html += '<td align="center">' + a[11]
                            html += '</td>'
                            html += '<td align="center">' + a[12]
                            html += '</td>'
                            html += '<td align="center">' + a[13]
                            html += '</td>'
                            html += '<td align="center">' + a[14]
                            html += '</td>'
                            html += '<td align="center">' + a[16]
                            html += '</td>'
                            html += '<tr>'
                        }
                        html += '</table>'
                        $("#divContenidoReporte").empty();
                        $('#divContenidoReporte').html(html)
                        $('#divTituloReporte').html('Consolidado velocidad del servicio')
                        $("#carga").hide();
                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReportePCategorias').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'nombre': $('#' + pref + 'DropDownList12').val(), 'opcion': 3 };
                var html = ''

                $("#idReporte").val(3);
                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#tablaRporteProductosCateforias ").empty()
                $("#divContenidoReporte").hide()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").show()
                var sumatorias = [];
                var producto_x = ""
                var porciones_x = 0
                var precio_x = 0
                var cont = 0
                var contpadre = 0
                $.ajax({
                    url: 'Reportes.aspx/ReportePCategorias',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        html = ""
                        var html2 = ''
                        html2 = ""
                        if (data.d.length > 0) {
                            html += '<thead>'
                            html += '<tr >'
                            html += '<th width="25%">Categoría'
                            html += '</th>'
                            html += '<th width="25%">Producto'
                            html += '</th>'
                            html += '<th width="10%">Porciones'
                            html += '</th>'
                            html += '<th width="15%">Participación'
                            html += '</th>'
                            html += '</thead>'

                            html += '<tbody>'
                            $.each(data.d, function (index, value) {

                                if (value.Orden.includes('_a')) {
                                    contpadre++
                                    cont = contpadre
                                    html += '<tr data-toggle="collapse" data-target=".demo' + contpadre + '" id="colap_' + contpadre + '" class="collap">'
                                    html += '<td >' + value.Nombre
                                    html += '</td>'
                                    html += '<td >' + value.Producto
                                    html += '</td>'
                                    html += '<td >' + value.Porcion
                                    html += '</td>'
                                    html += '<td >' + value.Participacion
                                    html += '</td>'
                                    html += '</tr>'
                                }
                                else {
                                    html += '<tr class="">'
                                    html += '<td class="hiddenRow">'
                                    html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '"></div>'
                                    html += '</td>'
                                    html += '<td class="hiddenRow">'
                                    html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '">' + value.Producto + '</div>'
                                    html += '</td>'
                                    html += '<td class="hiddenRow">'
                                    html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '">' + value.Porcion + '</div>'
                                    html += '</td>'
                                    html += '<td class="hiddenRow">'
                                    html += '<div class="collapse demo' + contpadre + ' colap_' + contpadre + '">' + value.Participacion + '</div>'
                                    html += '</td>'
                                    html += '</tr>'
                                }
                                //if (idioma == 'en') {
                                //    $("#divUsuariosPendientes ").html(data.d.length + ' Redords')
                                //}
                                //else
                                //    $("#divUsuariosPendientes ").html(data.d.length + ' Registros')
                            })
                            html += '</tbody>'
                        }
                        $("#tablaRporteProductosCategorias").empty()
                        $("#tablaRporteProductosCategorias").append(html)
                        //var column1 = $('#tablaRporteProductosCategorias td:first-child');                            
                        //modifyTableRowspan(column1);
                        $('#divTituloReporte').html('Productos por categorías')
                        $("#carga").hide();
                    },
                    error: function (xhr, status, error) {
                        $("#carga").hide();
                        alert(error)
                    }
                });
            })

            $('#btnReporteCVerde').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'nombre': $('#' + pref + 'DropDownList12').val(), 'opcion': 2 };

                $("#idReporte").val(2);
                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#tablaRporteProductos ").empty()
                $("#divContenidoReporte").hide()
                $("#table-cont").hide()
                $("#table-cont4").hide()
                $("#table-cont2").show()
                $("#table-cont3").show()
                var sumatorias = [];
                var producto_x = ""
                var porciones_x = 0
                var precio_x = 0
                $.ajax({
                    url: 'Reportes.aspx/ReporteCVerde',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = ''
                        html = ""
                        var html2 = ''
                        html2 = ""
                        if (data.d.length > 0) {
                            html += '<thead>'
                            html += '<tr >'
                            html += '<th width="25%">Nombre'
                            html += '</th>'
                            html += '<th width="25%">Producto'
                            html += '</th>'
                            html += '<th width="20%">Precio'
                            html += '</th>'
                            html += '<th width="10%">Porciones'
                            html += '</th>'
                            html += '<th width="10%">Folio'
                            html += '</th>'
                            html += '<th width="10%">Fecha'
                            html += '</th>'
                            html += '</tr>'
                            html += '</thead>'

                            html += '<tbody>'
                            $.each(data.d, function (index, value) {
                                html += '<tr >'
                                html += '<td >' + value.Nombre
                                html += '</td>'
                                html += '<td >' + value.Producto
                                html += '</td>'
                                html += '<td >' + value.Precio
                                html += '</td>'
                                html += '<td>' + value.Porcion
                                html += '</td>'
                                html += '<td >' + value.Folio
                                html += '</td>'
                                html += '<td >' + value.Hora
                                html += '</td>'
                                html += '</tr>'
                                //if (idioma == 'en') {
                                //    $("#divUsuariosPendientes ").html(data.d.length + ' Redords')
                                //}
                                //else
                                //    $("#divUsuariosPendientes ").html(data.d.length + ' Registros')
                            })
                            html += '</tbody>'

                            html2 += '<thead>'
                            html2 += '<tr >'
                            html2 += '<th width="25%">Producto'
                            html2 += '</th>'
                            html2 += '<th width="20%">Precio'
                            html2 += '</th>'
                            html2 += '<th width="10%">Porciones'
                            html2 += '</th>'
                            html2 += '<th width="10%">Total'
                            html2 += '</th>'
                            html2 += '</tr>'
                            html2 += '</thead>'
                        }

                        var queryResult = Enumerable.From(data.d)
                            .Distinct(function (x) { return x.Producto })
                            .OrderBy(function (x) { return x.Producto })
                            .ToArray();
                        $.each(queryResult, function (index, value) {
                            producto_x = value.Producto
                            html2 += '<tr >'
                            html2 += '<td >' + value.Producto
                            html2 += '</td>'
                            html2 += '<td >' + value.Precio
                            html2 += '</td>'
                            html2 += '<td>' + Enumerable.From(data.d)
                                .Where(function (x) { return x.Producto == producto_x })
                                .Sum(function (x) { return x.Porcion })
                            html2 += '</td>'
                            html2 += '<td >' + (value.Precio * Enumerable.From(data.d)
                                .Where(function (x) { return x.Producto == producto_x })
                                .Sum(function (x) { return x.Porcion }))
                            html2 += '</td>'
                            html2 += '</tr>'
                        })

                        $("#tablaRporteProductosEmpleados ").empty()
                        $("#tablaRporteProductosEmpleados ").append(html)
                        $("#tablaRporteProductosEmpleadosSumatorias ").empty()
                        $("#tablaRporteProductosEmpleadosSumatorias ").append(html2)
                        var column1 = $('#tablaRporteProductosEmpleados td:first-child');
                        modifyTableRowspan(column1);
                        $('#divTituloReporte').html('Comanda verde')
                        $("#carga").hide();
                    },
                    error: function (xhr, status, error) {
                        $("#carga").hide();
                        alert(error)
                        console.log(xhr.responseText);
                    }
                });
            })

            $('#btnReportePFechas').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'nombre': $('#' + pref + 'DropDownList12').val(), 'opcion': 1 };

                $("#idReporte").val(1);
                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#tablaRporteProductosEmpleados ").empty()
                $("#divContenidoReporte").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $("#table-cont ").show()
                $.ajax({
                    url: 'Reportes.aspx/Consulta',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = ''
                        if (data.d.length > 0) {
                            html += '<thead>'
                            for (var i = 0; i < 1; i++) {
                                var x = data.d[i].split('_');
                                html += '<tr >'
                                for (var y = 0; y < x.length - 1; y++) {
                                    html += '<th id="facility_header">' + x[y]
                                    html += '</th>'
                                }
                                html += '</tr>'
                            }
                            html += '</thead>'
                        }
                        $("#tablaRporteProductos thead").empty()
                        $("#tablaRporteProductos ").append(html)
                        html = ""
                        if (data.d.length > 0) {
                            html += '<tbody>'
                            for (var i = 1; i < data.d.length; i++) {
                                var x = data.d[i].split('_');
                                html += '<tr >'
                                for (var y = 0; y < x.length - 1; y++) {
                                    html += '<td>' + x[y]
                                    html += '</td>'
                                }
                                html += '</tr>'
                            }
                            html += '</tbody>'
                        }
                        $("#tablaRporteProductos tbody").empty()
                        $("#tablaRporteProductos ").append(html)
                        $('#divTituloReporte').html('Productos por fechas')
                        $("#carga").hide();
                    },
                    error: function (err) {
                        $("#carga").hide();
                    }
                });
            })

            $('#btnReportePMVendidos').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#idReporte").val(5);
                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").show()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteProductosMasVendidos',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total = 0
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th  align="center">Línea</th>'
                        html += '<th  align="center">Producto</th>'
                        html += '<th  align="center">Porciones</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td align="left">' + a[0]
                            html += '</td>'
                            html += '<td align="center">' + a[2]
                            html += '</td>'
                            html += '<td align="right">' + a[3]
                            html += '</td>'
                            html += '<tr>'
                        }
                        html += '</table>'
                        $("#divContenidoReporte").empty();
                        $('#divContenidoReporte').html(html)

                        $('#divTituloReporte').html('Productos más vendidos')
                        $("#carga").hide();
                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReporteVDS').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#carga").show();
                $("#divTipo").hide();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").show()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteVDS',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total = 0
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th  align="center">Hora</th>'
                        html += '<th  align="center">Tickets</th>'
                        html += '<th  align="center">Tiempo</th>'
                        html += '<th  align="center">Indicador</th>'
                        html += '<th  align="center">Bump</th>'
                        html += '<th  align="center">Indicador</th>'
                        html += '<th  align="center">Prom tiempo</th>'
                        html += '<th  align="center">Prm bump</th>'
                        html += '<th  align="center">Prom tiempo</th>'
                        html += '<th  align="center">Prom bump</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td align="center">' + a[0] + ' ' + a[1]
                            html += '</td>'
                            html += '<td align="center">' + (a[6] != null ? a[6] : '')
                            html += '</td>'
                            html += '<td align="center">' + (a[2] != null ? a[2] : '')
                            html += '</td>'
                            html += '<td align="center">' + (a[3] != null ? a[3] : '')
                            html += '</td>'
                            html += '<td align="center">' + (a[4] != null ? a[4] : '')
                            html += '</td>'
                            html += '<td align="center">' + (a[5] != null ? a[5] : '')
                            html += '</td>'
                            html += '<td align="center">' + a[12]
                            html += '</td>'
                            html += '<td align="center">' + a[13]
                            html += '</td>'
                            html += '<td align="center">' + a[14]
                            html += '</td>'
                            html += '<td align="center">' + a[15]
                            html += '</td>'
                            html += '<tr>'
                        }
                        html += '</table>'
                        $("#divContenidoReporte").empty();
                        $('#divContenidoReporte').html(html)
                        $('#divTituloReporte').html('Velocidad del servicio')
                        $("#carga").hide();

                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })
            btnReporteVentasPresupuesto

            $('#btnReporteTipos').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#carga").show();
                $("#divTipo").show();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").hide()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteTipo',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var total0 = 0;
                        var total1 = 0;
                        var total2 = 0;
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th  align="center">Fecha</th>'
                        html += '<th  align="center">Sucursal</th>'
                        html += '<th  align="center">Tipo</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td align="center">' + a[0]
                            html += '</td>'
                            html += '<td align="center">' + a[1]
                            html += '</td>'
                            html += '<td align="center">' + (a[2] == 0 ? 'Local' : +a[2] == 1 ? 'RAPPI' : +a[2] == 2 ? 'Llevar' : '')
                            html += '</td>'
                            html += '<tr>'
                            if (a[2] == 0)
                                total0++
                            if (a[2] == 1)
                                total1++
                            if (a[2] == 2)
                                total2++
                        }
                        html += '</table>'
                        $("#divContenidoReporteTipo").empty();
                        $('#divContenidoReporteTipo').html(html)
                        $("#divTotalTipo").empty();
                        $('#divTotalTipo').html('Local:' + total0 + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAPPI:' + total1 + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Llevar:' + total2)
                        $('#divTituloReporte').html('Tipos de servicio')
                        $("#carga").hide();

                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReporteVentasPresupuesto').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#carga").show();
                $("#divTipo").show();
                $("#divVentas").hide();
                $("#divMonedero").hide();
                $("#divContenidoReporte").hide()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteVentasPresupuesto',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        html = data.d

                        $("#divContenidoReporteTipo").empty();
                        $('#divContenidoReporteTipo').html(html)
                        $("#divTotalTipo").empty();
                        $("#carga").hide();
                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReporteMonedero').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };

                $("#carga").show();
                $("#divMonedero").show();
                $("#divVentas").hide();
                $("#divTipo").hide();
                $("#divContenidoReporte").hide()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteMonedero',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var objdata = $.parseJSON(data.d);
                        html += '<table class="table tablaAdmin">'
                        html += '<tr>'
                        html += '<th  align="center">Monedero</th>'
                        html += '<th  align="center">Saldo actual</th>'
                        html += '<th  align="center">Fecha alta</th>'
                        html += '<th  align="center"># movimientos</th>'
                        html += '<th  align="center">Ult. movimiento</th>'
                        html += '<th  align="center">Suc. ult. movimiento</th>'
                        html += '<tr>'
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            html += '<tr>'
                            html += '<td align="center" class="numCard">' + a[0]
                            html += '</td>'
                            html += '<td align="center">' + formatDollar(a[1])
                            html += '</td>'
                            html += '<td align="center">' + a[2]
                            html += '</td>'
                            html += '<td align="center">' + a[3]
                            html += '</td>'
                            html += '<td align="center">' + a[4]
                            html += '</td>'
                            html += '<td align="center">' + a[5]
                            html += '</td>'
                            html += '<tr>'
                        }
                        html += '</table>'
                        $("#divEncabezado").empty();
                        $('#divEncabezado').html(html)
                        $("#divDetalle").empty();
                        $('#divDetalle').html()
                        $('#divTituloReporte').html('Reporte de movimientos de monederos')
                        $("#carga").hide();

                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })

            $('#btnReporteVentas').click(function () {
                var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val() };
                $("#carga").show();
                $("#divVentas").show();
                $("#divMonedero").hide();
                $("#divTipo").hide();
                $("#divContenidoReporte").hide()
                $("#table-cont").hide()
                $("#table-cont2").hide()
                $("#table-cont3").hide()
                $("#table-cont4").hide()
                $.ajax({
                    url: 'Reportes.aspx/ReporteVentasMensuales',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        html = data.d

                        $("#divEncabezadoVentas").empty();
                        $('#divEncabezadoVentas').html(html)
                        $('#divTituloReporte').html('Reporte de ventas mensuales')
                        $("#carga").hide();

                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });

                //DETALLE
                $.ajax({
                    url: 'Reportes.aspx/ReporteVentasMensualesdetalle',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        html = data.d
                        $("#divDetalleVentas").empty();
                        $('#divDetalleVentas').html(html)
                        var labels = []
                        var datos_ = []
                        $("#tblVentaMensuales tbody tr").each(function (index) {
                            var campo1, campo2;
                            $(this).children("td").each(function (index2) {
                                switch (index2) {
                                    case 7:
                                        campo1 = $(this).text();
                                        break;
                                    case 8:
                                        campo2 = $(this).text();
                                        break;
                                }
                            })
                            if (campo1 && campo2) {
                                if (!campo1.includes('Total') && !campo1.includes('Pro')) {
                                    labels.push(campo1)
                                    campo2 = campo2.replace("$", "")
                                    campo2 = campo2.replace(/,/g, '')
                                    datos_.push(campo2)
                                }
                            }
                        })
                        var barChartDataMP3 = {
                            labels: labels,
                            datasets: [{
                                label: 'Ventas mensuales',
                                backgroundColor: [colores[Math.floor(Math.random() * 85)]],
                                data: datos_
                            }]
                        };
                        var ctx = document.getElementById("canvasGrafica").getContext('2d');
                        if(myBarDesHorizontalMP3!=null){
                            myBarDesHorizontalMP3.destroy();
                        }
                        myBarDesHorizontalMP3 = new Chart(ctx, {
                            type: 'line',
                            data: barChartDataMP3,
                            options: {
                                scales: {
                                    yAxes: [{
                                        ticks: {
                                            // Include a dollar sign in the ticks
                                            callback: function (value, index, values) {
                                                return '$' + formatDollar(value);
                                            }
                                        }
                                    }]
                                },
                                tooltips: {
                                    mode: 'index',
                                    intersect: false,
                                    callbacks: {
                                        label: function (tooltipItem, data) {
                                            return  Number(tooltipItem.yLabel).toFixed(2).replace(/./g, function (c, i, a) {
                                                return i > 0 && c !== "." && (a.length - i) % 3 === 0 ? "," + c : c;
                                            });
                                        }
                                    }
                                }
                            }
                        });
                        $("#carga").hide();

                    },
                    error: function (err) {
                        $("#carga").hide();
                        alert(err);
                    }
                });
            })
        });
        $('.collapse').on('show.bs.collapse', function () {
            $('.collapse.in').collapse('hide');
        });
        $(document).on('click', '.numCard', function (event) {
            var datos = { 'f1': $('#' + pref + 'date1').val(), 'f2': $('#' + pref + 'date2').val(), 'sucursal': $('#' + pref + 'DropDownList12').val(), cardNum: $(this).text() };

            $("#carga").show();
            $("#divMonedero").show();
            $("#divTipo").hide();
            $("#divContenidoReporte").hide()
            $("#table-cont").hide()
            $("#table-cont2").hide()
            $("#table-cont3").hide()
            $("#table-cont4").hide()
            $.ajax({
                url: 'Reportes.aspx/ReporteDetalleMonedero',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {
                    var html = '';
                    var objdata = $.parseJSON(data.d);
                    html += '<table class="table tablaAdmin">'
                    html += '<tr>'
                    html += '<th  align="center">Fecha Mov</th>'
                    html += '<th  align="center">Tipo mov</th>'
                    html += '<th  align="center">Importe</th>'
                    html += '<th  align="center">Suc movimientos</th>'
                    html += '<tr>'
                    for (var i = 0; i < objdata[0].length - 1; i++) {
                        var a = objdata[0][i]
                        html += '<tr>'
                        html += '<td align="center" >' + a[0]
                        html += '</td>'
                        html += '<td align="center">' + a[1]
                        html += '</td>'
                        html += '<td align="center">' + formatDollar(a[2])
                        html += '</td>'
                        html += '<td align="center">' + a[3]
                        html += '<tr>'
                    }
                    html += '</table>'
                    $("#divDetalleMonedero").empty();
                    $('#divDetalleMonedero').html(html)
                    $("#carga").hide();

                },
                error: function (err) {
                    $("#carga").hide();
                    alert(err);
                }
            });
        });
        $(document).on('click', '.collap', function (event) {
            var id = $(this).prop('id')
            var clase = $(this).prop('class')
            if (clase.includes('borde')) {
                $('.' + id).removeClass("borde");
                $(this).removeClass("borde");
            }
            else {
                $('.' + id).addClass("borde");
                $(this).addClass("borde");
            }
        });
        function modifyTableRowspan(column) {
            var prevText = "";
            var counter = 0;
            column.each(function (index) {
                var textValue = $(this).text();
                if (index === 0) {
                    prevText = textValue;
                }
                if (textValue !== prevText || index === column.length - 1) {
                    var first = index - counter;
                    if (index === column.length - 1) {
                        counter = counter + 1;
                    }
                    column.eq(first).attr('rowspan', counter);
                    if (index === column.length - 1) {
                        for (var j = index; j > first; j--) {
                            column.eq(j).remove();
                        }
                    }
                    else {
                        for (var i = index - 1; i > first; i--) {
                            column.eq(i).remove();
                        }
                    }
                    prevText = textValue;
                    counter = 0;
                }
                counter++;
            });
        }
    </script>
    <div id="mydiv" style="display: none">
        <iframe id="frame" src="" width="200" height="100"></iframe>
    </div>

    <div>
        <img src="img/carga.gif" width="150" height="" style="display: none" id="carga" class="centrar img-fluid" />
    </div>
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    </div>
    <div class="" style="padding-left: 10px; padding-top: 15px">
        <div style="padding-top: 25px; padding-bottom: 25px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left">
                <asp:Label runat="server" Text="<%$Resources:multi.language,reportes_titulo%>" />
            </div>
            <%--<a href="Dashboard.aspx"><img src="img/Logo.png" class="img-fluid imgLgo" alt="Responsive image" style="height: 43px; float: right" /></a>--%>
            <div style="clear: both"></div>
        </div>
        <div id="divSolicitudes" class="contornoVerde2 divAdmin" style="margin-bottom: 5px; padding: 10px; height: 30%;">
            <div class="row" style="margin-bottom: 0px;">
                <div class="col-sm-3">
                    <div class="SeleccionarFecha" style="padding-bottom: 0px">
                        <div class="form-group has-feedback date" id="datetimepicker1">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control fechaVenta BordeRadious" id="date1" name="date1" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #f58220; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
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
                    <div class="SeleccionarFecha" style="padding-bottom: 0px">
                        <div class="form-group has-feedback date" id="datetimepicker2">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control fechaVenta BordeRadious" id="date2" name="date2" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #f58220; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
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
                </script>
                <div class="col-sm-3">

                    <div class="SeleccionarFecha" style="padding-bottom: 0px">
                        <div class="form-group has-feedback BordeRadious" style="">
                            <span class="ForeColor939393">
                                <img src="img/Home.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                            </span>
                            <asp:DropDownList CssClass="form-control fechaVenta BordeRadious" ID="DropDownList12" DataSourceID="SqlDataSource1" runat="server" DataTextField="nombre" DataValueField="nombre" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px">
                                <asp:ListItem Text="<%$Resources:multi.language,dash_todas%>"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select T1.nombre from mlocal T1  join relacionGrupoSucursal T2 ON T1.id_local = T2.idlocal  join relacionSucursalUsuario t3 on t2.idgrupo = t3.id_local WHERE T3.id_usuario = @IdUsuario"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select nombre from mlocal where id_local in(750,751,752,799,753,754,755,756)"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="SeleccionarFecha" style="padding-bottom: 10px; display: none">
                        <div class="form-group has-feedback BordeRadious">
                            <span class="ForeColor939393">
                                <img src="img/Reporte.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                            </span>
                            <asp:DropDownList CssClass="form-control fechaVenta" ID="lista" runat="server" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px" Style="border: 1px solid #f58220">
                                <asp:ListItem>...</asp:ListItem>
                                <%--<asp:ListItem Value="1" Text="Producto por fechas"></asp:ListItem>--%>
                                <%--<asp:ListItem Value="2" Text="Comanda verde"></asp:ListItem>--%>
                                <%--<asp:ListItem Value="3" Text="Productos categorías"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3" style="display: none">
                    <input type="button" id="btnSolicitudes" value="Buscar" class="btn btn-primary" style="float: left" />
                    <input type="button" id="btnExport" value="Exportar Excel" class="btn btn-primary" style="float: right" />
                </div>
            </div>
            <div class="container" style="margin: 0px;">
                <div class="row">
                    <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                        <div class="row">
                            <div class="col-6">
                                <div id="btnReporteHoras" class="divbtnReporte">Reporte por horas</div>
                            </div>
                            <div class="col-6">
                                <div id="btnReporteVDSII" class="divbtnReporte">Velocidad del servicio II</div>
                            </div>
                            <div class="col-6 ">
                                <div id="btnReportePCategorias" class="divbtnReporte">Productos por categoría</div>
                            </div>
                            <div class="col-6 ">
                                <div id="btnReporteCVerde" class="divbtnReporte">Reporte comanda verde</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                        <div class="row">
                            <div class="col-6 ">
                                <div id="btnReportePFechas" class="divbtnReporte">Productos por fechas</div>
                            </div>
                            <div class="col-6 ">
                                <div id="btnReportePMVendidos" class="divbtnReporte">Productos más vendidos</div>
                            </div>
                            <div class="col-6 ">
                                <div id="btnReporteTipos" class="divbtnReporte" style="">Tipos de servicio</div>
                            </div>
                            <div class="col-6 ">
                                <div id="btnReporteMonedero" class="divbtnReporte" style="">Consulta Monederos</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-12 col-md-12 col-lg-6">
                        <div class="row">
                            <div class="col-6 ">
                                <div id="btnReporteVentas" class="divbtnReporte" style="">Ventas mensuales</div>
                            </div>                            
                            <div class="col-6 ">
                                <div id="btnReporteVentasPresupuesto" class="divbtnReporte" style="">Ventas vs presupuesto</div>
                            </div>
                            <div class="col-6 ">
                                <div id="btnExcel" class="divbtnReporte" style="font-weight: bold">Exportar</div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="idReporte" /><div class="titulo divTitulo" id="divTituloReporte"></div>
                <div style="width: 100%; overflow-x: scroll; min-height: 350px;">
                    <div class='table-cont' id='table-cont'>
                        <table id="tablaRporteProductos" class="table tablaAdmin" style="font-weight: normal!important">
                        </table>
                    </div>
                    <div class='table-cont2' id='table-cont3'>
                        <table id="tablaRporteProductosEmpleadosSumatorias" class="table tablaAdmin" style="font-weight: normal!important">
                        </table>
                    </div>
                    <br />
                    <div class='table-cont' id='table-cont2'>
                        <table id="tablaRporteProductosEmpleados" class="table tablaAdmin" style="font-weight: normal!important">
                        </table>
                    </div>
                    <div class='table-cont' id='table-cont4'>
                        <table class="table tablaAdmin" style="border-collapse: collapse;" id="tablaRporteProductosCategorias">
                        </table>
                    </div>
                    <div class='table-cont' id='table-cont5'>
                        <div id="divContenidoReporte">
                        </div>
                    </div>
                    <div id="divTipo">
                        <div id="divTotalTipo"></div>
                        <div class='table-cont' id='table-cont6'>
                            <div id="divContenidoReporteTipo">
                            </div>
                        </div>
                    </div>
                    <div id="divMonedero">
                        <div id="divEncabezado" style="width: 100%; overflow-x: scroll; max-height: 250px;"></div>
                        <div class='table-cont' id='table-cont7'>
                            <div id="divDetalleMonedero">
                            </div>
                        </div>
                    </div>
                    <div id="divVentas">
                        <div id="divEncabezadoVentas" style="width: 100%; overflow-x: scroll; max-height: 350px;"></div>
                        <div class='table-cont' id=''>
                            <div id="divDetalleVentas">
                            </div>
                        </div>
                        <br />
                        <div id="divGraficaVenta">
                            <canvas id="canvasGrafica" height="105" style="margin: auto; width: 100%"></canvas>
                        </div>
                        <br />
                        <br />
                        <br />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

