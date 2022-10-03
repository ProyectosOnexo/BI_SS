using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_Inicio : BasePage
{
    AbrirConexion conexion = new AbrirConexion();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SesionCorreo"] != null && Session["SesionContraseña"] != null)
        {
            Response.Redirect("Form/Ventas.aspx");
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
        
    }


    public void IniciarSesion_Click(object sender, EventArgs e)
    {
        IniciarSesion();
    }

    public void IniciarSesion()
    {
        string correo = Request.Form["correo"];
        string Contraseña = Request.Form["contrasena"];

        conexion.comando.Connection = conexion.miconexion;
        conexion.comando.CommandText = "SELECT correo,contrasena,nombre,rol,id FROM Usuarios WHERE correo = '" + correo + "' AND contrasena = '" + Contraseña + "' and estado < 4";
        conexion.Conectar();
        conexion.comando.CommandType = CommandType.Text;

        conexion.reader = conexion.comando.ExecuteReader();
        if (conexion.reader.Read())
        {
            string CorreoObtenido = conexion.reader["correo"].ToString();
            string nombre = conexion.reader["nombre"].ToString();
            string rol = conexion.reader["rol"].ToString();
            string ContraseñaObtenida = conexion.reader["contrasena"].ToString();
            string IdUsuario = conexion.reader["id"].ToString();
            if (CorreoObtenido == correo)
            {
                if (ContraseñaObtenida == Contraseña)
                {
                    conexion.reader.Close();
                    conexion.comando.Dispose();
                    conexion.Desconectar();
                    Session["Nombre"] = nombre;
                    Session["Rol"] = rol;
                    Session["SesionCorreo"] = CorreoObtenido;
                    Session["SesionContraseña"] = ContraseñaObtenida;
                    Session["ID"] = IdUsuario;

                    Response.Redirect("Form/Ventas.aspx");
                }
                else
                {
                    conexion.reader.Close();
                    conexion.comando.Dispose();
                    conexion.Desconectar();
                    Response.Redirect("index.aspx");
                }
                
            }
            else
            {
                conexion.reader.Close();
                conexion.comando.Dispose();
                conexion.Desconectar();
                Response.Redirect("index.aspx");

            }
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myModal", "ShowModal ()", true);
        }

    }

    public bool ComprobarCorreoEscrito(string correo)
    {
        bool Valor = false;
        string CorreoElectrinico = correo;

        conexion.comando.Connection = conexion.miconexion;
        conexion.comando.CommandText = "SELECT correo FROM Usuarios WHERE correo = '" + CorreoElectrinico + "' ";
        conexion.miconexion.Open();
        conexion.comando.CommandType = CommandType.Text;

        conexion.reader = conexion.comando.ExecuteReader();
        if (conexion.reader.Read())
        {
            conexion.reader.Close();
            conexion.comando.Dispose();
            conexion.miconexion.Close();
            Valor = true;
        }
        else
        {
            conexion.reader.Close();
            conexion.comando.Dispose();
            conexion.miconexion.Close();
            Valor = false;
        }
        return Valor;
    }
    [System.Web.Services.WebMethod]
    public static string EnviarCorreoElectronico_Click(string RecibirCorreo)
    {
        Form_Inicio form = new Form_Inicio();
        string respuesta = "";
        if (form.ComprobarCorreoEscrito(RecibirCorreo) == true)
        {
            string CorreoElectrinico1 = RecibirCorreo;
            respuesta =form.EnviarCorreo(CorreoElectrinico1);
        }
        else
        {
            respuesta = "Problemas al recibir el correo";
        }
        return respuesta;
    }

    public string EnviarCorreo(string Correo)
    {
        string Contrasena;
        string respuesta = "OK";
        conexion.comando.Connection = conexion.miconexion;
        conexion.comando.CommandText = "SELECT contrasena FROM Usuarios WHERE correo = '" + Correo + "' ";
        conexion.comando.CommandType = CommandType.Text;

        conexion.Conectar();
        conexion.reader = conexion.comando.ExecuteReader();

        if (conexion.reader.Read())
        {
            Contrasena = conexion.reader["contrasena"].ToString();

            conexion.comando.Dispose();
            conexion.Desconectar();

            string correoRecibido = Correo;
            System.Net.Mail.MailMessage msg = new MailMessage();
            msg.To.Add(correoRecibido);
            msg.From = new MailAddress("soportesoporte586@gmail.com", "SOPORTE", System.Text.Encoding.UTF8);
            msg.Subject = "Recuperación de contraseña";
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "Hola buen día, hemos recibido una petición suya para recuperar sus datos, lamentamos que este\n" +
            " teniendo problemas para poder ingresar al sistema.\n" +
            "Contraseña: " + Contrasena;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = false;

            //Aquí es donde se hace lo especial
            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("soportesoporte586@gmail.com", "eks2019-");
            client.Port = 587;
            client.Host = "smtp.gmail.com";
            client.EnableSsl = true;
            try
            {
                client.Send(msg);
                ClientScript.RegisterStartupScript(this.GetType(), "ModalCorreoEnviado", "ModalCorreoEnviado ()", true);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
               respuesta = ex.Message;                
            }
        }
        return respuesta;
    }


    protected void btnRegistro_Click(object sender, EventArgs e)
    {
        Response.Redirect("FormRegistrarUsuario.aspx");
    }
}