using QRCoder;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_ResgistroOrden : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static string Registro(string nombre, string telefono,string correo, string password)
    {
        Form_ResgistroOrden form = new Form_ResgistroOrden();
        Conexion conexion = new Conexion();
        DataTable table = new DataTable();
        string respuesta = "";
        SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
        try
        {
            //string a1 = "2019-09-10";
            string nombreUsuario = "";
            string correoUsuario = "";
            string nombreusuario = "";
            int id = 0;
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 35);
            command.Parameters.AddWithValue("@correoOrden", correo);
            command.Parameters.AddWithValue("@contrasenaOrden", password);
            command.Parameters.AddWithValue("@telefonoOrden", telefono);
            command.Parameters.AddWithValue("@nombreOrden", nombre);
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
                    nombreusuario = row["nombre"].ToString();
                    id = Convert.ToInt32(row["id"]);
                }
                form.Session["CorreoOrden"] = correoUsuario;
                form.Session["NombreOrden"] = nombreusuario;
                form.Session["IdOrden"] = id;
            }
            else
                respuesta = "Datos incorrectos";
        }
        catch (Exception ex) { respuesta = ex.Message.ToString(); }
        return respuesta;
    }

}