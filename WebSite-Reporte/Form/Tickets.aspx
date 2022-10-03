<%@ Page Title="" Language="C#" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="Tickets.aspx.cs" Inherits="Form_Tickets" %>


<asp:Content ID="Content8" ContentPlaceHolderID="Content9" Runat="Server">
    <style>
        .btn {
            background-color: #fff !important;
            border: 1px solid #6db23f;
            color: #939393 !important;
        }
    </style>
    <script src="js/funciones.js"></script>
    <script>
        var pref = "Content9_"
        $(document).ready(function () {
            var fecha1 = '<%=Session["fecha"]%>'
            var sucursal = '<%=Session["sucursal"]%>'
            var consultaini = '<%=Session["consulta"]%>'
            $('#divTienda').html(sucursal);
            if (consultaini==18)
                $('#' + pref + "DropDownList1 option[value=todos]").attr("selected",true);
            if (consultaini==19)
                $('#' + pref + "DropDownList1 option[value=cancelaciones]").attr("selected",true);
            if (consultaini==20)
                $('#' + pref + "DropDownList1 option[value=descuentos]").attr("selected",true);
            if (consultaini==21)
                $('#' + pref + "DropDownList1 option[value=ventas]").attr("selected",true);
            llenadoInfo(consultaini)

            $("#btn1").click(function () {
                llenadoInfo(consultaini)
            });

            $('#' + pref + 'DropDownList1').change(function () {
                var opcion = $('#' + pref + 'DropDownList1').val()
                var consulta = 18
                if (opcion=='todos')
                    consulta = 18
                if (opcion=='cancelaciones')
                    consulta = 19
                if (opcion=='descuentos')
                    consulta = 20
                if (opcion=='ventas')
                    consulta = 21  
                llenadoInfo(consulta)
            });

            function llenadoInfo(consulta) {
                        $("#divTickets").html('');
                var datos = { 'f1': fecha1, 'sucursal': sucursal,'consulta':consulta };
                $.ajax({
                    url: 'Tickets.aspx/MuestraTickets',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(datos),
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        var html = '';
                        var html2 = '';
                        var total =0
                        var objdata = $.parseJSON(data.d);
                        //console.log(objdata)
                        for (var i = 0; i < objdata[0].length - 1; i++) {
                            var a = objdata[0][i]
                            //console.log(a[1] + ' ' + formatDollar(a[3]))
                            //alert(formatDollar(a[3]))
                            html += '<div id="' + a[4] + '" alt="' + a[0] + '" class="detalleTicket ' 
                                if (a[2] > 0)
                                    html += " descuento"
                                else
                                    html += " "
                                html+= '" ><div class="w-100" style="" >' +
                                '<div class="float-left" style="width:65%">' +a[6]+'&nbsp;&nbsp;'+a[5]+'&nbsp;&nbsp;'+ a[0] + '</div>' +
                                '<div class=" float-right" style="text-align:right;width:35%">' + formatDollar(a[1]) +'</div>'
                            html += '</div></div></a><div style="clear:both"></div><hr>'
                            total += a[1];
                        }
                        html2 += '<div class="w-100  cuadroVerde" style="font-size:17px!important;font-weight:bold" >' +
                                '<div class="w-50 pb-3 float-left" style="background-color: #fff;">Total</div>' +
                                '<div class="w-50 pb-3 float-right" style="background-color: #fff;text-align:right;padding-right:10px;">' + formatDollar(total) + '</div>'
                            html2 += '</div>'

                        $("#divTickets").empty();
                        $('#divTickets').html(html)
                        $('#divTicketsTotal').empty()
                        $('#divTicketsTotal').html(html2)
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
        })
         $(document).on('click', '.detalleTicket', function (event) {
            var id = $(this).attr('id')
            $("#modalTicket2").modal();
            var datos = { 'id': id  };
            console.log(id)
            $.ajax({
                url:  'AdministrarCuentas.aspx/DetalleTicketEncabezado',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {
                    var html = ''
                    console.log(data.d)
                    html = 'Orden: ' + data.d.Mesa + '<br>' +
                    'Fecha: '+ data.d.Apertura + '<br>' +
                    'Cliente: '+ data.d.Desc_info + '<br>' +
                    'Autorizó: '+ data.d.Desc_emp
                     
                    $("#encabezado").html(html)
                },
                error: function (err) {
                    alert(err);
                }
            });
            $.ajax({
                url:  'AdministrarCuentas.aspx/DetalleTicketCuerpo',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {

                    var html = ''
                    console.log(data.d)
                    var desc =0 
                    var importe =0
                    html = ''
                    html= '<table style="width:100%">'
                        $.each(data.d, function (index, value) {
                            importe += value.M_importe
                            desc += value.M_desc
                            html += '<tr >'
                            html += '<td  width="10%">' + value.Porciones
                            html += '</td>'
                            html += '<td  width="70%">' + value.Producto
                            html += '<td  width="20%" align="right">' +formatDollar( value.M_importe)
                    })
                    html+='</table>'
                        //$("#tblDetalleTicket tbody").empty();
                    //$("#tblDetalleTicket").append(html)
                    html+='<hr>'
                    html+='<table style="width:100%"><tr><td width="10%" align="right"> </td><td rowspan="2" width="70%">Importe</td><td width="20%" align="right">'+formatDollar(importe)+' </td></tr></table>'
                    html+='<table style="width:100%"><tr><td width="10%" align="right"> </td><td rowspan="2" width="70%">Descuento</td><td width="20%" align="right">'+formatDollar(desc)+' </td></tr></table>'
                    html+='<table style="width:100%"><tr><td width="10%" align="right"> </td><td rowspan="2" width="70%">Total</td><td width="20%" align="right">'+formatDollar(importe-desc)+' </td></tr></table>'
                    $("#cuerpo").html(html)
                },
                error: function (err) {
                    alert(err);
                }
            });
            $.ajax({
                url:  'AdministrarCuentas.aspx/DetalleTicketPago',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(datos),
                dataType: "json",
                method: 'post',
                success: function (data) {
                    var html = ''
                    console.log(data.d)
                    html = 'Pago<br> ' +
                        '<div style="float:left">'+data.d.Forma_pago + '</div>' +
                            '<div style="float:right">' + formatDollar(data.d.Tc_monto)+'</div><div style="clear:both"></div>' 
                     
                    $("#pago").html(html)
                },
                error: function (err) {
                    alert(err);
                }
            });
        });
    </script>
    <div id="modalTicket2" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content" style="font-size:12px!important">
                <div class="modal-header">
                </div>
                <div class="modal-body contornoVerde2 divAdmin" style="margin-left: 5px; margin-right: 5px;">
                    
                    <div id="encabezado"></div>
                    <hr />
                    <div id="cuerpo">
                        <table id="tblDetalleTicket" style="width:100%">
                            <thead>
                           <%-- <tr>
                                <th width="50%">Producto</th>
                                <th width="50%">Producto</th>
                                <th width="10%">P. unit</th>
                                <th width="10%">Desc</th>
                                <th width="15%">Total</th>
                            </tr>--%>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <hr />
                    <div id="pago"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCloseAdmin">OK</button>
                </div>
            </div>

        </div>
    </div>
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    </div>
    <div class=" divDashboard thisOne" style="padding-top: 15px">
       
        <div style="padding-top: 15px; padding-bottom: 5px">
             <div class="grisFuerte ffGalaxie titulo" style=" padding-top: 10px"> <a href="DetalleVenta.aspx"> <img src="img/regresar.png" width="40"/></a> Tickets</div>
            
        </div>
        <div class="row" style="margin-bottom: 15px;border-radius:5px;background-color: #6db23f;margin-top:5px">
            <div class="col-sm-12">
                <div id="divTienda" ></div>                
            </div>
            <div class="col-sm-6" style="display:none">
                <div class="form-group has-feedback BordeRadious" style="margin-top:5px;margin-bottom:10px">
                            <span class="ForeColor939393">
                                <img src="img/icono_ventas.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                            </span>
                            <asp:DropDownList  CssClass="form-control" ID="DropDownList1" runat="server" DataTextField="nombre" DataValueField="nombre" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px" style="border: 1px solid #6db23f" >
                                <asp:ListItem>...</asp:ListItem>
                                <asp:ListItem Value="todos" >Todos</asp:ListItem>
                                <asp:ListItem Value="ventas" >Ventas</asp:ListItem>
                                <asp:ListItem Value="descuentos" >Descuentos</asp:ListItem>
                                <asp:ListItem Value="cancelaciones" >Cancelaciones</asp:ListItem>
                            </asp:DropDownList>
                        </div>
            </div>
        </div>
        <div id="" class="contornoVerde2 divAdmin" style="margin-bottom:15px; padding:30px;height:30%;">
        <div class="w-100 " id="divTicketsTotal">

        </div>
        <div class="w-100 " id="divTickets" style="overflow:scroll!important;height:450px;">

        </div>
        </div>
    </div>
</asp:Content>

