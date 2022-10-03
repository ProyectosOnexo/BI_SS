using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Ventas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ID = (string)(Session["ID"]);
        string rol = (String)(Session["Rol"]);

        string fechaSesion = (string)Session["fecha"];

        Session["fecha"] = fechaSesion;
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
    public static string InicioVentas(string f1 )
    {
        Conexion conexion = new Conexion();
        List<Reporte> lista = new List<Reporte>();
        DataTable table = new DataTable();
        Form_Ventas form = new Form_Ventas();
        try
        {
            string ID = (string)(form.Session["ID"]);
            SqlCommand command = new SqlCommand("sp_dash2", conexion.Conection);
           // DateTime FechaModificada = DateTime.Parse(f1);
            //string a1 = FechaModificada.ToString("yyyy-MM-dd");
            string inicioAux = f1.Split('-')[0].Trim();
            string finAux = f1.Split('-')[1].Trim();
            string inicio = inicioAux.Split('/')[2] + "-" + inicioAux.Split('/')[1] + "-" + inicioAux.Split('/')[0];
            string fin = finAux.Split('/')[2] + "-" + finAux.Split('/')[1] + "-" + finAux.Split('/')[0];
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 16);
            command.Parameters.AddWithValue("@fecha", inicio);
            command.Parameters.AddWithValue("@fecha2", fin);
            command.Parameters.AddWithValue("@idUsuario", ID);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);               
        }
        catch (Exception ex) { }
        return table.Rows.Count > 0?  DataSetToJSON(table):"";
    }
    public static string DataSetToJSON(DataTable dt)
    {

        List<object> dict = new List<object>();            
        object[] arr = new object[dt.Rows.Count + 1];
        for (int i = 0; i <= dt.Rows.Count - 1; i++)
        {
            arr[i] = dt.Rows[i].ItemArray;
        }
        dict.Add( arr);       
        JavaScriptSerializer json = new JavaScriptSerializer();
        return json.Serialize(dict);
    }
}