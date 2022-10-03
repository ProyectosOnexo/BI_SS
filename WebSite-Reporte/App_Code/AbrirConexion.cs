using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Configuration;

public class AbrirConexion
{
    public SqlConnection miconexion = new SqlConnection("Data Source=172.20.250.66;Initial Catalog=Reportes2;user id =usrbishake; password =$.Shake2022;");
    string connectionString = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
    //public SqlConnection miconexion = new SqlConnection(ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString);
    public SqlCommand comando = new SqlCommand();
    public SqlDataReader reader;

    public void Conectar()
    {
        miconexion.Open();
    }

    public void Desconectar()
    {
        miconexion.Close();
    }
}