using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class Form_ConfigWeb : System.Web.UI.Page
{
    string NombreCadena = "ToksBdConnectionString";
    string ObtenerCadenaConexion;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BtnClick_Click(object sender, EventArgs e)
    {
        CambiarCadenaConexion(NombreCadena);
    }

    void CrearNuevaCadenaDeConexion(string servidor, string basededatos, string usuarioid, string contraseña)
    {
        string str = "server=" + servidor + ";database=" + basededatos + "; User ID=" + usuarioid + "; Password=" + contraseña + "";
        System.Configuration.Configuration Config1 = WebConfigurationManager.OpenWebConfiguration("~");
        ConnectionStringsSection conSetting = (ConnectionStringsSection)Config1.GetSection("connectionStrings");
        ConnectionStringSettings StringSettings = new ConnectionStringSettings("ConexionString", "Data Source=" + servidor + ";Initial Catalog=" + basededatos + ";Integrated Security=" + "True", "System.Data.SqlClient");
        conSetting.ConnectionStrings.Remove(StringSettings);
        conSetting.ConnectionStrings.Add(StringSettings);
        Config1.Save(ConfigurationSaveMode.Modified);
    }

    private void CambiarCadenaConexion(string nameCadenaConexion)
    {
        bool isNew = false;
        string path = Server.MapPath("~/Web.Config");
        XmlDocument doc = new XmlDocument();
        doc.Load(path);
        XmlNodeList list = doc.DocumentElement.SelectNodes(string.Format("connectionStrings/add[@name='{0}']", nameCadenaConexion));
        XmlNode node;
        isNew = list.Count == 0;
        if (isNew)
        {
            node = doc.CreateNode(XmlNodeType.Element, "add", null);
            XmlAttribute attribute = doc.CreateAttribute("name");
            attribute.Value = nameCadenaConexion;
            node.Attributes.Append(attribute);

            attribute = doc.CreateAttribute("connectionString");
            attribute.Value = "";
            node.Attributes.Append(attribute);

            attribute = doc.CreateAttribute("providerName");
            attribute.Value = "System.Data.SqlClient";
            node.Attributes.Append(attribute);
        }
        else
        {
            node = list[0];
        }
        string conString = node.Attributes["connectionString"].Value;
        SqlConnectionStringBuilder conStringBuilder = new SqlConnectionStringBuilder(conString);
        conStringBuilder.InitialCatalog = "Reportes";
        conStringBuilder.DataSource = "DESKTOP-ETANEFB";
        conStringBuilder.IntegratedSecurity = false;
        conStringBuilder.UserID = "";
        conStringBuilder.Password = "";
        node.Attributes["connectionString"].Value = conStringBuilder.ConnectionString;
        if (isNew)
        {
            doc.DocumentElement.SelectNodes("connectionStrings")[0].AppendChild(node);
        }
        doc.Save(path);
    }

    public void ObtenerTodaLaCadenaDeConexionConfig()
    {
        //Obtener la cadena de conexion del web.conf actual
        ObtenerCadenaConexion = ConfigurationManager.ConnectionStrings["ToksBdConnectionString"].ConnectionString;
        //Mandar mensaje por pantalla  
        Response.Write(ObtenerCadenaConexion);
    }
    
}