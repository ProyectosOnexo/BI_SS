using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_DetalleVenta : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string fecha = Request.QueryString["fecha"];
        string fechaSesion =(string) Session["fecha"];
        string sucursal = Request.QueryString["sucursal"];
        string sucursalSesion =(string) Session["sucursal"];
        string ID = (string)(Session["ID"]);
        Session["sucursal"] = sucursal != null ? sucursal : sucursalSesion;
        Session["fecha"] = fecha != null ? fecha : fechaSesion;
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
    public static string Cuadros(string f1,string f2,int sucursal)
    {
        Conexion conexion = new Conexion();
        List<Reporte> lista = new List<Reporte>();
        DataTable table = new DataTable();
        Form_DetalleVenta form = new Form_DetalleVenta();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            DateTime FechaModificada = DateTime.Parse(f1);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(f2);
            string a2 = FechaModificada.ToString("yyyy-MM-dd");

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 17);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha", a2);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.Parameters.AddWithValue("@idSucursal", sucursal);
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
}