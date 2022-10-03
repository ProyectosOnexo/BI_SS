using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_AdministrarCuentas : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["nombre"] != null)
        {
            if (string.IsNullOrEmpty(Convert.ToString(Session["lang"])))
            {
                hlEnglish.Visible = true;
                hlSpanish.Visible = false;
            }
            else
            {
                string lang = Session["lang"].ToString();

                if (lang.Equals("en"))
                {
                    hlEnglish.Visible = false;
                    hlSpanish.Visible = true;
                }
                else
                {
                    hlEnglish.Visible = true;
                    hlSpanish.Visible = false;
                }
            }
        }
        else
        {
            Response.Redirect("../Index.aspx");
        }
    }
    [System.Web.Services.WebMethod]
    public static string GuardarSucursales(int usuario,string sucursales)
    {
        string res = "";
        try {
            string[] suc = sucursales.Trim(',').Split(',');
            Conexion conexion = new Conexion();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 8);
            command.Parameters.AddWithValue("@id", usuario);
            command.Connection.Open();
            int res2 = command.ExecuteNonQuery();
            command.Connection.Close();
                foreach (var item in suc)
                {
                    command = new SqlCommand("sp_solicitudes", conexion.Conection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@consulta", 9);
                    command.Parameters.AddWithValue("@id", usuario);
                    command.Parameters.AddWithValue("@id_local", item);
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    res = "Guardado correctamente";
                    command.Connection.Close();
                }
        }catch(Exception ex)
        {
            return ex.Message.ToString();
        }
        return res;
    }
    [System.Web.Services.WebMethod]
    public static List<Sucursal> ConsultaSucursales(int usuario)
    {
        List<Sucursal> lista = new List<Sucursal>();
        Sucursal sucursal;
        Conexion conexion = new Conexion();
        try
        {
            DataTable table = new DataTable();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 18);
            command.Parameters.AddWithValue("@id", usuario);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                sucursal = new Sucursal();
                sucursal.Nombre = row["nombre"].ToString();
                sucursal.Id_local =Convert.ToInt32( row["id_local"]);
                sucursal.Estado = Convert.ToInt32(row["estado"]) == 1 ? true : false;
                lista.Add(sucursal);
            }
        }
        catch (Exception ex)
        {
            return lista;
        }

        return lista;
    }
    [System.Web.Services.WebMethod]
    public static Res ConsultaDashboardNuevo(string f1, string f2, string tienda)
    {
            Res res = new Res();
            Form_AdministrarCuentas form = new Form_AdministrarCuentas();
        try
        {
            Conexion conexion = new Conexion();
            int idlocal = form.ObtenerId(tienda);
            DataSet table = new DataSet();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);

            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyyMMdd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyyMMdd");
            string ID = (string)(form.Session["ID"]);


            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 1);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.Parameters.AddWithValue("@idusuario", ID);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            GraficaHoras graficaHoras;
            List<GraficaHoras> listGraficaH = new List<GraficaHoras>();

            foreach (DataRow row in table.Tables[0].Rows)
            {
                graficaHoras = new GraficaHoras();
                graficaHoras.Descripcion = row["descripcion"].ToString();
                graficaHoras.Registros = Convert.ToInt32(row["registros"]);
                graficaHoras.Contador = Convert.ToInt32(row["contador"]);
                listGraficaH.Add(graficaHoras);
            }
            res.ListGaficaH = listGraficaH;

            TablaH tablaH;
            List<TablaH> listTablaH = new List<TablaH>();

            foreach (DataRow row in table.Tables[1].Rows)
            {
                tablaH = new TablaH();
                //tablaH.Id = Convert.ToInt32(row["id"]);
                tablaH.Descripcion = row["Descripcion"].ToString();
                tablaH.Total = Convert.ToDecimal(row["Total"]);
                tablaH.Desayunos = Convert.ToDecimal(row["Desayunos"]);
                tablaH.PDesayunos = Convert.ToDecimal(row["PDes"]);
                tablaH.Comidas = Convert.ToDecimal(row["Comidas"]);
                tablaH.PComidas = Convert.ToDecimal(row["PCom"]);
                tablaH.Cenas = Convert.ToDecimal(row["Cenas"]);
                tablaH.PCenas = Convert.ToDecimal(row["PCen"]);
                listTablaH.Add(tablaH);
            }
            res.ListVentasH = listTablaH;
            //cancelaciones
            GraficaC graficaC;
            List<GraficaC> listGraficaC = new List<GraficaC>();

            foreach (DataRow row in table.Tables[2].Rows)
            {
                graficaC = new GraficaC();
                graficaC.Descripcion = row["descripcion"].ToString();
                graficaC.Registros = Convert.ToInt32(row["ticket"]);
                //graficaC.Contador = Convert.ToInt32(row["porcentaje"]);
                listGraficaC.Add(graficaC);
            }
            res.ListGaficaC = listGraficaC;

            TablaC tablaC;
            List<TablaC> listTablaC = new List<TablaC>();

            foreach (DataRow row in table.Tables[3].Rows)
            {
                tablaC = new TablaC();
                tablaC.Descripcion = row["Descripcion"].ToString();
                tablaC.Monto = Convert.ToDecimal(row["monto"]);
                tablaC.VReal = Convert.ToDecimal(row["vreal"]);
                tablaC.PMonto = Convert.ToDecimal(row["pmonto"]);
                tablaC.Porciones = Convert.ToDecimal(row["porciones"]);
                tablaC.PorcionesReales = Convert.ToDecimal(row["preal"]);
                tablaC.PPorciones = Convert.ToDecimal(row["pporciones"]);
                listTablaC.Add(tablaC);
            }
            res.ListVentasC = listTablaC;
            //descuentos
            GraficaD graficaD;
            List<GraficaD> listGraficaD = new List<GraficaD>();

            foreach (DataRow row in table.Tables[4].Rows)
            {
                graficaD = new GraficaD();
                graficaD.Descripcion = row["descripcion"].ToString();
                graficaD.Registros = Convert.ToInt32(row["ticket"]);
                //graficaC.Contador = Convert.ToInt32(row["porcentaje"]);
                listGraficaD.Add(graficaD);
            }
            res.ListGaficaD = listGraficaD;
            TablaD tablaD;
            List<TablaD> listTablaD = new List<TablaD>();

            foreach (DataRow row in table.Tables[5].Rows)
            {
                tablaD = new TablaD();
                tablaD.Nombre = row["nombre"].ToString();
                tablaD.Venta = Convert.ToDecimal(row["venta"]);
                tablaD.Descuento = Convert.ToDecimal(row["Descuento"]);
                tablaD.ImporteCDescuento = Convert.ToDecimal(row["ImporteCDescuento"]);
                tablaD.Neto = Convert.ToDecimal(row["Neto"]);
                tablaD.Descu = Convert.ToDecimal(row["Descu"]);
                tablaD.Porciones = Convert.ToDecimal(row["Porciones"]);
                listTablaD.Add(tablaD);
            }
            res.ListVentasD = listTablaD;

            TipoCancelacion tipoCancel;
            List<TipoCancelacion> listTipoCancel1 = new List<TipoCancelacion>();

            foreach (DataRow row in table.Tables[6].Rows)
            {
                tipoCancel = new TipoCancelacion();
                tipoCancel.Descripcion = row["descripcion"].ToString();
                tipoCancel.Valor = Convert.ToInt32(row["valor"]);
                listTipoCancel1.Add(tipoCancel);
            }
            res.ListStatusCancel = listTipoCancel1;

            List<TipoCancelacion> listTipoCancel2 = new List<TipoCancelacion>();

            foreach (DataRow row in table.Tables[7].Rows)
            {
                tipoCancel = new TipoCancelacion();
                tipoCancel.Descripcion = row["descripcion"].ToString();
                tipoCancel.Valor = Convert.ToInt32(row["valor"]);
                listTipoCancel2.Add(tipoCancel);
            }
            res.ListTipoCancel = listTipoCancel2;

            TablaMP tablaMP;
            List<TablaMP> listTablaMP = new List<TablaMP>();

            foreach (DataRow row in table.Tables[8].Rows)
            {
                tablaMP = new TablaMP();
                tablaMP.Descripcion = row["descripcion"].ToString();
                tablaMP.Efectivo =Convert.ToDecimal( row["efectivo"]);
                tablaMP.Debito = Convert.ToDecimal(row["debito"]);
                tablaMP.Credito = Convert.ToDecimal(row["credito"]);
                tablaMP.Otros = Convert.ToDecimal(row["otros"]);
                tablaMP.Total = Convert.ToDecimal(row["total"]);
                tablaMP.Tipo =Convert.ToInt32( row["tipo"]);
                listTablaMP.Add(tablaMP);
            }
            res.ListMP = listTablaMP;

            GraficaMP graficaMP;
            List<GraficaMP> listGraficaMP3 = new List<GraficaMP>();

            foreach (DataRow row in table.Tables[9].Rows)
            {
                graficaMP = new GraficaMP();
                graficaMP.Descripcion = row["descripcion"].ToString();
                graficaMP.Registros = Convert.ToDecimal(row["porcentaje"]); 
                listGraficaMP3.Add(graficaMP);
            }
            res.ListGraficaMP3 = listGraficaMP3;

            List<GraficaMP> listGraficaMP4 = new List<GraficaMP>();

            foreach (DataRow row in table.Tables[9].Rows)
            {
                graficaMP = new GraficaMP();
                graficaMP.Descripcion = row["descripcion"].ToString();
                graficaMP.Registros = Convert.ToDecimal(row["porcentaje"]);
                listGraficaMP4.Add(graficaMP);
            }
            res.ListGraficaMP4 = listGraficaMP4;

            List<TablaDDetalle> listTablaDetalle = new List<TablaDDetalle>();
            TablaDDetalle tablaDDetalle;
            foreach (DataRow row in table.Tables[11].Rows)
            {
                tablaDDetalle = new TablaDDetalle();
                tablaDDetalle.Tipo = row["tipo"].ToString();
                tablaDDetalle.Quien = row["quien"].ToString();
                tablaDDetalle.Aquien = row["aquien"].ToString();
                tablaDDetalle.Id = row["id"].ToString();
                tablaDDetalle.Descuento =Convert.ToDecimal( row["descuento"].ToString());
                tablaDDetalle.Monto =Convert.ToDecimal( row["monto"].ToString());
                listTablaDetalle.Add(tablaDDetalle);
            }
            res.ListDetalle = listTablaDetalle;
        }
        catch (Exception ex) { return res; }
        return res;
    }

    [System.Web.Services.WebMethod]
    public static Res ConsultaDashboardNuevo_(string f1,  string tienda)
    {

        Res res = new Res();
        Form_AdministrarCuentas form = new Form_AdministrarCuentas();
        try
        {
            Conexion conexion = new Conexion();
            int idlocal = form.ObtenerId(tienda);
            DataSet table = new DataSet();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);

            /* DateTime FechaModificada = DateTime.Parse(f1);
             string a1 = FechaModificada.ToString("yyyyMMdd");
             DateTime FechaModificada2 = DateTime.Parse(f2);
             string a2 = FechaModificada2.ToString("yyyyMMdd");*/
             string ID = (string)(form.Session["ID"]);
            string inicioAux = f1.Split('-')[0].Trim();
            string finAux = f1.Split('-')[1].Trim();
            string inicio = inicioAux.Split('/')[2] + "-" + inicioAux.Split('/')[1] + "-" + inicioAux.Split('/')[0];
            string fin = finAux.Split('/')[2] + "-" + finAux.Split('/')[1] + "-" + finAux.Split('/')[0];

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 1);
            command.Parameters.AddWithValue("@fecha", inicio);
            command.Parameters.AddWithValue("@fecha2", fin);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.Parameters.AddWithValue("@idusuario", ID);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            GraficaHoras graficaHoras;
            List<GraficaHoras> listGraficaH = new List<GraficaHoras>();

            foreach (DataRow row in table.Tables[0].Rows)
            {
                graficaHoras = new GraficaHoras();
                graficaHoras.Descripcion = row["descripcion"].ToString();
                graficaHoras.Registros = Convert.ToInt32(row["registros"]);
                graficaHoras.Contador = Convert.ToInt32(row["contador"]);
                listGraficaH.Add(graficaHoras);
            }
            res.ListGaficaH = listGraficaH;

            TablaH tablaH;
            List<TablaH> listTablaH = new List<TablaH>();

            foreach (DataRow row in table.Tables[1].Rows)
            {
                tablaH = new TablaH();
                //tablaH.Id = Convert.ToInt32(row["id"]);
                tablaH.Descripcion = row["Descripcion"].ToString();
                tablaH.Total = Convert.ToDecimal(row["Total"]);
                tablaH.Desayunos = Convert.ToDecimal(row["Desayunos"]);
                tablaH.PDesayunos = Convert.ToDecimal(row["PDes"]);
                tablaH.Comidas = Convert.ToDecimal(row["Comidas"]);
                tablaH.PComidas = Convert.ToDecimal(row["PCom"]);
                tablaH.Cenas = Convert.ToDecimal(row["Cenas"]);
                tablaH.PCenas = Convert.ToDecimal(row["PCen"]);
                listTablaH.Add(tablaH);
            }
            res.ListVentasH = listTablaH;
            //cancelaciones
            GraficaC graficaC;
            List<GraficaC> listGraficaC = new List<GraficaC>();

            foreach (DataRow row in table.Tables[2].Rows)
            {
                graficaC = new GraficaC();
                graficaC.Descripcion = row["descripcion"].ToString();
                graficaC.Registros = Convert.ToInt32(row["ticket"]);
                //graficaC.Contador = Convert.ToInt32(row["porcentaje"]);
                listGraficaC.Add(graficaC);
            }
            res.ListGaficaC = listGraficaC;

            TablaC tablaC;
            List<TablaC> listTablaC = new List<TablaC>();

            foreach (DataRow row in table.Tables[3].Rows)
            {
                tablaC = new TablaC();
                tablaC.Descripcion = row["Descripcion"].ToString();
                tablaC.Monto = Convert.ToDecimal(row["monto"]);
                tablaC.VReal = Convert.ToDecimal(row["vreal"]);
                tablaC.PMonto = Convert.ToDecimal(row["pmonto"]);
                tablaC.Porciones = Convert.ToDecimal(row["porciones"]);
                tablaC.PorcionesReales = Convert.ToDecimal(row["preal"]);
                tablaC.PPorciones = Convert.ToDecimal(row["pporciones"]);
                listTablaC.Add(tablaC);
            }
            res.ListVentasC = listTablaC;
            //descuentos
            GraficaD graficaD;
            List<GraficaD> listGraficaD = new List<GraficaD>();

            foreach (DataRow row in table.Tables[4].Rows)
            {
                graficaD = new GraficaD();
                graficaD.Descripcion = row["descripcion"].ToString();
                graficaD.Registros = Convert.ToInt32(row["ticket"]);
                //graficaC.Contador = Convert.ToInt32(row["porcentaje"]);
                listGraficaD.Add(graficaD);
            }
            res.ListGaficaD = listGraficaD;
            TablaD tablaD;
            List<TablaD> listTablaD = new List<TablaD>();

            foreach (DataRow row in table.Tables[5].Rows)
            {
                tablaD = new TablaD();
                tablaD.Nombre = row["nombre"].ToString();
                tablaD.Venta = Convert.ToDecimal(row["venta"]);
                tablaD.Descuento = Convert.ToDecimal(row["Descuento"]);
                tablaD.ImporteCDescuento = Convert.ToDecimal(row["ImporteCDescuento"]);
                tablaD.Neto = Convert.ToDecimal(row["Neto"]);
                tablaD.Descu = Convert.ToDecimal(row["Descu"]);
                tablaD.Porciones = Convert.ToDecimal(row["Porciones"]);
                listTablaD.Add(tablaD);
            }
            res.ListVentasD = listTablaD;

            TipoCancelacion tipoCancel;
            List<TipoCancelacion> listTipoCancel1 = new List<TipoCancelacion>();

            foreach (DataRow row in table.Tables[6].Rows)
            {
                tipoCancel = new TipoCancelacion();
                tipoCancel.Descripcion = row["descripcion"].ToString();
                tipoCancel.Valor = Convert.ToInt32(row["valor"]);
                listTipoCancel1.Add(tipoCancel);
            }
            res.ListStatusCancel = listTipoCancel1;

            List<TipoCancelacion> listTipoCancel2 = new List<TipoCancelacion>();

            foreach (DataRow row in table.Tables[7].Rows)
            {
                tipoCancel = new TipoCancelacion();
                tipoCancel.Descripcion = row["descripcion"].ToString();
                tipoCancel.Valor = Convert.ToInt32(row["valor"]);
                listTipoCancel2.Add(tipoCancel);
            }
            res.ListTipoCancel = listTipoCancel2;

            TablaMP tablaMP;
            List<TablaMP> listTablaMP = new List<TablaMP>();

            foreach (DataRow row in table.Tables[8].Rows)
            {
                tablaMP = new TablaMP();
                tablaMP.Descripcion = row["descripcion"].ToString();
                tablaMP.Efectivo = Convert.ToDecimal(row["efectivo"]);
                tablaMP.Debito = Convert.ToDecimal(row["debito"]);
                tablaMP.Credito = Convert.ToDecimal(row["credito"]);
                tablaMP.Otros = Convert.ToDecimal(row["otros"]);
                tablaMP.Total = Convert.ToDecimal(row["total"]);
                tablaMP.Tipo = Convert.ToInt32(row["tipo"]);
                listTablaMP.Add(tablaMP);
            }
            res.ListMP = listTablaMP;

            GraficaMP graficaMP;
            List<GraficaMP> listGraficaMP3 = new List<GraficaMP>();

            foreach (DataRow row in table.Tables[9].Rows)
            {
                graficaMP = new GraficaMP();
                graficaMP.Descripcion = row["descripcion"].ToString();
                graficaMP.Registros = Convert.ToDecimal(row["porcentaje"]);
                listGraficaMP3.Add(graficaMP);
            }
            res.ListGraficaMP3 = listGraficaMP3;

            List<GraficaMP> listGraficaMP4 = new List<GraficaMP>();

            foreach (DataRow row in table.Tables[9].Rows)
            {
                graficaMP = new GraficaMP();
                graficaMP.Descripcion = row["descripcion"].ToString();
                graficaMP.Registros = Convert.ToDecimal(row["porcentaje"]);
                listGraficaMP4.Add(graficaMP);
            }
            res.ListGraficaMP4 = listGraficaMP4;

            List<TablaDDetalle> listTablaDetalle = new List<TablaDDetalle>();
            TablaDDetalle tablaDDetalle;
            foreach (DataRow row in table.Tables[11].Rows)
            {
                tablaDDetalle = new TablaDDetalle();
                tablaDDetalle.Tipo = row["tipo"].ToString();
                tablaDDetalle.Quien = row["quien"].ToString();
                tablaDDetalle.Aquien = row["aquien"].ToString();
                tablaDDetalle.Id = row["id"].ToString();
                tablaDDetalle.Descuento = Convert.ToDecimal(row["descuento"].ToString());
                tablaDDetalle.Monto = Convert.ToDecimal(row["monto"].ToString());
                listTablaDetalle.Add(tablaDDetalle);
            }
            res.ListDetalle = listTablaDetalle;
        }
        catch (Exception ex) { return res; }
        return res;
    }
    [System.Web.Services.WebMethod]
    public static Res ConsultaDashboard(string f1, string f2, string tienda)
    {
            Res res = new Res();
            Form_AdministrarCuentas form = new Form_AdministrarCuentas();
            Conexion conexion = new Conexion();
            int idlocal = form.ObtenerId(tienda);
            DataSet table = new DataSet();
        try
        {
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            string ID = (string)(form.Session["ID"]);

            if(ID == "")
                form.Response.Redirect("../Index.aspx");
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 5);
            command.Parameters.AddWithValue("@f3", a1);
            command.Parameters.AddWithValue("@f4", a2);
            command.Parameters.AddWithValue("@id", idlocal);
            command.Parameters.AddWithValue("@idusuario", ID);
            string[] fecha1 = a1.Split('-');
            string[] fecha2 = a2.Split('-');
            if (fecha1[0] == fecha2[0])
            {
                if (fecha1[1] == fecha2[1])
                    command.Parameters.AddWithValue("@opcionArea", 1);//solo el mes
                else
                    command.Parameters.AddWithValue("@opcionArea", 2);//solo el año
            }

            else
                command.Parameters.AddWithValue("@opcionArea", 3);//todos los años
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            Tabla tabla;
            List<Tabla> listTabla = new List<Tabla>();

            foreach (DataRow row in table.Tables[0].Rows)
            {
                res.Ventas = row["ventaBruta"].ToString();
                res.Presupuesto = row["Presupuesto"].ToString();
                res.Tendencia = row["ventaNeta"].ToString();
                res.Tickets = row["Transacciones"].ToString();
                res.TicketsPromedio = row["transaccionesPromedio"].ToString();
                res.Descuentos = row["descuentos"].ToString();
                res.Cancelaciones = row["Cancelaciones"].ToString();
            }

            foreach (DataRow row in table.Tables[1].Rows)
            {
                tabla = new Tabla();
                tabla.Sucursal = row["nombre"].ToString();
                tabla.VentaNeta = row["VentaNeta"].ToString();
                tabla.VentaBruta = row["VentaBruta"].ToString();
                tabla.Tickets = row["transacciones"].ToString();
                listTabla.Add(tabla);
            }
            res.ListTabla = listTabla;

            Dona dona = new Dona();
            foreach (DataRow row in table.Tables[2].Rows)
            {

                dona.Venta = (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"]) > 0 ? Convert.ToDecimal(row["ventaNeta"]) / (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"])) : 0).ToString("P0");
                dona.Presupuesto = (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"]) > 0 ? Convert.ToDecimal(row["Presupuesto"]) / (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"])) : 0).ToString("P0");
            }
            res.Dona = dona;


            Area area = new Area();
            List<Area> listArea = new List<Area>();
            foreach (DataRow row in table.Tables[3].Rows)
            {
                area = new Area();
                area.ValorY = row["Fecha"].ToString();
                area.ValorA = row["M_Neto"].ToString();
                area.ValorB = row["Presupuesto"].ToString();
                area.ValorC = row["Tickets"].ToString();
                listArea.Add(area);
            }
            res.ListArea = listArea;
        }
        catch (Exception ex) { }
        return res;
    }
    [System.Web.Services.WebMethod]
    public static Res ConsultaDashboard_(string f1, string tienda)
    {
        Res res = new Res();
        Form_AdministrarCuentas form = new Form_AdministrarCuentas();
        Conexion conexion = new Conexion();
        int idlocal = form.ObtenerId(tienda);
        DataSet table = new DataSet();
        try
        {
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

            /*DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");*/
            string inicioAux = f1.Split('-')[0].Trim();
            string finAux = f1.Split('-')[1].Trim();
            string inicio = inicioAux.Split('/')[2] + "-" + inicioAux.Split('/')[1] + "-" + inicioAux.Split('/')[0];
            string fin = finAux.Split('/')[2] + "-" + finAux.Split('/')[1] + "-" + finAux.Split('/')[0];
            string ID = (string)(form.Session["ID"]);

            if (ID == "")
                form.Response.Redirect("../Index.aspx");
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 5);
            command.Parameters.AddWithValue("@f3", inicio);
            command.Parameters.AddWithValue("@f4", fin);
            command.Parameters.AddWithValue("@id", idlocal);
            command.Parameters.AddWithValue("@idusuario", ID);
            /*string[] fecha1 = a1.Split('-');
            string[] fecha2 = a2.Split('-');
            if (fecha1[0] == fecha2[0])
            {
                if (fecha1[1] == fecha2[1])
                    command.Parameters.AddWithValue("@opcionArea", 1);//solo el mes
                else
                    command.Parameters.AddWithValue("@opcionArea", 2);//solo el año
            }

            else*/
                command.Parameters.AddWithValue("@opcionArea", 3);//todos los años
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            Tabla tabla;
            List<Tabla> listTabla = new List<Tabla>();

            foreach (DataRow row in table.Tables[0].Rows)
            {
                res.Ventas = row["ventaBruta"].ToString();
                res.Presupuesto = row["Presupuesto"].ToString();
                res.Tendencia = row["ventaNeta"].ToString();
                res.Tickets = row["Transacciones"].ToString();
                res.TicketsPromedio = row["transaccionesPromedio"].ToString();
                res.Descuentos = row["descuentos"].ToString();
                res.Cancelaciones = row["Cancelaciones"].ToString();
            }

            foreach (DataRow row in table.Tables[1].Rows)
            {
                tabla = new Tabla();
                tabla.Sucursal = row["nombre"].ToString();
                tabla.VentaNeta = row["VentaNeta"].ToString();
                tabla.VentaBruta = row["VentaBruta"].ToString();
                tabla.Tickets = row["transacciones"].ToString();
                listTabla.Add(tabla);
            }
            res.ListTabla = listTabla;

            Dona dona = new Dona();
            foreach (DataRow row in table.Tables[2].Rows)
            {

                dona.Venta = (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"]) > 0 ? Convert.ToDecimal(row["ventaNeta"]) / (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"])) : 0).ToString("P0");
                dona.Presupuesto = (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"]) > 0 ? Convert.ToDecimal(row["Presupuesto"]) / (Convert.ToDecimal(row["ventaNeta"]) + Convert.ToDecimal(row["Presupuesto"])) : 0).ToString("P0");
            }
            res.Dona = dona;


            Area area = new Area();
            List<Area> listArea = new List<Area>();
            foreach (DataRow row in table.Tables[3].Rows)
            {
                area = new Area();
                area.ValorY = row["Fecha"].ToString();
                area.ValorA = row["M_Neto"].ToString();
                area.ValorB = row["Presupuesto"].ToString();
                area.ValorC = row["Tickets"].ToString();
                listArea.Add(area);
            }
            res.ListArea = listArea;
        }
        catch (Exception ex) { }
        return res;
    }
    public int ObtenerId(string nombre)
    {
        Conexion conexion = new Conexion();
        int idlocal=0;
        if (!nombre.Equals("Todas"))
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
        return idlocal;
    }
    [System.Web.Services.WebMethod]
    public static HCTA DetalleTicketEncabezado( string id)
    {
            HCTA hcta = new HCTA();
        try
        {
            Conexion conexion = new Conexion();
            DataSet table = new DataSet();
            Form_AdministrarCuentas form = new Form_AdministrarCuentas();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            string[] cad = id.Split('_');
            string fecha = cad[0].ToString();
            string id_local = cad[1].ToString();
            string id_term = cad[2].ToString();
            string id_coma = cad[3].ToString();
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 13);
            command.Parameters.AddWithValue("@fechaDetalle", fecha);
            command.Parameters.AddWithValue("@id_localDetalle", id_local);
            command.Parameters.AddWithValue("@id_term", id_term);
            command.Parameters.AddWithValue("@id_coma", id_coma);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            foreach (DataRow row in table.Tables[0].Rows)
            {
                hcta = new HCTA();
                hcta.Apertura = row["fecha_apertura"].ToString();
                hcta.Mesa = row["mesa"].ToString();
                hcta.Desc_info = row["Desc_info"].ToString();
                hcta.Desc_emp = row["Desc_emp"].ToString();
            }
        }
        catch (Exception ex) { }
        return hcta;
    }

    [System.Web.Services.WebMethod]
    public static List<HCTAORD> DetalleTicketCuerpo(string id)
    {
            List<HCTAORD> lista = new List<HCTAORD>();
        try
        {
            Conexion conexion = new Conexion();
            DataSet table = new DataSet();
            Form_AdministrarCuentas form = new Form_AdministrarCuentas();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            string[] cad = id.Split('_');
            string fecha = cad[0].ToString();
            string id_local = cad[1].ToString();
            string id_term = cad[2].ToString();
            string id_coma = cad[3].ToString();
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 14);
            command.Parameters.AddWithValue("@fechaDetalle", fecha);
            command.Parameters.AddWithValue("@id_localDetalle", id_local);
            command.Parameters.AddWithValue("@id_term", id_term);
            command.Parameters.AddWithValue("@id_coma", id_coma);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            HCTAORD hctaord = new HCTAORD(); ;
            foreach (DataRow row in table.Tables[0].Rows)
            {
                hctaord = new HCTAORD();
                hctaord.Porciones =Convert.ToInt32( row["porciones"]);
                hctaord.Producto = row["producto"].ToString();
                hctaord.M_importe = Convert.ToDecimal(row["M_importe"]);
                hctaord.M_desc = Convert.ToDecimal(row["M_desc"]);
                hctaord.M_total = Convert.ToDecimal(row["M_total"]);
                lista.Add(hctaord);
            }
        }
        catch (Exception ex) { }
        return lista;
    }
   /* [System.Web.Services.WebMethod]
    public static string DetalleTicketCuerpo(string id)
    {
        string resultado = "";
        List<HCTAORD> lista = new List<HCTAORD>();
        try
        {
            Conexion conexion = new Conexion();
            DataSet table = new DataSet();
            Form_AdministrarCuentas form = new Form_AdministrarCuentas();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            string[] cad = id.Split('_');
            string fecha = cad[0].ToString();
            string id_local = cad[1].ToString();
            string id_term = cad[2].ToString();
            string id_coma = cad[3].ToString();
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 14);
            command.Parameters.AddWithValue("@fechaDetalle", fecha);
            command.Parameters.AddWithValue("@id_localDetalle", id_local);
            command.Parameters.AddWithValue("@id_term", id_term);
            command.Parameters.AddWithValue("@id_coma", id_coma);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            HCTAORD hctaord = new HCTAORD(); ;
            decimal importe = 0;
            decimal desc = 0;
            resultado = "<table style='width: 100% '>";
            foreach (DataRow row in table.Tables[0].Rows)
            {
                hctaord = new HCTAORD();
                hctaord.Porciones = Convert.ToInt32(row["porciones"]);
                hctaord.Producto = row["producto"].ToString();
                hctaord.M_importe = Convert.ToDecimal(row["M_importe"]);
                hctaord.M_desc = Convert.ToDecimal(row["M_desc"]);
                hctaord.M_total = Convert.ToDecimal(row["M_total"]);
                lista.Add(hctaord);

                importe += Convert.ToDecimal(row["M_importe"]);
                desc += Convert.ToDecimal(row["M_desc"]);
                resultado += "<tr >";
                resultado += "<td  width='10%'>" + Convert.ToInt32(row["porciones"]);
                resultado += "</td>";
                resultado += "<td  width='70%'>" + row["producto"].ToString();
                //html += '<td  width="20%" align="right">' + formatDollar(value.M_importe)
                resultado += "<td  width='20%' align='right'>" + Convert.ToDecimal(row["M_importe"]);
            }
            resultado += "</table>";
            resultado += "<hr>";
            resultado += "<table style='width:100%'><tr><td width='10%' align='right'> </td><td rowspan='2' width='70%'>Importe</td><td width='20%' align='right'>" + (importe) + " </td></tr></table>";
            resultado += "<table style='width:100%'><tr><td width='10%' align='right'> </td><td rowspan='2' width='70%'>Descuento</td><td width='20%' align='right'>" + (desc) + " </td></tr></table>";
            resultado += "<table style='width:100%'><tr><td width='10%' align='right'> </td><td rowspan='2' width='70%'>Total</td><td width='20%' align='right'>" + (importe - desc) + " </td></tr></table>";


        }
        catch (Exception ex) { }
        return resultado;
    }*/

    [System.Web.Services.WebMethod]
    public static HCTPGO DetalleTicketPago(string id)
    {
        HCTPGO hcta = new HCTPGO();
        try
        {
            Conexion conexion = new Conexion();
            DataSet table = new DataSet();
            Form_AdministrarCuentas form = new Form_AdministrarCuentas();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            string[] cad = id.Split('_');
            string fecha = cad[0].ToString();
            string id_local = cad[1].ToString();
            string id_term = cad[2].ToString();
            string id_coma = cad[3].ToString();

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 15);
            command.Parameters.AddWithValue("@fechaDetalle", fecha);
            command.Parameters.AddWithValue("@id_localDetalle", id_local);
            command.Parameters.AddWithValue("@id_term", id_term);
            command.Parameters.AddWithValue("@id_coma", id_coma);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            foreach (DataRow row in table.Tables[0].Rows)
            {
                hcta = new HCTPGO();
                hcta.Tc_monto = Convert.ToDecimal(row["Tc_monto"]);
                hcta.Forma_pago = row["Forma_pago"].ToString();
            }
        }
        catch (Exception ex) { }
        return hcta;
    }
    [System.Web.Services.WebMethod]
    public static List<Solicitud> ConsultaSolicitudes(string f1, string f2, string nombre, int opcion)
    {
        Conexion conexion = new Conexion();
        List<Solicitud> lista = new List<Solicitud>();
        DataTable table = new DataTable();
        Form_AdministrarCuentas form = new Form_AdministrarCuentas();
        SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
        if (opcion == 1)
        {
            /*DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");*/

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 1);
            /*command.Parameters.AddWithValue("@f1", a1);
            command.Parameters.AddWithValue("@f2", a2);*/
            command.Parameters.AddWithValue("@nombre", nombre);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            Solicitud solicitud;
            foreach (DataRow row in table.Rows)
            {
                solicitud = new Solicitud();
                solicitud.Nombre= row["nombre"].ToString();
                solicitud.Correo =row["correoelectronico"].ToString();
                solicitud.Rol=row["rol"].ToString();
                solicitud.Fecha =row["fecha"].ToString();
                solicitud.Estado = row["estado"].ToString();
                solicitud.Id = Convert.ToInt32(row["id"]);
                lista.Add(solicitud);
            }
        }
        if (opcion == 2)
        {
           /* DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");*/

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 2);
           /* command.Parameters.AddWithValue("@f1", a1);
            command.Parameters.AddWithValue("@f2", a2);*/
            command.Parameters.AddWithValue("@nombre", nombre);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            Solicitud solicitud;
            foreach (DataRow row in table.Rows)
            {
                solicitud = new Solicitud();
                solicitud.Nombre = row["nombre"].ToString();
                solicitud.Correo = row["correoelectronico"].ToString();
                solicitud.Rol = row["rol"].ToString();
                solicitud.Fecha = row["fecha"].ToString();
                solicitud.Estado = row["estado"].ToString();
                solicitud.Id = Convert.ToInt32(row["id"]);
                solicitud.Fechaacceso = row["acceso"].ToString();
                lista.Add(solicitud);
            }
        }
        return lista;
    }

    [System.Web.Services.WebMethod]
    public static string Procesar(int id,int respuesta)
    {

        Form_AdministrarCuentas form = new Form_AdministrarCuentas();
        Conexion conexion = new Conexion();
        string res = "";

        SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 3);
            command.Parameters.AddWithValue("@id", id);
            command.Connection.Open();
        res = command.ExecuteNonQuery() == 0 ? "Problemas al actualizar" : "OK";
        if (res == "OK")
            form.CorreoRespuesta(id,respuesta);
        return res;
    }


    public int CorreoRespuesta(int id,int respuesta)
    {
        Conexion conexion = new Conexion();
        System.Net.Mail.MailMessage msg = new MailMessage();
        conexion.comando.Connection = conexion.miconexion;
        conexion.comando.CommandText = "SELECT correo FROM Usuarios WHERE id= "+id;
        conexion.comando.CommandType = CommandType.Text;

        conexion.Conectar();
        conexion.reader = conexion.comando.ExecuteReader();

        SmtpClient client = new SmtpClient();
        if (conexion.reader.Read())
        {
        string correo = conexion.reader["correo"].ToString();
            string imagen = "";
        conexion.comando.Dispose();
        conexion.Desconectar();
            msg.To.Add(correo);
            //msg.To.Add("alan.acuitlapa@gmail.com");
            msg.From = new MailAddress("soportesoporte586@gmail.com", "Web Master", System.Text.Encoding.UTF8);
            msg.Subject = "Respuesta";
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            if (respuesta == 1)
                imagen = "mailing_aceptado.gif";
            else
                imagen = "mailing_rechazado.gif";
            LinkedResource LinkedImage = new LinkedResource(Server.MapPath("~/Form/img/" + imagen));
            LinkedImage.ContentId = "MyPic";
            LinkedImage.ContentType = new ContentType(MediaTypeNames.Image.Jpeg);


            AlternateView htmlView = AlternateView.CreateAlternateViewFromString(
             "<img style=\"width:50%;float:left\" src=cid:MyPic>",
              null, "text/html");
            htmlView.TransferEncoding = System.Net.Mime.TransferEncoding.Base64;
            htmlView.LinkedResources.Add(LinkedImage);

            msg.AlternateViews.Add(htmlView);

            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;

            //Aquí es donde se hace lo especial
            client.Credentials = new System.Net.NetworkCredential("soportesoporte586@gmail.com", "eks2019-");
            client.Port = 587;
            client.Host = "smtp.gmail.com";
            client.EnableSsl = true;
        }
        try
        {
            client.Send(msg);
            return 1;
        }
        catch (System.Net.Mail.SmtpException ex)
        {
            Console.WriteLine(ex.Message);
            Console.ReadLine();
            return 0;
        }
        //}
    }

    [System.Web.Services.WebMethod]
    public static string ProcesarRegistrado(int opcion, int id)
    {

        Form_AdministrarCuentas form = new Form_AdministrarCuentas();
        Conexion conexion = new Conexion();
        string res = "";

        SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@consulta", 4);
        command.Parameters.AddWithValue("@id", id);
        command.Parameters.AddWithValue("@opcion", opcion);
        command.Connection.Open();
        res = command.ExecuteNonQuery() == 0 ? "Problemas al actualizar" : "OK";
        
        return res;
    }
}