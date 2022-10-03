using Spire.Xls;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Reportes : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ID = (string)(Session["ID"]);
        SqlDataSource1.SelectParameters.Add("IdUsuario", DbType.Int32, ID);
        string rol = (String)(Session["Rol"]);
        if (rol == "superusuario")
        {
            DropDownList12.DataSourceID = "SqlDataSource2";
        }
        else
        {
            DropDownList12.DataSourceID = "SqlDataSource1";
        }
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
    public static List<Reporte> ReportePCategorias(string f1, string f2, string nombre, int opcion)
    {
        Conexion conexion = new Conexion();
        List<Reporte> lista = new List<Reporte>();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            int idlocal = form.ObtenerId(nombre);
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 22);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            /*table.DefaultView.Sort = "porciones desc";
            table = table.DefaultView.ToTable();*/
            Reporte reporte;
            foreach (DataRow row in table.Rows)
            {
                reporte = new Reporte();
                reporte.Nombre = row["categoria"].ToString().Replace(" ", "");
                reporte.Producto = row["producto"].ToString();
                reporte.Porcion = Convert.ToInt32(row["porciones"]);
                reporte.Participacion = Convert.ToDecimal(row["participacion"]);
                reporte.Orden = row["orden"].ToString().Replace(" ", "");
                lista.Add(reporte);
            }
        }
        catch (Exception ex) { }
        return lista;
    }
    [System.Web.Services.WebMethod]
    public static List<Reporte> ReporteCVerde(string f1, string f2, string nombre, int opcion)
    {
        Conexion conexion = new Conexion();
        List<Reporte> lista = new List<Reporte>();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            int idlocal = form.ObtenerId(nombre);
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            if (opcion == 2)
            {
                DateTime FechaModificada = DateTime.Parse(f1);
                string a1 = FechaModificada.ToString("yyyy-MM-dd");
                DateTime FechaModificada2 = DateTime.Parse(f2);
                string a2 = FechaModificada2.ToString("yyyy-MM-dd");

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@consulta", 12);
                command.Parameters.AddWithValue("@fecha", a1);
                command.Parameters.AddWithValue("@fecha2", a2);
                command.Parameters.AddWithValue("@idSucursal", idlocal);
                command.Parameters.AddWithValue("@idUsuario", ID);
                command.CommandTimeout = 0;
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = command;
                adapter.Fill(table);

                Reporte reporte;
                foreach (DataRow row in table.Rows)
                {
                    reporte = new Reporte();
                    reporte.Nombre = row["nombre"].ToString();
                    reporte.Producto = row["producto"].ToString();
                    reporte.Hora = row["fecha"].ToString();
                    reporte.Precio = Convert.ToDecimal(row["Precio"]);
                    reporte.Porcion = Convert.ToInt32(row["porciones"]);
                    reporte.Folio = Convert.ToInt32(row["folio"]);
                    lista.Add(reporte);
                }
            }
        }
        catch (Exception ex) { }
        return lista;
    }
    [System.Web.Services.WebMethod]
    public static List<string> Consulta(string f1, string f2, string nombre, int opcion)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
        StringBuilder json = new StringBuilder();
        List<string> resultados = new List<string>();
        List<Fecha> fechas = new List<Fecha>();
        List<PromedioFecha> Promedios = new List<PromedioFecha>();
        PromedioFecha prom = new PromedioFecha();
        Fecha fechaObj;
        DateTime FechaModificada = DateTime.Parse(f1);
        string a1 = FechaModificada.ToString("yyyy-MM-dd");
        DateTime FechaModificada2 = DateTime.Parse(f2);
        string a2 = FechaModificada2.ToString("yyyy-MM-dd");
        int promedio = 0;
        int idlocal = form.ObtenerId(nombre);
        string ID = (string)(form.Session["ID"]);
        SqlCommand command1 = new SqlCommand("sp_dash", conexion.Conection);

        command1.CommandType = CommandType.StoredProcedure;
        command1.Parameters.AddWithValue("@consulta", 11);
        command1.Parameters.AddWithValue("@fecha", a1);
        command1.Parameters.AddWithValue("@fecha2", a2);
        command1.CommandTimeout = 0;
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = command1;
        adapter.Fill(table);
        promedio = table.Rows.Count;
        foreach (DataRow row in table.Rows)
        {
            fechaObj = new Fecha();
            fechaObj.FechaEntero = Convert.ToInt32(row["fecha"]);
            fechaObj.FechaCadena = row["Fechacadena"].ToString();
            fechas.Add(fechaObj);
        }

        if (opcion == 1)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(conexion.ConnectionString))
                {
                    cnn.Open();
                    using (SqlCommand cmd = new SqlCommand("sp_dash", cnn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@consulta", 10);
                        cmd.Parameters.AddWithValue("@fecha", a1);
                        cmd.Parameters.AddWithValue("@fecha2", a2);
                        cmd.Parameters.AddWithValue("@idSucursal", idlocal);
                        cmd.Parameters.AddWithValue("@idUsuario", ID); ;
                        string res = "";
                        int total = 0;
                        int contador = 0;
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int x = reader.FieldCount;
                                string[] columna;
                                columna = new string[x];
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    columna[i] = reader.GetName(i);
                                    if (i > 0)
                                    {
                                        Fecha fechaAux;
                                        fechaAux = fechas.FirstOrDefault(w => w.FechaEntero == Convert.ToInt32(reader.GetName(i)));
                                        if (fechaAux != null)
                                        {
                                            res += fechaAux.FechaCadena.ToString() + "_";
                                        }
                                        else
                                            res += reader.GetName(i).ToString() + "_";
                                    }
                                    else
                                        res += reader.GetName(i).ToString() + "_";
                                }
                                if (contador == 0)
                                {
                                    res += "Total" + "_Promedio_";
                                    resultados.Add(res);
                                }

                                res = "";

                                for (int y = 0; y < columna.Length; y++)
                                {
                                    res += reader[columna[y]] != DBNull.Value ? reader[columna[y]].ToString() + "_" : "0_";
                                    if (y > 0)
                                        total += reader[columna[y]] != DBNull.Value ? Convert.ToInt32(reader[columna[y]]) : 0;
                                }
                                res += total.ToString() + "_";
                                res += promedio > 0 ? (Convert.ToDecimal(total) / Convert.ToDecimal(promedio)).ToString("N1") + "_" : "0_";
                                prom = new PromedioFecha();
                                prom.Promedio = promedio > 0 ? (Convert.ToDecimal(total) / Convert.ToDecimal(promedio)) : 0;
                                prom.Cadena = res;
                                Promedios.Add(prom);
                                //resultados.Add(res);
                                res = "";
                                total = 0;
                                contador++;
                            }
                        }
                    }
                    cnn.Close();
                }
            }
            catch (Exception ex) { }
            List<PromedioFecha> paux = Promedios.OrderByDescending(order => order.Promedio).ToList();
            //resultados.Clear();
            paux.ForEach(dto => {
                string cad = dto.Cadena;
                resultados.Add(cad);
            });
        }
        return resultados;
    }
    public int ObtenerId(string nombre)
    {
        Conexion conexion = new Conexion();
        int idlocal = 0;
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
    public static string ReporteMonedero(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            //SqlConnection con = new SqlConnection("server=172.20.250.42;database=rs-vtol;user id =loyalty; password =d3s4rr0ll0;");
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 26);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }


    [System.Web.Services.WebMethod]
    public static string ReporteDetalleMonedero(string f1, string f2, string sucursal,string cardNum)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            //SqlConnection con = new SqlConnection("server=172.20.250.42;database=rs-vtol;user id =loyalty; password =d3s4rr0ll0;");
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 27);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.Parameters.AddWithValue("@cardNum", cardNum);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }

    [System.Web.Services.WebMethod]
    public static string ReporteTipo(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 25);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }

    [System.Web.Services.WebMethod]
    public static string ReporteVDS(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("vds", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }
    [System.Web.Services.WebMethod]
    public static string ReporteProductosMasVendidos(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("productomasvendido", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }
    [System.Web.Services.WebMethod]
    public static string ReporteHoras(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }
    [System.Web.Services.WebMethod]
    public static string ReporteVDSII(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("vdsII", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }
    [System.Web.Services.WebMethod]
    public static string ReporteVentasMensuales(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        string[] meses = { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };
        string html = "";
        DataTable dt = new DataTable();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 28);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            dt.Clear();
            foreach (DataRow row in table.Rows)
            {
                dt.Columns.Add( meses[Convert.ToInt32(row["mes"])-1], typeof(string));
            }
            dt.Columns.Add("Total", typeof(string));
            DataRow _ravi = dt.NewRow();
            
            int cont = 0;
            foreach (DataRow row in table.Rows)
            {
                _ravi[meses[Convert.ToInt32(row["mes"]) - 1]] = meses[Convert.ToInt32(row["mes"]) - 1];
                cont++;
            }
            _ravi["Total"] = "Total";
            dt.Rows.Add(_ravi);
            _ravi = dt.NewRow();
            decimal total = 0;
            foreach (DataRow row in table.Rows)
            {
                _ravi[meses[Convert.ToInt32(row["mes"])-1] ]=Convert.ToString(row["venta"]);
                total += Convert.ToDecimal(row["venta"]);
            }
            dt.Rows.Add(_ravi);

            DataRow row2 = dt.Rows[0];
            html = "<table class='table tablaAdmin'>";
            html += "<tr>";
            for(int x=cont-1;x > -1;x--)
            {
                html += "<th>" + row2[x].ToString();
                html += "</th>";
            }
            html += "<th>Total" ;
            html += "</th>";

            html += "</tr>";
            row2 = dt.Rows[1];
            html += "<tr>";
            for (int x = cont-1; x >-1; x--)
            {
                html += "<td>" +Convert.ToDecimal( row2[x]).ToString("c0");
                html += "</td>";
            }
            html += "<td>" + total.ToString("c0");
            html += "</td>";
            html += "</tr>";
            html += "</table>";
        }

        catch (Exception ex) { }
        return html;
        //return DataSetToJSON(dt);
    }


    [System.Web.Services.WebMethod]
    public static string ReporteVentasMensualesdetalle(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        string html = "";
        DataTable dt = new DataTable(); try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 29);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            html += "<table class='table tablaAdmin' id='tblVentaMensuales'>";
            html += "<thead><tr>";
            html += "<th>Lunes</th>";
            html += "<th>Martes</th>";
            html += "<th>Miercoles</th>";
            html += "<th>Jueves</th>";
            html += "<th>Viernes</th>";
            html += "<th>Sábado</th>";
            html += "<th>Domingo</th>";
            html += "<th>Semana</th>";
            html += "<th>Venta</th>";
            html += "</tr></thead><tbody>";
            int dias = 0; html += "<tr>";
            bool encontrado = false;
            int cuentaSemanas = 0;
            int numdia = -1;
            int semana = 0;
            decimal totalSemana = 0;
            decimal totalVenta = 0;
            decimal totalL = 0;
            decimal totalM = 0;
            decimal totalMi = 0;
            decimal totalJ = 0;
            decimal totalV = 0;
            decimal totalS = 0;
            decimal totalD = 0;
            decimal ventaDia = 0;
            string title = "";
            string[] diassemana = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };
            foreach (DataRow row in table.Rows) {
                encontrado = false;
                title = row["fecha"].ToString();
                ventaDia = Convert.ToDecimal(row["venta"]);
                semana = Convert.ToInt32(row["semana"]);
                if (dias == 7)
                {
                    html += "</tr>";
                    dias = 0;
                    html += "<tr>";
                }
                if (cuentaSemanas < 1 )
                {
                    string nombreDiaarreglo = diassemana[0].ToString();
                    string nombreDia = row["nombreDia"].ToString();
                    if (nombreDiaarreglo!= "NO" && encontrado==false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='"+ title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[0] = "NO";
                            encontrado = true;
                            totalL += ventaDia;
                            totalSemana += ventaDia;
                        }
                        else
                        {
                            html += "<td></td>";
                            diassemana[0] = "NO";
                        }
                    }
                    nombreDiaarreglo = diassemana[1].ToString();
                    if (nombreDiaarreglo != "NO" && encontrado == false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[1] = "NO";
                            encontrado = true;
                            totalM += ventaDia;
                            totalSemana += ventaDia;
                        }
                        else
                        {
                            html += "<td ></td>";
                            diassemana[1] = "NO";
                        }
                    }
                    nombreDiaarreglo = diassemana[2].ToString();
                    if (nombreDiaarreglo != "NO" && encontrado == false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[2] = "NO";
                            encontrado = true;
                            totalMi += ventaDia;
                            totalSemana += ventaDia;
                        }
                        else
                        {
                            html += "<td></td>";
                            diassemana[2] = "NO";
                        }
                    }
                    nombreDiaarreglo = diassemana[3].ToString();
                    if (nombreDiaarreglo != "NO" && encontrado == false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[3] = "NO";
                            encontrado = true;
                            totalJ += ventaDia;
                            totalSemana += ventaDia;
                        }
                        else
                        {
                            html += "<td></td>";
                            diassemana[3] = "NO";
                        }
                    }
                    nombreDiaarreglo = diassemana[4].ToString();
                    if (nombreDiaarreglo != "NO" && encontrado == false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[4] = "NO";
                            encontrado = true;
                            totalV += ventaDia;
                            totalSemana += ventaDia;
                        }
                        else
                        {
                            html += "<td></td>";
                            diassemana[4] = "NO";
                        }
                    }
                    nombreDiaarreglo = diassemana[5].ToString();
                    if (nombreDiaarreglo != "NO" && encontrado == false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[5] = "NO";
                            encontrado = true;
                            totalS += ventaDia;
                            totalSemana += ventaDia;
                        }
                        else
                        {
                            html += "<td></td>";
                            diassemana[5] = "NO";
                        }
                    }
                    nombreDiaarreglo = diassemana[6].ToString();
                    if (nombreDiaarreglo != "NO" && encontrado == false)
                    {
                        if (row["nombreDia"].ToString() == nombreDiaarreglo)
                        {
                            html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") +"> " + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                            diassemana[6] = "NO";
                            cuentaSemanas++;
                            totalSemana += ventaDia;
                            html += "<td align='center' bgcolor='#6db23f'><font color='#fff'>" + (semana-1) + "</font></td>";
                            html += "<td>" + totalSemana.ToString("c0") + "</td>";
                            totalVenta += totalSemana;
                            totalD += ventaDia;
                            totalSemana = 0;
                            dias = 7;
                        }
                        else
                        {
                            html += "<td></td>";
                        }
                    }
                }
                else
                {
                    if (row["nombreDia"].ToString() == "Monday")
                    {
                        html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        totalSemana += ventaDia;
                        totalL += ventaDia; dias++;
                    }
                    else if (row["nombreDia"].ToString() == "Tuesday")
                    {
                        html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        totalSemana += ventaDia;
                        totalM += ventaDia; dias++;
                    }
                    else if (row["nombreDia"].ToString() == "Wednesday")
                    {
                        html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        totalSemana += ventaDia;
                        totalMi += ventaDia; dias++;
                    }
                    else if (row["nombreDia"].ToString() == "Thursday")
                    {
                        html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        totalSemana += ventaDia;
                        totalJ += ventaDia; dias++;
                    }
                    else if (row["nombreDia"].ToString() == "Friday")
                    {
                        html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        totalSemana += ventaDia;
                        totalV += ventaDia; dias++;
                    }
                    else if (row["nombreDia"].ToString() == "Saturday")
                    {
                        html += "<td title='" + title + "' " + (title.LastIndexOf("-01") >= 6 ? "bgcolor='#92c164'" : "") + "'>" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        totalSemana += ventaDia;
                        totalS += ventaDia; dias++;
                    }
                    else if (row["nombreDia"].ToString() == "Sunday")
                    {
                        html += "<td title='" + title + "' "+(title.LastIndexOf("-01")>=6? "bgcolor='#92c164'" : "")+">" + Convert.ToDecimal(row["venta"]).ToString("c0") + "</td>";
                        dias = 7;
                        cuentaSemanas++;
                        totalSemana += ventaDia;
                        html += "<td align='center' bgcolor='#6db23f'><font color='#fff'>" + (semana-1) + "</font></td>";
                        html += "<td>" + totalSemana.ToString("c0") + "</td>";
                        totalVenta += totalSemana;
                        totalD += ventaDia;
                        totalSemana = 0;
                    }
                    else
                        html += "<td></td>";

                }
            }
            if (dias > 0)
            {
                for (int x = dias; x < 7; x++)
                {
                    html += "<td></td>";
                    
                }
                totalVenta += totalSemana;
                html += "<td align='center' bgcolor='#6db23f'><font color='#fff'>" + (semana) + "</font></td>";
                html += "<td>" + totalSemana.ToString("c0") + "</td>"; cuentaSemanas++;
            }
            html += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td>";
            html += "<td  bgcolor='#000'><font color='#fff'>Total Venta</font></td><td bgcolor='#000'><font color='#fff'>" + totalVenta.ToString("c0") + "</font></td></tr>";
             html += "<tr>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalL.ToString("c0") + "</font></td>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalM.ToString("c0") + "</font></td>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalMi.ToString("c0") + "</font></td>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalJ.ToString("c0") + "</font></td>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalV.ToString("c0") + "</font></td>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalS.ToString("c0") + "</font></td>";
            html += "<td bgcolor='#6db23f'><font color='#fff'>" + totalD.ToString("c0") + "</font></td>";
            html += "<td  bgcolor='#6db23f'><font color='#fff'>Promedio</font></td><td bgcolor='#6db23f'><font color='#fff'>" + (cuentaSemanas> 0 ? totalVenta /cuentaSemanas: 1).ToString("c0") + "</font></td></tr>";
            html += "</tr>";
            html += "</tbody></table>";
            dt.Clear();
        }

        catch (Exception ex) { }
        return html;
    }

    [System.Web.Services.WebMethod]
    public static string ReporteConsolidadoVDS(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("vdsIndicadores", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
        }
        catch (Exception ex) { }
        return DataSetToJSON(table);
    }

    [System.Web.Services.WebMethod]
    public static string ReporteVentasPresupuesto(string f1, string f2, string sucursal)
    {
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        Form_Reportes form = new Form_Reportes();
         string html = "";
        DataTable dt = new DataTable(); try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 30);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            int cont = 0;
            decimal promedio = 0;
            decimal totalPromedio = 0;
            decimal porProm = 0;
            foreach (DataRow row in table.Rows)
            {
                promedio = 0;
                promedio = (Convert.ToDecimal(row["venta5"])+ Convert.ToDecimal(row["venta4"])+ Convert.ToDecimal(row["venta3"])+ Convert.ToDecimal(row["venta2"]))/4;
                totalPromedio += promedio;
                row["promedio"] = promedio;
            }
            for (int i = 0; i < table.Rows.Count; i++)
            {
                porProm = Convert.ToDecimal(table.Rows[i]["promedio"]) / totalPromedio;
                table.Rows[i]["porcentaje"] = porProm;
                //sumpronostico
                table.Rows[i]["sumpronostico"] = porProm * Convert.ToDecimal(table.Rows[i]["presupuesto"]);

                if(i == 0)
                {
                    //pres pronostico
                    table.Rows[i]["prespronostico"] = table.Rows[i]["sumpronostico"];
                }
                else
                {
                    //pres pronostico
                    table.Rows[i]["prespronostico"] = Convert.ToDecimal(table.Rows[i-1]["prespronostico"]) + Convert.ToDecimal(table.Rows[i]["sumpronostico"]);
                }
                //venta hora
                table.Rows[i]["varhora"] =Convert.ToDecimal(table.Rows[i]["sumpronostico"])<=0 ?0: Convert.ToDecimal( table.Rows[i]["venta1"])/Convert.ToDecimal( table.Rows[i]["sumpronostico"]);
                decimal totalprespronostico = 0;
                cont++;
                for (int j=0; j< cont; j++)
                {
                    totalprespronostico += Convert.ToDecimal(table.Rows[j]["venta1"]);
                }
                table.Rows[i]["varacum"] = Convert.ToDecimal(table.Rows[i]["prespronostico"]) <= 0 ? 0 : totalprespronostico / Convert.ToDecimal(table.Rows[i]["prespronostico"]);
                
            }
            DateTime hoy = Convert.ToDateTime(a1);
            html = "<table class='table tablaAdmin'>";
            html += "<tr>";
                html += "<th>" + "Hora";
                html += "</th>";            
                /*html += "<th>" + hoy.AddDays(-28).ToString("dd-MM-yyyy");
                html += "</th>";
                html += "<th>" + hoy.AddDays(-21).ToString("dd-MM-yyyy");
                html += "</th>";
                html += "<th>" + hoy.AddDays(-14).ToString("dd-MM-yyyy");
                html += "</th>";
                html += "<th>" + hoy.AddDays(-7).ToString("dd-MM-yyyy");
                html += "</th>";*/
                html += "<th>" + hoy.ToString("dd-MM-yyyy");
                html += "</th>";
                html += "<th>" + "var hora";
                html += "</th>";
                html += "<th>" + "var acum";
                html += "</th>";
                html += "<th>" + "Presupuesto";
                html += "</th>";
                html += "<th>" + "Porcentaje";
                html += "</th>";
                html += "<th>" + "Promedio";
                html += "</th>";
                html += "<th>" + "suma pron";
                html += "</th>";
                html += "<th>" + "Pres pron";
                html += "</th>";

            html += "</tr>";
            decimal venta1 = 0;
            decimal venta2 = 0;
            decimal venta3 = 0;
            decimal venta4 = 0;
            decimal venta5 = 0;
            decimal porcentaje = 0;
            decimal totalpromedio = 0;
            foreach (DataRow row in table.Rows)
            {
            html += "<tr>";
                html += "<td>"+ (Convert.ToInt32(row["hora"])== 24 ? "0" : Convert.ToInt32(row["hora"]) == 25 ? "1" : row["hora"]).ToString();
                html += "</td>";
               /* html += "<td>" +Convert.ToDecimal( row["venta5"]).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["venta4"]).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["venta3"]).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["venta2"]).ToString("c0");
                html += "</td>";*/
                html += "<td>" + Convert.ToDecimal(row["venta1"]).ToString("c0");
                html += "</td>";
                decimal res1 = Convert.ToDecimal(row["varhora"]) - 1;
                html += "<td><font color='" + (res1 >= 0 ? "#6DB23F" : "#C61E1E") + "'>" + Math.Abs(res1).ToString("p2") + "&nbsp;</font>" + "<img src='img/"+ (res1 >= 0 ? "arriba" : "abajo") + ".png' width='15/'>";
                html += "</td>";
                decimal res2 = Convert.ToDecimal(row["varhora"]) - 1;
                html += "<td><font color='"+(res2 >= 0 ? "#6DB23F" : "#C61E1E") +"'>" +Math.Abs( res2).ToString("p2")+ "&nbsp;</font>" + " <img src='img/"+ (res2 >= 0 ? "arriba" : "abajo") + ".png' width='15' /> ";
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["presupuesto"]).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["porcentaje"]).ToString("p2");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["promedio"]).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["sumpronostico"]).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(row["prespronostico"]).ToString("c0");
                html += "</td>";
                /*venta5 += Convert.ToDecimal(row["venta5"]);
                venta4 += Convert.ToDecimal(row["venta4"]);
                venta3 += Convert.ToDecimal(row["venta3"]);
                venta2 += Convert.ToDecimal(row["venta2"]);*/
                venta1 += Convert.ToDecimal(row["venta1"]);
                porcentaje += Convert.ToDecimal(row["porcentaje"]);
                totalpromedio += Convert.ToDecimal(row["promedio"]);
            html += "</tr>";
            }
            html += "<tr bgcolor='#ededed'>";
                html += "<td>" ;
                html += "</td>";
               /* html += "<td>" + Convert.ToDecimal(venta5).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(venta4).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(venta3).ToString("c0");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(venta2).ToString("c0");
                html += "</td>";*/
                html += "<td>" + Convert.ToDecimal(venta1).ToString("c0");
                html += "</td>";
                html += "<td>";
                html += "</td>";
                html += "<td>" ;
                html += "</td>";
                html += "<td>";
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(porcentaje).ToString("p2");
                html += "</td>";
                html += "<td>" + Convert.ToDecimal(totalpromedio).ToString("c0");
                html += "</td>";
                html += "<td>" ;
                html += "</td>";
                html += "<td>" ;
                html += "</td>";
                html += "</tr>";
            html += "</table>";
        }

        catch (Exception ex) { }
        return html;
        //return DataSetToJSON(dt);
    }

    public static string DataSetToJSON(DataTable dt)
    {
        List<object> dict = new List<object>();
        object[] arr = new object[dt.Rows.Count + 1];
        for (int i = 0; i <= dt.Rows.Count - 1; i++)
        {
            arr[i] = dt.Rows[i].ItemArray;
        }
        dict.Add(arr);
        JavaScriptSerializer json = new JavaScriptSerializer();
        return json.Serialize(dict);
    }
}

public class Fecha
{
    int fechaEntero;
    string fechaCadena;

    public int FechaEntero { get => fechaEntero; set => fechaEntero = value; }
    public string FechaCadena { get => fechaCadena; set => fechaCadena = value; }
}
public class PromedioFecha
{
    decimal promedio;
    string cadena;

    public decimal Promedio { get => promedio; set => promedio = value; }
    public string Cadena { get => cadena; set => cadena = value; }
}