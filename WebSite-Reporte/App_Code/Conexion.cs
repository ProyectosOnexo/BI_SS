using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;

public class Conexion
{

    //private string connectionString = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
    private string connectionString = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
    public SqlConnection miconexion = new SqlConnection("Data Source=172.20.250.66;Initial Catalog=Reportes2;user id =usrbishake; password =$.Shake2022;");
    //SqlConnection conection = new SqlConnection(ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString);
    SqlConnection conection = new SqlConnection("Data Source=172.20.250.66;Initial Catalog=Reportes2;user id =usrbishake; password =$.Shake2022;");
    public SqlCommand comando = new SqlCommand();
    public SqlDataReader reader;

    public SqlConnection Conection { get => conection; set => conection = value; }
    public string ConnectionString { get => connectionString; set => connectionString = value; }

    public void Conectar()
    {
        miconexion.Open();
    }

    public void Desconectar()
    {
        miconexion.Close();
    }
}