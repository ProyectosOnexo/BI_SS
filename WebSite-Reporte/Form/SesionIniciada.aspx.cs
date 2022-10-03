using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_SesionIniciada : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static Res ConsultaDashboard(string f1, string f2, string tienda)
    {
        Res res = new Res();
        Form_SesionIniciada form = new Form_SesionIniciada();
        Conexion conexion = new Conexion();

        DataTable table = new DataTable();
        SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

        DateTime FechaModificada = DateTime.Parse(f1);
        string a1 = FechaModificada.ToString("yyyy-MM-dd");
        DateTime FechaModificada2 = DateTime.Parse(f2);
        string a2 = FechaModificada2.ToString("yyyy-MM-dd");

        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@consulta", 5);
        command.Parameters.AddWithValue("@f3", a1);
        command.Parameters.AddWithValue("@f4", a2);
        command.Parameters.AddWithValue("@tienda", tienda);
        command.CommandTimeout = 0;
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = command;
        adapter.Fill(table);

        Tabla tabla;
        List<Tabla> listTabla = new List<Tabla>();
        foreach (DataRow row in table.Rows)
        {
            tabla = new Tabla();
            tabla.Sucursal = row["nombre"].ToString();
            tabla.VentaNeta = row["VentaNeta"].ToString();
            tabla.VentaBruta = row["VentaBruta"].ToString();
            tabla.Tickets = row["transacciones"].ToString();
            listTabla.Add(tabla);
        }
        res.ListTabla = listTabla;
        return res;
    }

}