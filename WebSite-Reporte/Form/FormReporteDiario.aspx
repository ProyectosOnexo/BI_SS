<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeFile="FormReporteDiario.aspx.cs" Inherits="Form_FormReporteDiario" MasterPageFile="~/Form/MasterPage.master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Content3" runat="Server">
    <script>
        var pref ="Content3_"
        $(document).ready(function () {
            var date_input = $('#'+pref+'date'); //our date input has the name "date"
            var options = {
                format: 'dd/mm/yyyy',
                todayHighlight: true,
                bordercolor: '#6DB23F',
                autoclose: true,
                language: 'es'
            };
            date_input.datepicker(options);

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                var date_input = $('#'+pref+'date'); //our date input has the name "date"
                var options = {
                    format: 'dd/mm/yyyy',
                    todayHighlight: true,
                    bordercolor: '#6DB23F',
                    autoclose: true,
                    language: 'es'
                };
                date_input.datepicker(options);

            }

        });
    </script>

    <script>
        $(document).ready(function () {
            //$('#Content3_SelectTipoTienda').change(function () { 
            //    $('#Content3_SelectTipoTienda').empty();
            //})
            var date_input = $('#'+pref+'date2'); //our date input has the name "date"
            var options = {
                format: 'dd/mm/yyyy',
                todayHighlight: true,
                bordercolor: '#6DB23F',
                autoclose: true,
                language: 'es'
            };
            date_input.datepicker(options);

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                var date_input = $('#'+pref+'date2'); //our date input has the name "date"
                var options = {
                    format: 'dd/mm/yyyy',
                    todayHighlight: true,
                    bordercolor: '#6DB23F',
                    autoclose: true,
                    language: 'es'
                    
                };
                date_input.datepicker(options);
            }
        });
    </script>
    <link href="css/StyleReporteDiario.css" rel="stylesheet" />
    
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish1" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish1" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />

    </div>
    <div class="container-fluid" style="width: 100%;padding-top:15px;">
    <div>
    <div style="padding-top: 35px; padding-bottom: 25px">
            <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top: 10px">
                <asp:Label runat="server" class="TituloCatalogo" Text="<%$Resources:multi.language,reportes_titulo%>"/>
                </div>
                <a href="Dashboard.aspx">
                <img src="img/Logo.png" class="img-fluid imgLgo" alt="" style="height: 43px; float: right" /></a>
            <div style="clear: both"></div>
        </div>
    </div>
    <!-- Page Content  -->
    <div>

        <asp:UpdateProgress ID="UpdateProgress" runat="server" AssociatedUpdatePanelID="updatepanel1" >
            <ProgressTemplate>
                <div id="progressBackgroundFilter" style="width: 200px">

                </div>
                <div id="processMessage">
                     <%--<label style="font-family: 'Droid Sans'; color: #6db23f; font-size: 100%; font: bold;">
                        CARGANDO...<img src="ImgPcks/Animacion_fondo_negro.gif" />
                    </label>--%>
                    <img id="Cargando" src="ImgPcks/Animacion_fondo_negro.gif"/>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>    
            <div>  
                
                <asp:Literal runat="server" ID="MensajeAlert" Text="" >

                </asp:Literal>

                <label class="TipodeLetraDroid" style="">
                   <asp:Label runat="server" class="TituloCatalogo" Text="<%$Resources:multi.language,reportes_filtro%>"/>
                </label>

                <div class="row" id="thisOne">

                <!--PRIMERA COLUMNA-->
                <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        <div class="form-group has-feedback date" id="datetimepicker1"">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px; margin-right: 5px" />
                            </span>
                            <input runat="server" class="form-control BordeRadious" id="date" name="date" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height:30px; border-color: #6db23f; font-family: 'Droid Sans'; font-weight: normal;" autocomplete="off" aria-atomic="True"/>
                        </div>
                        
                    </div>
                </div>
                         
                <!--SEGUNDA COLUMNA-->
                <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        <div class="form-group has-feedback date2" id="datetimepicker2">
                            <span class="ForeColor939393">
                                <img src="img/calendario.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                            </span>
                            <input runat="server" class="form-control BordeRadious" id="date2" name="date2" placeholder="DD/MM/YYYY" type="text" style="font-size: small; height:30px; border-color: #6DB23F; font-family: 'Droid Sans';" autocomplete="off"/>
                        </div>
                        
                    </div>
                </div>

                <!--TERCERA COLUMNA-->
                <div class="col-sm-3">
                    <div class="SeleccionarFecha">   
                        <div class="form-group has-feedback BordeRadious">
                            <span class="ForeColor939393">
                                <img src="img/Home.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                            </span>

                            <asp:DropDownList  CssClass="form-control" id="SelectTipoTienda"  runat="server" DataTextField="nombre" DataValueField="nombre" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px" style="border: 1px solid #6db23f">
                                <asp:ListItem>TODAS</asp:ListItem>
                            </asp:DropDownList>


                            <asp:SqlDataSource  ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select distinct T1.nombre from mlocal T1  join relacionGrupoSucursal T2 ON T1.id_local = T2.idlocal  join relacionSucursalUsuario t3 on t2.idgrupo = t3.id_local WHERE T3.id_usuario = @IdUsuario"></asp:SqlDataSource>
                            <asp:SqlDataSource  ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ToksBdConnectionString %>" SelectCommand="select distinct nombre from mlocal where id_local >= 750"></asp:SqlDataSource>
                        
                        </div>
                    
                    </div>                
                </div>

                <!--CUARTA COLUMNA-->
                <div class="col-sm-3">
                    <div class="SeleccionarFecha">
                        
                        <div class="form-group has-feedback BordeRadious">
                            <span class="ForeColor939393">
                                <img src="img/Reporte.png" alt="Alternate Text" class="form-control-feedback" height="40" style="margin-top: -5px;" />
                            </span>
                            <asp:DropDownList  CssClass="form-control" ID="DropDownList1" runat="server" DataTextField="nombre" DataValueField="nombre" Width="100%" Font-Names="Droid Sans" ForeColor="#606060" AppendDataBoundItems="True" Font-Size="Small" Height="30px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" style="border: 1px solid #6db23f" AutoPostBack="true">
                                <asp:ListItem>...</asp:ListItem>
                                <asp:ListItem Value="REPORTE DIARIO" Text="<%$Resources:multi.language,reportes_diario%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE POR HORA" Text="<%$Resources:multi.language,reportes_hora%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE PMIX" Text="<%$Resources:multi.language,reportes_pmix%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE TRANSACCIONES" Text="<%$Resources:multi.language,reportes_transacciones%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE VELOCIDAD DEL SERVICIO" Text="<%$Resources:multi.language,reportes_vds%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE TRANSACCIONES TICKETS" Text="<%$Resources:multi.language,reportes_transticket%>"></asp:ListItem>
                                <%--<asp:ListItem Value="REPORTE PRODUCTIVIDAD">Reporte de productividad</asp:ListItem>--%>
                                <asp:ListItem Value="REPORTE PRODUCTOS" Text="<%$Resources:multi.language,reportes_productos%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE VentasProduct" Text="<%$Resources:multi.language,reportes_productosmasvenddos%>"></asp:ListItem>
                                <asp:ListItem Value="REPORTE VentasProductCat" Text="Productos más vendidos por categoría"></asp:ListItem>
                                <asp:ListItem Value="REPORTE vdsconsolidado" Text="Consolidado Tiempo de servicio"></asp:ListItem>
                                <asp:ListItem Value="REPORTE vds2" Text="Velocidad de servicio II"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>                
                </div>

                
            </div>
                        
            <br />

        </div>

        
        <!-- Page Content -->
        <div class="" ID="Reporte1" runat="server" style="height:600px">

            <rsweb:ReportViewer CssClass="ReportViewer1" ID="ReportViewer1" runat="server" BackColor="White" ClientIDMode="AutoID" HighlightBackgroundColor="#66CCFF" 
                InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor=""
                LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor=""
                PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" 
                SecondaryButtonHoverBackgroundColor="#0000CC" SecondaryButtonHoverForegroundColor="" ToolbarDividerColor="#6DB23F" 
                ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="#0000CC" ToolbarHoverForegroundColor="" 
                ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" 
                ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" 
                ToolBarItemPressedHoverBackColor="153, 187, 226" Width="100%" Height="100%" ZoomMode="Percent" BorderStyle="Solid" 
                BorderColor="#6DB23F" ShowDocumentMapButton="True" WaitControlDisplayAfter="9000000" ShowPromptAreaButton="True" AsyncRendering="False"
                KeepSessionAlive="True" ExportContentDisposition="OnlyHtmlInline" EnableViewState="True" EnableTheming="False" ShowPageNavigationControls="True" 
                ShowFindControls="False" SizeToReportContent="False" ShowWaitControlCancelLink="False" DocumentMapCollapsed="False" DocumentMapWidth="25%" 
                InteractivityPostBackMode="AlwaysSynchronous" ValidateRequestMode="Inherit" ViewStateMode="Inherit" PromptAreaCollapsed="True" PageCountMode="Estimate" 
                SplitterBackColor="Lime">            
            </rsweb:ReportViewer>
                        
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="DataSetReporteDiarioTableAdapters.hcjaTableAdapter"></asp:ObjectDataSource>
                      
        </div>
        
        <br />

    </ContentTemplate>
    <triggers>
        <asp:asyncpostbacktrigger controlid="DropDownList1" eventname="SelectedIndexChanged" />          
    </triggers>
    </asp:UpdatePanel>
    </div>    
        
    </div>

     <!-- MODAL MENSAJE POPUP-->
    <div id="MyPopup" class="modal fade" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header modal-header-danger" style="justify-content:center; background-color: darkorange; height: 30px;">   
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding-top: 0; color: white; font-size: 20px">
 
                        </button>
                </div>

                <div class="modal-body">
                    <h4><Label>INGRESE LA INFORMACION SOLICITADA</Label></h4>
                    <Label>Por favor ingrese la fecha y seleccione una tienda</Label>
                    <br />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Popup -->
    <script type="text/javascript">
        function MensajePop() {
            $("#MyPopup").modal("show");
        }
    </script>

    
    <script type="text/javascript">
        $(document).ready(function() {
        $('#thisOne').sortable({
            revert:true
        });

        });
    </script>

    <script type="text/javascript">
        function showProgress() {
        var updateProgress = $get("<%= UpdateProgress.ClientID %>");
        updateProgress.style.display = "block";
        }
    </script>

    <script type="text/javascript">
         function resizeViewer()
        {
            <%=ReportViewer1.ClientID %>.AdjustReportAreaHeight();
        }
    </script>

</asp:Content>