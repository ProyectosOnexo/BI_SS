using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_ForReportesInicio : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
           
        //if (Session["Correo"] != null)
        //{
        //    try
        //    {
        //        Usuario.Text = (string)(Session["Correo"]);
        //    }
        //    catch (Exception)
        //    {
        //        Response.Redirect("index.aspx");

        //    }
        //}
        //else
        //{
        //    Response.Redirect("index.aspx");
        //}
    }

    public void CerrarSesion_Click(object sender, EventArgs e)
    {
        //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowModal();", true);
        RemoverSesion();
    }


    public void RemoverSesion()
    {
        Session.Remove("Correo");
        Response.Redirect("index.aspx");
    }
}