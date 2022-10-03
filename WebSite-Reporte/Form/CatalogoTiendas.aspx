<%@ Page Language="C#" Debug="true" MasterPageFile="~/Form/MasterPage.master" AutoEventWireup="true" CodeFile="CatalogoTiendas.aspx.cs" Inherits="CatalogoTiendas" %>

<asp:Content ID="Content4" ContentPlaceHolderID="Content4" runat="Server">
    <link href="css/CatalogoTiend.css" rel="stylesheet" />
    <script src="js/jquery.blockUI.js"></script>
    <link href="css/StyleReporteDiario.css" rel="stylesheet" />
    <script type="text/javascript">
        function Funcion() {
            alert("Existen campos vacíos, por favor ingrese la información requerida")
        }
    </script>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        table
        {

            border-collapse: collapse;
            background-color: #fff;
        }
        table th
        {
            background-color: #6DB23F;
            color: #fff;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            text-decoration: none;

        }
        table, table table td
        {
            border: 0px solid #6DB23F;
            font-size: small;
        }

        .GridView1{
            text-decoration: none;
        }
    </style>
        
    <div style="display: none">
        <asp:HyperLink ID="hlEnglish1" NavigateUrl="?lang=en" runat="server" Text="<%$Resources:multi.language, lang%>" />
        <asp:HyperLink ID="hlSpanish1" NavigateUrl="?lang=es" runat="server" Text="<%$Resources:multi.language, lang%>" />
    </div>
    <div class="container-fluid">

    <div style="padding-top: 25px; padding-bottom: 25px">
        <div class="grisFuerte ffGalaxie titulo" style="float: left; padding-top: 10px">
            <label class="TituloCatalogo">Catálogo de tiendas</label>
            </div>
            <a href="Dashboard.aspx">
            <img src="img/Logo.png" class="img-fluid imgLgo" alt="" style="height: 43px; float: right" /></a>
        <div style="clear: both"></div>
    </div>

    <div class="container-fluid" style="border: 1px solid #6DB23F; padding-top: 30px; height: 300px; border-radius: 5px 6px;">
    <div class="container-fluid" id="dvGrid" style="width: 100%; height: 250px; overflow: scroll">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView CssClass="GridView1" ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDataBound="OnRowDataBound"
                    DataKeyNames="id_local" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" PageSize = "20" AllowPaging ="True" OnPageIndexChanging = "OnPaging"
                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="Sin resultados" BorderStyle="None" GridLines="None"
                    HeaderStyle-CssClass="headerStyle" RowStyle-CssClass="rowsStyle" PagerStyle-CssClass="pagerStyle" Width="100%">
                    <Columns>

                        <asp:TemplateField HeaderText="ID" ItemStyle-Width="50" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("id_local") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="50px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-CssClass="TiendaStyle"  HeaderText="Tienda" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblTienda0" runat="server" Text='<%# Eval("TIENDA") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="150px" />
                            <ItemStyle Width="150px" />

                        </asp:TemplateField>


                        <asp:TemplateField  ItemStyle-CssClass="UbicacionStyle" HeaderText="Ubicación" ItemStyle-Width="100px" >
                            <ItemTemplate>
                                <asp:Label ID="lblUbicacion" runat="server" Text='<%# Eval("UBICACION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="TextBoxEdit" ID="txtUbicacion0" runat="server" Text='<%# Eval("UBICACION") %>' Width="400"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="450px" />
                        </asp:TemplateField>


                        <asp:TemplateField ItemStyle-CssClass="LatStyle"  HeaderText="Latitud" ItemStyle-Width="150" ItemStyle-Wrap="False">
                            <ItemTemplate>
                                <asp:Label ID="lblLat" runat="server" Text='<%# Eval("LATITUD") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="TextBoxEdit" ID="txtLat0" runat="server" Text='<%# Eval("LATITUD") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="150px" />
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-CssClass="LongStyle"  HeaderText="Longitud" ItemStyle-Width="150" ItemStyle-Wrap="False">
                            <ItemTemplate>
                                <asp:Label ID="lblLong" runat="server" Text='<%# Eval("LONGITUD") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="TextBoxEdit" ID="txtLong0" runat="server" Text='<%# Eval("LONGITUD") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="150px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ESTADO" ItemStyle-Width="150" ItemStyle-Wrap="False" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("ESTADO") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox CssClass="TextBoxEdit" ID="txtEstado0" runat="server" Text='<%# Eval("ESTADO") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle Width="150px" />
                        </asp:TemplateField>

                        <asp:CommandField ShowEditButton="true" ShowDeleteButton="true"
                            ItemStyle-Width="50" ControlStyle-CssClass="ItemsGrid" DeleteText="ELIMINAR" EditText="EDITAR" HeaderText="Acción" CancelText="CANCELAR" UpdateText="ACTUALIZAR">
                        <ControlStyle CssClass="ItemsGrid" />
                        <ItemStyle Width="50px" Font-Overline="False" Font-Underline="False" />
                        </asp:CommandField>
                    </Columns>
                    <HeaderStyle BorderColor="White" />
                    <PagerStyle CssClass="GridView|" />
                    <RowStyle CssClass="rowsStyle" />
                    <SelectedRowStyle BackColor="#99FF66" ForeColor="#6DB23F" />
                </asp:GridView>
                <!--<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse; width: 100%">
                    <tr>
                        <td >
                            ID:<br />
                            <asp:TextBox ID="txtId" runat="server" Width="150" />
                        </td>
                        <td >
                            UBICACION:<br />
                            <asp:TextBox ID="txtUbicacion" runat="server" Width="150" />
                        </td>
                        <td>
                            LATITUD:<br />
                            <asp:TextBox ID="txtLat" runat="server" Width="150" />
                        </td>
                        <td>
                            LONGITUD:<br />
                            <asp:TextBox ID="txtLng" runat="server" Width="150" />
                        </td>
                        <td >
                            ESTADO:<br />
                            <asp:TextBox ID="txtEstado" runat="server" Width="150" />
                        </td>
                        <td style="text-align: center">
                            <asp:Button ID="btnAdd" CssClass="btn btn-success" runat="server" Text="Agregar" Width="150px"/>
                        </td>
                    </tr>
                </table>-->
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </div>
    </div>

    <script type="text/javascript">
            $(function () {
                BlockUI("dvGrid");
                $.blockUI.defaults.css = {};
            });
            function BlockUI(elementID) {
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_beginRequest(function () {
                    $("#" + elementID).block({
                        message: '<div align = "center">' + '<img src="ImgPcks/Marcador_Google_selección.png" /></div>',
                        css: {},
                        overlayCSS: { backgroundColor: '#000000', opacity: 0.6, border: '3px solid #6DB23F', color: '#6DB23F' }
                    });
                });
                prm.add_endRequest(function () {
                    $("#" + elementID).unblock();
                });
            };
    </script>

</asp:Content>