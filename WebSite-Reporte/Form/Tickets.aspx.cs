using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Tickets : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string fecha1 = Request.QueryString["fecha1"];
        string fechaSesion = (string)Session["fecha1"];
        //string fecha2 = Request.QueryString["fecha2"];
        string sucursal = Request.QueryString["sucursal"];
        string sucursalSesion = (string)Session["sucursal"];
        string consulta = Request.QueryString["consulta"];
        string ID = (string)(Session["ID"]);
        Session["sucursal"] = sucursal != null ? sucursal : sucursalSesion;
        Session["fecha"] = fecha1 != null ? fecha1 : fechaSesion;
        // Session["fecha2"] = fecha2;
        Session["consulta"] = consulta;
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
    public static string MuestraTickets(string f1, string sucursal,string consulta)
    {
        Conexion conexion = new Conexion();
        List<Reporte> lista = new List<Reporte>();
        DataTable table = new DataTable();
        Form_Tickets form = new Form_Tickets();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            /*DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");*/
            string inicioAux = f1.Split('-')[0].Trim();
            string finAux = f1.Split('-')[1].Trim();
            string inicio = inicioAux.Split('/')[2] + "-" + inicioAux.Split('/')[1] + "-" + inicioAux.Split('/')[0];
            string fin = finAux.Split('/')[2] + "-" + finAux.Split('/')[1] + "-" + finAux.Split('/')[0];
            int idlocal = form.ObtenerId(sucursal);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", consulta);
            command.Parameters.AddWithValue("@fecha", inicio);
            command.Parameters.AddWithValue("@fecha2", fin);
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
}