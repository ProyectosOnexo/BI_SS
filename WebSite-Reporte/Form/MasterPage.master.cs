using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario.Text = "&nbsp;&nbsp;"+(String)(Session["Nombre"]);
        string rol = (String)(Session["Rol"]);
        if(rol== "superusuario")
        {
            liAdmin.Visible = true;
            //liTiendas.Visible = true;
            li1.Visible = true;
        }
        else
        {
            liAdmin.Visible = false;
            //liTiendas.Visible = false;
            li1.Visible = false;
        }
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
    public void CerrarSesion_Click(object sender, EventArgs e)
    {
        //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowModal();", true);
        RemoverSesion();
    }

    //METODO QUE PERMITE REMOVER LA SESION
    public void RemoverSesion()
    {
        Session.Remove("Nombre");
        Session.Remove("Rol");
        Session.Remove("SesionCorreo");
        Session.Remove("SesionContraseña");
        Response.Redirect("../index.aspx");
    }
}
