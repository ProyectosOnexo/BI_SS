using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_LoginOrden : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static string Login(string correo, string password)
    {
        Form_LoginOrden form = new Form_LoginOrden();
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        string respuesta = "";
        SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
        try
        {
            //string a1 = "2019-09-10";
            string nombreUsuario = "";
            string correoUsuario = "";
            string nombre = "";
            int id = 0;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 33);
            command.Parameters.AddWithValue("@correoOrden", correo);
            command.Parameters.AddWithValue("@contrasenaOrden", password);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            int res = table.Rows.Count;
            if (res > 0)
            {
                respuesta = "OK";
                foreach (DataRow row in table.Rows)
                {
                    nombreUsuario = row["nombre"].ToString();
                    correoUsuario = row["correo"].ToString();
                    nombre = row["nombre"].ToString();
                    id = Convert.ToInt32(row["id"]);
                }
                form.Session["CorreoOrden"] = correoUsuario;
                form.Session["NombreOrden"] = nombre;
                form.Session["IdOrden"] = id;
            }
            else
                respuesta = "Datos incorrectos";
        }
        catch (Exception ex) { respuesta = ex.Message.ToString(); }
        return respuesta;
    }
}