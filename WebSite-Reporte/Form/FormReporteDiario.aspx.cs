using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using System.Drawing;
using System.Globalization;
using System.IO;

public partial class Form_FormReporteDiario : BasePage
{
    AbrirConexion conexion = new AbrirConexion();

    int valor = 0;
    string fechaRecibida;
    string fechaRecibida2;
    string RecibirNombreTienda;
    int idlocal;
    string prefijo = "ctl00$Content3$";
    string valoranterior = DateTime.Now.ToShortDateString();
    string valoranterior2 = DateTime.Now.ToShortDateString();

    protected void Page_Load(object sender, EventArgs e)
    {
        string ID = (string)(Session["ID"]);
        SqlDataSource1.SelectParameters.Add("IdUsuario", DbType.Int32, ID);

        SelectTipoTienda.Items.Clear();
        SelectTipoTienda.Items.Add( "TODAS" );
        string rol = (String)(Session["Rol"]);
        if (rol == "superusuario")
        {
            SelectTipoTienda.DataSourceID = "SqlDataSource2";
            var items = SelectTipoTienda.Items;
        }
        else
        {
            SelectTipoTienda.DataSourceID = "SqlDataSource1";
        }


        if (!IsPostBack)
        {
            date.Value = valoranterior;
            date2.Value = valoranterior2;
        }
        else
        {
            // Is a post back
        }

        if (Session["SesionCorreo"] != null && Session["SesionContraseña"] != null)
        {
            if (string.IsNullOrEmpty(Convert.ToString(Session["lang"])))
            {
                hlEnglish1.Visible = true;
                hlSpanish1.Visible = false;
            }
            else
            {
                string lang = Session["lang"].ToString();

                if (lang.Equals("en"))
                {
                    SelectTipoTienda.Items.Clear();
                    SelectTipoTienda.Items.Add("ALL");
                    hlEnglish1.Visible = false;
                    hlSpanish1.Visible = true;
                }
                else
                {
                    hlEnglish1.Visible = true;
                    hlSpanish1.Visible = false;
                }
            }
        }
        else
        {
           Response.Redirect("../Index.aspx");
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList1.SelectedValue = DropDownList1.SelectedItem.Value;
        string valor = DropDownList1.SelectedItem.Value.ToString();
        if (date.Value != "" && date2.Value != "")
        {
            if (valor == "REPORTE DIARIO") //26-04
            {
                /*if (SelectTipoTienda.Text == "TODAS" || SelectTipoTienda.Text == "ALL")
                {*/
                    System.Threading.Thread.Sleep(5000);
                    GenerarReportePorTiendaYFecha();
                    DropDownList1.SelectedIndex = 0;
                    date.Value = valoranterior;
                    date2.Value = valoranterior2;
                /*}
                else
                {
                    System.Threading.Thread.Sleep(5000);
                    GenerarReportePorTiendaYFecha();
                    DropDownList1.SelectedIndex = 0;
                    date.Value = valoranterior;
                    date2.Value = valoranterior2;
                }*/
            }
            else if (valor == "REPORTE POR HORA")//26-04
            {
                System.Threading.Thread.Sleep(5000);
                GenerarReportePorHoraYFecha();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
                date2.Value = valoranterior2;

            }
            else if (valor == "REPORTE PMIX")//26-04
            {
                System.Threading.Thread.Sleep(5000);
                GenerarReportePMIXHoraYFecha2();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
                date2.Value = valoranterior2;
                

            }
            else if (valor == "REPORTE TRANSACCIONES")//26-04
            {
                System.Threading.Thread.Sleep(5000);
                GenerarReporteTransacciones();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
                date2.Value = valoranterior2;
            }
            else if (valor == "REPORTE VELOCIDAD DEL SERVICIO")//26-04
            {
             
                System.Threading.Thread.Sleep(5000);
                GenerarVDS();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
            }
            else if (valor == "REPORTE TRANSACCIONES TICKETS") //26-04
            {
                if (SelectTipoTienda.Text == "TODAS" || SelectTipoTienda.Text == "ALL")
                {
                    System.Threading.Thread.Sleep(5000);
                    GenerarReporteTransaccionesTicketsTodas();
                    DropDownList1.SelectedIndex = 0;
                }
                else
                {
                    System.Threading.Thread.Sleep(5000);
                    GenerarReporteTransaccionesTickets();
                    DropDownList1.SelectedIndex = 0;
                }

            }
            else if (valor == "REPORTE PRODUCTIVIDAD")
            {
                if (SelectTipoTienda.Text == "TODAS" || SelectTipoTienda.Text == "ALL")
                {
                    System.Threading.Thread.Sleep(5000);
                    GenerarReporteProductividadTodas();
                    DropDownList1.SelectedIndex = 0;
                    date.Value = valoranterior;
                }
                else
                {
                    System.Threading.Thread.Sleep(5000);
                    GenerarReporteProductividad();
                    DropDownList1.SelectedIndex = 0;
                    date.Value = valoranterior;
                }

            }
            else if (valor == "REPORTE PRODUCTOS")
            {
                    System.Threading.Thread.Sleep(5000);
                    GenerarReporteProductos();
                    DropDownList1.SelectedIndex = 0;
                    date.Value = valoranterior;

            }

            else if (valor == "REPORTE VentasProduct")
            {
                System.Threading.Thread.Sleep(5000);
                GenerarReporteProductosVendidos();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
            }
            else if (valor == "REPORTE VentasProductCat")
            {
                System.Threading.Thread.Sleep(5000);
                GenerarReporteProductosVendidosCat();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
            }
            else if (valor == "REPORTE vdsconsolidado")
            {
                System.Threading.Thread.Sleep(5000);
                GenerarReporteVdsConsolidado();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
            }
            else if (valor == "REPORTE vds2")
            {
                System.Threading.Thread.Sleep(5000);
                GeerarReporteVelocidadDelServicio();
                DropDownList1.SelectedIndex = 0;
                date.Value = valoranterior;
            }
        }
        else
        {
            MensajeAlert.Text = "<div  class='alert AnimacionMensajeAlert' role='alert' style='text-align: center; background-color: #939393; color: white'>" + "INGRESE TODOS LOS DATOS SOLICITADOS" + "</div>";
        }
    }


    public void GenerarReportediario_Click(object sender, EventArgs e)
    {

        

    }


    public void ObtenerId(string nombre)
    {
        conexion.Conectar();
        conexion.comando = new SqlCommand("select id_local from mlocal where nombre = '" + nombre + "'", conexion.miconexion);
        conexion.reader = conexion.comando.ExecuteReader();

        if (conexion.reader.Read())
        {
            idlocal = (Int32)conexion.reader["id_local"];

            conexion.reader.Close();
            conexion.comando.Dispose();
            conexion.Desconectar();
        }
    }
    public int ObtenerId_v2(string nombre)
    {
        int id = 0;
        try
        {
            if (nombre != "TODAS")
            {
                conexion.Conectar();
                conexion.comando = new SqlCommand("select id_local from mlocal where nombre = '" + nombre + "'", conexion.miconexion);
                conexion.reader = conexion.comando.ExecuteReader();

                if (conexion.reader.Read())
                {
                    idlocal = (Int32)conexion.reader["id_local"];

                    conexion.reader.Close();
                    conexion.comando.Dispose();
                    conexion.Desconectar();
                }
            }
        }
        catch (Exception ex) { return id; }
        return id;
    }
    //GENERAR REPORTE VELOCIDAD DEL SERVICIO
    public void GeerarReporteVelocidadDelServicio()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/Vds2.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];

        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);


        ReportParameter PrTipoTienda = new ReportParameter("tienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        ReportParameter fecha2 = new ReportParameter("fecha2");
        fecha2.Values.Add(fechaRecibida2);
        this.ReportViewer1.LocalReport.SetParameters(fecha2);
        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("Vds2TableAdapters.vdsIITableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }


    public void GenerarReporteVdsConsolidado()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/VdsIndicadores.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];
        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);
        
        ReportParameter PrTipoTienda = new ReportParameter("tienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("VdsIndicadorTableAdapters.vdsIndicadoresTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.PageCountMode = PageCountMode.Actual;
    }
    public void GenerarReporteProductosVendidosCat()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ProductoCategoria.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];
        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PrmInvoiceNo2 = new ReportParameter("fecha2");
        PrmInvoiceNo2.Values.Add(fechaRecibida2);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo2);
        ReportParameter PrTipoTienda = new ReportParameter("tienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("ProductosCategoriasTableAdapters.productocategoriaTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.PageCountMode = PageCountMode.Actual;
    }
    public void GenerarReporteProductosVendidos()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ProductosMasVendidos.rdlc";
        
        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];
        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PrmInvoiceNo2 = new ReportParameter("fecha2");
        PrmInvoiceNo2.Values.Add(fechaRecibida2);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo2);
        ReportParameter PrTipoTienda = new ReportParameter("tienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("MasVendidosTableAdapters.productomasvendidoTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.PageCountMode = PageCountMode.Actual;
    }
    public void GenerarVDS()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/VDSPro.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];
        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PrTipoTienda = new ReportParameter("tienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);
        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("VDSProTableAdapters.vdsTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }
    public void GenerarReporteProductos()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ProductosVentas.rdlc";
        string lang = Session["lang"].ToString();
        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];
        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PrTipoTienda = new ReportParameter("tienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("VentasProductosTableAdapters.hctaordTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("id", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }

    public void GenerarReportePorTiendaYFecha()
    {
        try
        {
            //Reporte1.Style.Add("height", "300px");

            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport localReport = ReportViewer1.LocalReport;
            localReport.ReportPath = "Reportes/ReporteDiario.rdlc";

            //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
            string ID = (string)(Session["ID"]);
            string fechaRecibida = Request[prefijo + "date"];
            valoranterior = fechaRecibida;
            string fechaRecibida2 = Request[prefijo + "date2"];
            valoranterior2 = fechaRecibida2;
            string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
            ObtenerId(RecibirNombreTienda);
            int IdObtenido = idlocal;

            //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
            ReportParameter PrmInvoiceNo = new ReportParameter("ReportParameterFecha");
            PrmInvoiceNo.Values.Add(fechaRecibida);
            this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

            ReportParameter PrTipoTienda = new ReportParameter("ReportParameterTienda");
            PrTipoTienda.Values.Add(RecibirNombreTienda);
            this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

            string lang = Session["lang"].ToString();
            ReportParameter Idioma = new ReportParameter("idioma");
            Idioma.Values.Add(lang);
            this.ReportViewer1.LocalReport.SetParameters(Idioma);

            //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
            ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetReporteDiarioTableAdapters.hcjaTableAdapter", "GetDataBy");
            ObjectDataSource1.SelectParameters.Add("apertura", TypeCode.DateTime, fechaRecibida);
            ObjectDataSource1.SelectParameters.Add("id", IdObtenido.ToString());
            ObjectDataSource1.SelectParameters.Add("idUsuario", ID);
            Microsoft.Reporting.WebForms.ReportDataSource rds =
            new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.ZoomMode = ZoomMode.PageWidth;
            ReportViewer1.LocalReport.Refresh();

        }
        catch (Exception ex) { }
    }
    
    private void GenerarReporteTodasLasTiendasYFecha()
    {
        //Reporte1.Style.Add("height", "2080px");

        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteDiario.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;

        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("ReportParameterFecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PrTipoTienda = new ReportParameter("ReportParameterTienda");
        PrTipoTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetReporteDiarioTableAdapters.hcjaTableAdapter", "GetData");
        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = Microsoft.Reporting.WebForms.ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }

    //GENERAR REPORTE POR HORA Y FECHA
    private void GenerarReportePorHoraYFecha() //======================================================================reporte por hora productivo
    {
        try
        {
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport localReport = ReportViewer1.LocalReport;
            localReport.ReportPath = "Reportes/ReportePH.rdlc";
            string lang = Session["lang"].ToString();
            //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
            string ID = (string)(Session["ID"]);
            string fechaRecibida = Request[prefijo + "date"];
            valoranterior = fechaRecibida;
            string fechaRecibida2 = Request[prefijo + "date2"];
            valoranterior2 = fechaRecibida2;
            string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
            string[] fec = fechaRecibida.Split('/');
            string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];
            string[] fec2 = fechaRecibida2.Split('/');
            string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];
            ObtenerId(RecibirNombreTienda);
            int IdObtenido = idlocal;

            //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
            ReportParameter PrmInvoiceNo = new ReportParameter("ParametroFecha");
            PrmInvoiceNo.Values.Add(fechaRecibida);
            this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

            ReportParameter PrTipoTienda = new ReportParameter("ParametroTienda");
            PrTipoTienda.Values.Add(RecibirNombreTienda);
            this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

            ReportParameter PrTipoTienda2 = new ReportParameter("ReportFecha");
            PrTipoTienda.Values.Add(fechaRecibida);
            this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda2);

            ReportParameter Idioma = new ReportParameter("idioma");
            Idioma.Values.Add(lang);
            this.ReportViewer1.LocalReport.SetParameters(Idioma);

            string a = Convert.ToDateTime(fechaRecibida).ToString("yyyy-MM-dd");
            //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
            ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetReportePHTableAdapters.spTableAdapter", "GetData");
            ObjectDataSource1.SelectParameters.Add("fecha", f1);
            ObjectDataSource1.SelectParameters.Add("fecha2", f2);
            ObjectDataSource1.SelectParameters.Add("idSucursal", IdObtenido.ToString());
            ObjectDataSource1.SelectParameters.Add("idUsuario", ID);
            Microsoft.Reporting.WebForms.ReportDataSource rds =
            new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.ZoomMode = ZoomMode.PageWidth;
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception e) { }
    }
      ////<TERMINA PROCEDIMIENTO>///////
     //////////////////////////////////
    ////</TERMINA PROCEDIMIENTO>//////


    //GENERAR REPORTE PMIX POR HORA Y FECHA
    public void GenerarReportePMIXHoraYFecha()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReportePMix.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetPMIXTableAdapters.reporteVentas51TableAdapter", "GetData");
        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }

    //GENERAR REPORTE PMIX POR HORA Y FECHA (CON PARAMETROS)
    public void GenerarReportePMIXHoraYFecha2()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReportePMIX2dlc.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        string[] fec = fechaRecibida.Split('/');
        string f1 = fec[2] + "-" + fec[1] + "-" + fec[0];

        string[] fec2 = fechaRecibida2.Split('/');
        string f2 = fec2[2] + "-" + fec2[1] + "-" + fec2[0];

        ReportParameter PrmInvoiceNo = new ReportParameter("fechaRecibida");
        PrmInvoiceNo.Values.Add(fechaRecibida );
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PTienda = new ReportParameter("tienda");
        PTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetReportePMIX2TableAdapters.ReporteVentas05TableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, f1);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, f2);
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);
        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }
    ////<TERMINA PROCEDIMIENTO>///////
    //////////////////////////////////
    ////</TERMINA PROCEDIMIENTO>//////
    

    //GENERAR REPORTE TRANSACCIONES TODAS Y (CON PARAMETROS)
    public void GenerarReporteTransacciones()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteTransacciones.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;

        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PTienda = new ReportParameter("tienda");
        PTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetTransaccionesTableAdapters.reporteVentasTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime , fechaRecibida);
        ObjectDataSource1.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        ObjectDataSource ObjectDataSource2 = new ObjectDataSource("DataSetTransaccionesTableAdapters.reporteVentas2TableAdapter", "GetData");
        ObjectDataSource2.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource2.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource2.SelectParameters.Add("idUsuario", ID);

        ObjectDataSource ObjectDataSource3 = new ObjectDataSource("DataSetTransaccionesTableAdapters.reporteVentas3TableAdapter", "GetData");
        ObjectDataSource3.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource3.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource3.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);
        Microsoft.Reporting.WebForms.ReportDataSource rds2 =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ObjectDataSource2);
        Microsoft.Reporting.WebForms.ReportDataSource rds3 =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet3", ObjectDataSource3);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.DataSources.Add(rds2);
        ReportViewer1.LocalReport.DataSources.Add(rds3);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.Height = Unit.Percentage(100);
        ReportViewer1.LocalReport.Refresh();
    }
      ////<TERMINA PROCEDIMIENTO>///////
     //////////////////////////////////
    ////</TERMINA PROCEDIMIENTO>//////

    
    
    //GENERAR REPORTE VELOCIDAD DEL SERVICIO (CON PARAMETROS)
    private void GeerarReporteVelocidadDelServicio2()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteVDS.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        int hf = 11;

        //LLAMO AL PARAMETRO Y LE PASO EL VALOR SOLICITADO
        ReportParameter PrmInvoiceNo = new ReportParameter("PFechaInicial");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PFechaFinal = new ReportParameter("PFechaFinal");
        PFechaFinal.Values.Add(fechaRecibida2);
        this.ReportViewer1.LocalReport.SetParameters(PFechaFinal);

        ReportParameter PId = new ReportParameter("PID");
        PId.Values.Add(IdObtenido.ToString());
        this.ReportViewer1.LocalReport.SetParameters(PId);

        ReportParameter PTienda = new ReportParameter("ParametroTienda");
        PTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PTienda);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY

        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetReporteVDSTableAdapters.mlocalTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("idSucursal", 0.ToString());
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource1.SelectParameters.Add("fechaFinal", TypeCode.DateTime, fechaRecibida2);
        //ObjectDataSource1.SelectParameters.Add("hf", hf.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);
        //ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetReporteVDSTableAdapters.mlocalTableAdapter", "GetDataBy");
        //ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime ,fechaRecibida);
        //ObjectDataSource1.SelectParameters.Add("fechaFinal", TypeCode.DateTime , fechaRecibida2);
        //ObjectDataSource1.SelectParameters.Add("hf", hf.ToString());
        //ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }
      ////<TERMINA PROCEDIMIENTO>///////
     //////////////////////////////////
    ////</TERMINA PROCEDIMIENTO>//////


    public void GenerarReporteTransaccionesTickets()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteTransaccionesTickets.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetTransaccionesTicketsTableAdapters.reporteVentas4TableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, fechaRecibida2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }

    public void GenerarReporteTransaccionesTicketsTodas()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteTransaccionesTickets.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string fechaRecibida2 = Request[prefijo + "date2"];
        valoranterior2 = fechaRecibida2;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;
        ReportParameter PrmInvoiceNo = new ReportParameter("fecha");
        PrmInvoiceNo.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrmInvoiceNo);

        ReportParameter PTienda = new ReportParameter("tienda");
        PTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PTienda);

        string lang = Session["lang"].ToString();
        ReportParameter Idioma = new ReportParameter("idioma");
        Idioma.Values.Add(lang);
        this.ReportViewer1.LocalReport.SetParameters(Idioma);
        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetTransaccionesTicketsTableAdapters.reporteVentas4TodasTableAdapter", "GetData");
        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource1.SelectParameters.Add("fecha2", TypeCode.DateTime, fechaRecibida2);
        ObjectDataSource1.SelectParameters.Add("idSucursal", TypeCode.Int32, IdObtenido.ToString());

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();
    }

    public void GenerarReporteProductividad()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteProductividad.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];
        ObtenerId(RecibirNombreTienda);
        int IdObtenido = idlocal;

        //LE MANDO VALOR A LOS PARAMETROS
        ReportParameter PrTipoTienda = new ReportParameter("ReportParametroFecha");
        PrTipoTienda.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        ReportParameter PrNombreTienda = new ReportParameter("ReportParametroTienda");
        PrNombreTienda.Values.Add(RecibirNombreTienda.ToString());
        this.ReportViewer1.LocalReport.SetParameters(PrNombreTienda);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetProductividadTableAdapters.DataTable1TableAdapter", "GetData");
        ObjectDataSource ObjectDataSource2 = new ObjectDataSource("DataSetProductividadTableAdapters.DataTable2TableAdapter", "GetData");
        ObjectDataSource ObjectDataSource3 = new ObjectDataSource("DataSetProductividadTableAdapters.DataTable3TableAdapter", "GetData");

        ObjectDataSource1.SelectParameters.Add("Fecha",TypeCode.DateTime ,fechaRecibida);
        ObjectDataSource1.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        ObjectDataSource2.SelectParameters.Add("Fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource2.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource2.SelectParameters.Add("idUsuario", ID);

        ObjectDataSource3.SelectParameters.Add("Fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource3.SelectParameters.Add("idSucursal", IdObtenido.ToString());
        ObjectDataSource3.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);
        Microsoft.Reporting.WebForms.ReportDataSource rds2 =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ObjectDataSource2);
        Microsoft.Reporting.WebForms.ReportDataSource rds3 =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet3", ObjectDataSource3);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.DataSources.Add(rds2);
        ReportViewer1.LocalReport.DataSources.Add(rds3);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();

    }

    public void GenerarReporteProductividadTodas()
    {
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        LocalReport localReport = ReportViewer1.LocalReport;
        localReport.ReportPath = "Reportes/ReporteProductividadTodas.rdlc";

        //OBTENEMOS EL VALOR DE LOS CONTROLES HTML
        string ID = (string)(Session["ID"]);
        string fechaRecibida = Request[prefijo + "date"];
        valoranterior = fechaRecibida;
        string RecibirNombreTienda = Request[prefijo + "SelectTipoTienda"];

        //LE MANDO VALOR A LOS PARAMETROS
        ReportParameter PrTipoTienda = new ReportParameter("ReportParametroFecha");
        PrTipoTienda.Values.Add(fechaRecibida);
        this.ReportViewer1.LocalReport.SetParameters(PrTipoTienda);

        ReportParameter PrNombreTienda = new ReportParameter("ReportParametroTienda");
        PrNombreTienda.Values.Add(RecibirNombreTienda);
        this.ReportViewer1.LocalReport.SetParameters(PrNombreTienda);

        //PASAMOS EL VALOR QUE QUERAMOS AL PARAMETRO QUE PIDE EL DATATABLE, POR METODO GETDATABY
        ObjectDataSource ObjectDataSource1 = new ObjectDataSource("DataSetProductividadTodasTableAdapters.productividadTableAdapter", "GetData");
        ObjectDataSource ObjectDataSource2 = new ObjectDataSource("DataSetProductividadTodasTableAdapters.productividad2TableAdapter", "GetData");
        ObjectDataSource ObjectDataSource3 = new ObjectDataSource("DataSetProductividadTodasTableAdapters.productividad3TableAdapter", "GetData");

        ObjectDataSource1.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource1.SelectParameters.Add("idSucursal", null);
        ObjectDataSource1.SelectParameters.Add("idUsuario", ID);

        ObjectDataSource2.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource2.SelectParameters.Add("idSucursal", null);
        ObjectDataSource2.SelectParameters.Add("idUsuario", ID);

        ObjectDataSource3.SelectParameters.Add("fecha", TypeCode.DateTime, fechaRecibida);
        ObjectDataSource3.SelectParameters.Add("idSucursal", null);
        ObjectDataSource3.SelectParameters.Add("idUsuario", ID);

        Microsoft.Reporting.WebForms.ReportDataSource rds =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ObjectDataSource1);
        Microsoft.Reporting.WebForms.ReportDataSource rds2 =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ObjectDataSource2);
        Microsoft.Reporting.WebForms.ReportDataSource rds3 =
        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet3", ObjectDataSource3);

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.DataSources.Add(rds2);
        ReportViewer1.LocalReport.DataSources.Add(rds3);
        ReportViewer1.ZoomMode = ZoomMode.PageWidth;
        ReportViewer1.LocalReport.Refresh();

    }

    
    //BOTON QUE PERMITE FINALIZAR SESION 
    public void CerrarSesion_Click(object sender, EventArgs e)
    {
        //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowModal();", true);
        RemoverSesion();
    }

    //METODO QUE PERMITE REMOVER LA SESION
    public void RemoverSesion()
    {
        Session.Remove("Correo");
        Response.Redirect("index.aspx");
    }
}