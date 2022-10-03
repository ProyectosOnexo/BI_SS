<%@ Page Title="" Language="C#" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="Ventas.aspx.cs" Inherits="Form_Ventas" %>


<asp:Content ID="Content7" ContentPlaceHolderID="Content7" runat="Server">
    
    <style>
        #divSucursales hr{
            color:#000!important;
            margin-top:5px;
        }
        .cuadroTotal{
            color: #939393;
            margin-top:6px;
            margin-bottom:6px;
        }
    </style>
    <script src="js/funciones.js"></script>
    <script>
        var pref = "Content7_"
        $(document).ready(function () {
            <%--var idioma = '<%=Session["lang"]%>'
            var tiendas
            if (idioma == 'en') {
                $('#btn1').attr('value', 'Search')
            }--%>

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
            
            var fecha = '<%=Session["fecha"]%>'
            var z = new Date();
            var n;
            if (z.getHours() < 12)
                n = new Date(z.setDate(z.getDate() - 1));
            else
                n = new Date(z.setDate(z.getDate()));
            console.log(z.getHours())
            y = n.getFullYear(); m = n.getMonth() + 1; d = n.getDate();
            if(fecha!="")
                //$('#' + pref + 'date1').val(fecha)
                $('#date1').val(fecha)
            else
                //$('#' + pref + 'date1').val(d + "/" + (m > 10 ? m : '0' + m) + "/" + y+' - '+d + "/" + (m > 10 ? m : '0' + m) + "/" + y)
                $('#date1').val(d + "/" + (m > 9 ? m : '0' + m) + "/" + y+' - '+d + "/" + (m > 10 ? m : '0' + m) + "/" + y)

            
            llenarInfo();
                $('#date1').change(function (){
                        llenarInfo();                
                })
            
            var temperatura 
            var apiid = '34188bc3cfafc12bda7ef3a00ebec962'
            var idcd ='3530597'
            function llenarInfo() {
                //var datos = { 'f1': $('#' + pref + 'date1').val() };
                var datos = { 'f1': $('#date1').val() };
                console.log(datos)
                $.ajax({
                    url: 'Ventas.aspx/InicioVentas',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total = 0
                        var objdata = $.parseJSON(data.d);
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]

                            html += '<div id="' + a[0] + '" alt="' + a[1] + '" class="detalleVenta container" ><div class="row">' +
                                '<div class="col-6" class="tiendaVenta" style="">' + a[1] + '</div>' +
                                '<div class="col-6" class="ventaVenta" style="text-align:right">' + formatDollar(a[3]) + '</div>'+
                            '<div class="col" style="text-align:center"></div > '
                                //< img src = "http://openweathermap.org/img/w/04n.png" >
                            var res =''
                           /* $.ajax({
                                async: false, 
                                type: "GET",
                                url: "https://api.openweathermap.org/data/2.5/weather?id="+idcd+"&appid=" + apiid,
                                dataType: "json",
                                success: function (data) {
                                    var vars = data.main;
                                    var var2 = data.weather;
                                    temperatura = vars.temp - 273.15;
                                    res = '<div class="col" style="text-align:center;margin-top:-15px;">' +
                                       '<img src="https://openweathermap.org/img/w/' + var2[0].icon + '.png">' + '</div>'
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    alert(errorThrown);
                                }
                            })*/
                                html += res
                            html += '</div></div>'
                            total += a[3];
                        }
                        html2 = '<div class="cuadroTotal container" style="font-size:17px!important;font-weight:bold;padding:0px!important;margin:opx!important" ><div class="row">' +
                                    '<div class="col-6" style="background-color: #fff;padding-left:0px;">Total</div>' +
                                    '<div class="col-6" style="background-color: #fff;text-align:right">' + formatDollar(total) + '</div>'+
                                    '<div class="col" style="background-color: #fff;text-align:center;padding-left:0px;padding-right:0px">' 
                                    //'<img src="http://openweathermap.org/img/w/'+var2[0].icon+'.png">'  + '</div>'
                                html2 += '</div></div>'

                                $('#divSucursalesTotal').empty()
                                $('#divSucursalesTotal').html(html2)
                        /*$.ajax({
                            type: "GET",
                            url: "http://api.openweathermap.org/data/2.5/weather?id="+idcd+"&appid=" + apiid,
                            dataType: "json",
                            success: function (data) {
                                var vars = data.main;
                                var var2 = data.weather;
                                temperatura = vars.temp - 273.15;
                                
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(errorThrown);
                            }
                        });    */                  
                        
                        $('#divSucursales').empty()
                        $('#divSucursales').html( html)
                    }
                })
            }
            function clima() {
                
                $.ajax({
                       type: "GET",
                       url: "http://api.openweathermap.org/data/2.5/weather?id=3514783&appid=34188bc3cfafc12bda7ef3a00ebec962",
                       dataType: "json",
                       success: function (data) {
                          var vars = data.main;
                           temperatura = vars.temp - 273.15;
                           /*var temp_f = 1.8 * (vars.temp - 273.15) + 32;*/
                           console.log('dentro ' +temperatura)
                       },
                       error: function (jqXHR, textStatus, errorThrown) {
                          alert(errorThrown);
                       }
                });
            }
            $(document).on('click', '.detalleVenta', function (event) {
                var id = $(this).attr('id')
                var alt = $(this).attr('alt')
                window.location.assign("DetalleVenta.aspx?fecha="+$('#date1').val()+"&sucursal="+alt);
            })
            
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

    </script>
    
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    </div>
    <div class=" divDashboard thisOne" style="padding-top: 5px">
        <div style="padding-top: 15px; padding-bottom: 5px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top: 10px">Ventas</div>
            <a name="home" id="home"></a>
            <div style="clear: both"></div>
        </div>
        <div id="divSolicitudes" class="contornoVerde2 divAdmin" style="margin-bottom:15px; padding:10px;height:30%;">
      <%-- <div >
            <div class="SeleccionarFecha">
                <div class="form-group has-feedback date" id="datetimepicker1">
                    <span class="ForeColor939393">
                        <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                    </span>
                    <input runat="server" class="form-control BordeRadious" id="date1" name="date1" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True" />
                </div>
            </div>
        </div>--%>
            <div >
            <div class="SeleccionarFecha">
                <div class="form-group has-feedback date" id="datetimepicker2">
                    <span class="ForeColor939393">
                        <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                    </span>
                    <input type="text" class="form-control BordeRadious" id="date1" name="date1" value="" placeholder="DD/MM/YYYY" style="font-size: small; height: 30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" />
                </div>
            </div>
        </div>
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="w-100" id="divSucursalesTotal">
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="w-100" id="divSucursales">
                        </div>
                    </div>
                </div>
            </div>
    </div>
    </div>
</asp:Content>

