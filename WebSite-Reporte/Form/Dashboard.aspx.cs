using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Dashboard : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string fecha1 = Request.QueryString["fecha1"];
            string fechaSesion = (string)Session["fecha1"];
            string sucursal = Request.QueryString["sucursal"];
            string sucursalSesion = (string)Session["sucursal"];
            string ID = (string)(Session["ID"]);
            Session["sucursal"] = sucursal != null ? sucursal : sucursalSesion;
            Session["fecha"] = fecha1 != null ? fecha1 : fechaSesion;
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


            //if (!this.IsPostBack)
            //{
            //    DataTable dt = this.GetData("select * from UbicacionShack");
            //    rptMarkers.DataSource = dt;
            //    rptMarkers.DataBind();
            //}

            if (Session["SesionCorreo"] != null && Session["SesionContraseña"] != null)
            {
                if (string.IsNullOrEmpty(Convert.ToString(Session["lang"])))
                {
                    hlEnglish1.Visible = true;
                    hlSpanish1.Visible = false;
                }
                else
                {
                    string lang = Session["lang"].ToString();

                    if (lang.Equals("en"))
                    {
                        hlEnglish1.Visible = false;
                        hlSpanish1.Visible = true;
                    }
                    else
                    {
                        hlEnglish1.Visible = true;
                        hlSpanish1.Visible = false;
                    }
                }
            }
            else
            {
                Response.Redirect("../Index.aspx");
            }
        }
        catch (Exception ex) { }
    }

    private DataTable GetData(string query)
    {
        string conString = ConfigurationManager.ConnectionStrings["ToksBdConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand(query);
        using (SqlConnection con = new SqlConnection(conString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;

                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    return dt;
                }
            }
        }
    }
}