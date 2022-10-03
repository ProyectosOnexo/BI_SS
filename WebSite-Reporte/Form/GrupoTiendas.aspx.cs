using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_GrupoTiendas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["nombre"] != null)
        {
            int a = 2;
            /*if (string.IsNullOrEmpty(Convert.ToString(Session["lang"])))
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
            }*/
        }
        else
        {
            Response.Redirect("../Index.aspx");
        }
    }
    [System.Web.Services.WebMethod]
    public static List<Tabla> ConsultaSucursales(int grupo)
    {
        List<Tabla> lista = new List<Tabla>();
        Tabla sucursal;
        Conexion conexion = new Conexion();
        try
        {
            DataTable table = new DataTable();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 17);
            command.Parameters.AddWithValue("@id", grupo);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                sucursal = new Tabla();
                sucursal.Sucursal = row["nombre"].ToString();
                sucursal.Id = Convert.ToInt32(row["id"]);
                sucursal.Estado = Convert.ToInt32(row["estado"]);
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
    public static List<Tabla> SucursalesGrupo(int grupo)
    {
        List<Tabla> lista = new List<Tabla>();
        Tabla sucursal;
        Conexion conexion = new Conexion();
        try
        {
            DataTable table = new DataTable();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 15);
            command.Parameters.AddWithValue("@id", grupo);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                sucursal = new Tabla();
                sucursal.Sucursal = row["nombre"].ToString();
                sucursal.Id = Convert.ToInt32(row["id"]);
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
    public static string GuardarGrupos(int id,string grupo, string sucursales)
    {
        string res = "";
        try
        {
            string[] suc = sucursales.Trim(',').Split(',');
            Conexion conexion = new Conexion();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 11);
            command.Parameters.AddWithValue("@id", id);
            command.Parameters.AddWithValue("@nombre", grupo.ToUpper());
            command.Connection.Open();
            int res2 = Convert.ToInt32( command.ExecuteScalar());
            command.Connection.Close();
            foreach (var item in suc)
            {
                command = new SqlCommand("sp_solicitudes", conexion.Conection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@consulta", 16);
                command.Parameters.AddWithValue("@id", res2);
                command.Parameters.AddWithValue("@id_local", item);
                command.Connection.Open();
                command.ExecuteNonQuery();
                res = "Guardado correctamente";
                command.Connection.Close();
            }
        }
        catch (Exception ex)
        {
            return ex.Message.ToString();
        }
        return res;
    }

    [System.Web.Services.WebMethod]
    public static string EliminarGrupos(int grupo)
    {
        string res = "";
        try
        {
            Conexion conexion = new Conexion();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 12);
            command.Parameters.AddWithValue("@id", grupo);
            command.Connection.Open();
            int res2 = command.ExecuteNonQuery();
            command.Connection.Close();
            res= "Ejecutado correctamente";
        }
        catch (Exception ex)
        {
            return ex.Message.ToString();
        }
        return res;
    }

    [System.Web.Services.WebMethod]
    public static List<Tabla> ConsultaGrupos()
    {
        List<Tabla> lista = new List<Tabla>();
        Tabla sucursal;
        Conexion conexion = new Conexion();
        try
        {
            DataTable table = new DataTable();
            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 10);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                sucursal = new Tabla();
                sucursal.Sucursal = row["nombre"].ToString();
                sucursal.Id = Convert.ToInt32(row["id"]);
                lista.Add(sucursal);
            }
        }
        catch (Exception ex)
        {
            return lista;
        }

        return lista;
    }
}
