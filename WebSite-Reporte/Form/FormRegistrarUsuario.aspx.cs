using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_FormRegistrarUsuario :BasePage
{
    Conexion conexion = new Conexion();
    //string CorreoObtendido;
    protected void Page_Load(object sender, EventArgs e)
    {
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
            Response.Redirect("Dashboard.aspx");
        }
        else
        {
            
        }
    }

    [System.Web.Services.WebMethod]
    public static string Registro(string nombre, string contrasena, string correo)
    {
        Form_FormRegistrarUsuario a1 = new Form_FormRegistrarUsuario();
        string respuesta = a1.InsertarUsuario2(nombre,contrasena,correo);
        return respuesta;
    }
    public void RegistrarUsuario_Click(object sender, EventArgs e)
    {
        if (ComprobarCorreo() == true)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowModalValidarUsuario();", true);
        }
        else
        {
            InsertarUsuario();                     
        }
    }

    public void BtnUsuarioRegistrado_Click(object sender, EventArgs e)
    {
        Response.Redirect("../index.aspx");
    }
    public string InsertarUsuario2(string nombre,string contrasena,string correo)
    {
        try
        {
            string fecha = DateTime.Now.ToShortDateString();

            //conexion.comando.Connection = conexion.miconexion;
            //conexion.comando.CommandText = "INSERT INTO usuarios(nombre,rol,correo,fecha,estado,contrasena) VALUES(@nombre,@rol,@correo,getdate(),0,@contrasena)";

            //conexion.miconexion.Open();
            //conexion.comando.Parameters.Clear();
            //conexion.comando.Parameters.AddWithValue("@contrasena", contrasena);
            //conexion.comando.Parameters.AddWithValue("@rol", "usuario");
            //conexion.comando.Parameters.AddWithValue("@nombre", nombre);
            //conexion.comando.Parameters.AddWithValue("@correo", correo);
            //conexion.comando.Parameters.AddWithValue("@fecha", fecha);

            SqlCommand command = new SqlCommand("sp_solicitudes", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 19);
            command.Parameters.AddWithValue("@rol", "usuario");
            command.Parameters.AddWithValue("@contrasenha", contrasena);
            command.Parameters.AddWithValue("@nombre",nombre);
            command.Parameters.AddWithValue("@correo", correo);
            command.Connection.Open();

            int NFilas =command.ExecuteNonQuery();
            if (NFilas > 0)
            {
                conexion.comando.Dispose();
                conexion.miconexion.Close();

                NuevoRegistroCorreo(nombre, correo);
                //NuevoRegistroCorreo(nombre,"alan.acuitlapa@gmail.com");
                //CorreoObtendido = nombrecompleto.Value.ToString();
                //Session["Correo"] = CorreoObtendido;
                //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ModalUsuarioRegistrado()", true);
                return "exitoso";
            }
            else
            {
                conexion.comando.Dispose();
                conexion.miconexion.Close();
                return "error";
            }
        }
        catch (Exception ex) { return "Es posible que el usuario que el correo ya este registrado"; }
    }

    public void InsertarUsuario()
    {
        string fecha = DateTime.Now.ToShortDateString();

        conexion.comando.Connection = conexion.miconexion;
        conexion.comando.CommandText = "INSERT INTO Usuarios(contrasena,rol,nombre,correo,fecha) VALUES(@contrasena,@rol,@nombre,@correo,getdate())";
        conexion.miconexion.Open();
        conexion.comando.Parameters.Clear();
        conexion.comando.Parameters.AddWithValue("@contrasena", contrasena.Value.ToString());
        conexion.comando.Parameters.AddWithValue("@rol", tipousuario.SelectedIndex == 0 ? "uninformed" :
        tipousuario.Items[tipousuario.SelectedIndex].Text);
        conexion.comando.Parameters.AddWithValue("@nombre", nombrecompleto.Value.ToString());
        conexion.comando.Parameters.AddWithValue("@correo", correo.Value.ToString());
        //conexion.comando.Parameters.AddWithValue("@fecha", fecha);

        int NFilas = conexion.comando.ExecuteNonQuery();
        if (NFilas > 0)
        {
            conexion.comando.Dispose();
            conexion.miconexion.Close();

            NuevoRegistroCorreo(nombrecompleto.Value.ToString(),correo.Value.ToString());
            //CorreoObtendido = nombrecompleto.Value.ToString();
            //Session["Correo"] = CorreoObtendido;
            //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ModalUsuarioRegistrado()", true);

        }
        else
        {
            conexion.comando.Dispose();
            conexion.miconexion.Close();
        }
    }

    public bool ComprobarCorreo()
    {
        bool Valor = false;
        string CorreoElectrinico = Request.Form["correo"];
        
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

    public void NuevoRegistroCorreo(string nombre,string correo)
    {
        //string Contrasena;

        //conexion.comando.Connection = conexion.miconexion;
        //conexion.comando.CommandText = "SELECT correo FROM Usuarios WHERE rol = 'Administrador' ";
        //conexion.comando.CommandType = CommandType.Text;

        //conexion.Conectar();
        //conexion.reader = conexion.comando.ExecuteReader();

        //if (conexion.reader.Read())
        //{
        //Contrasena = conexion.reader["contrasena"].ToString();

        //conexion.comando.Dispose();
        //conexion.Desconectar();

        string correoRecibido = correo;//"alan.acuitlapa@gmail.com"; //RecibirCorreo.Value.ToString();
        System.Net.Mail.MailMessage msg = new MailMessage();
            msg.To.Add(correoRecibido);
            msg.From = new MailAddress("soportesoporte586@gmail.com", "Web Master", System.Text.Encoding.UTF8);
            msg.Subject = "Nueva solicitud";
            msg.SubjectEncoding = System.Text.Encoding.UTF8;

        LinkedResource LinkedImage = new LinkedResource(Server.MapPath("~/Form/img/Logo.png"));
        LinkedImage.ContentId = "MyPic";
        LinkedImage.ContentType = new ContentType(MediaTypeNames.Image.Jpeg);

        LinkedResource LinkedImage2 = new LinkedResource(Server.MapPath("~/Form/img/Icono_mailing.gif"));
        LinkedImage2.ContentId = "MyPic2";
        LinkedImage2.ContentType = new ContentType(MediaTypeNames.Image.Jpeg);

        AlternateView htmlView = AlternateView.CreateAlternateViewFromString(
         "<html><head>    <meta charset=\"utf-8\" />    <title></title> </head><body>    <div style=\"width:100%; max-width: 400px\">        <hr style=\"height: 10px;background-color:#6db23f;border:1px solid #6db23f\"/>        <div style=\"border-bottom:1px solid #939393;margin: 25px 50px 30px 50px;padding-bottom: 25px;\">            <img style=\"height:43px;margin-left: auto; margin-right: auto; display: block;\" src=cid:MyPic>        </div><div style=\"color:#606060;font-family:Calibri;float:left;margin: 0 50px 0 50px;text-align:center;width:80%;font-weight:bold;font-size:22px\">            Hola buen día     </div> <div style =\"color:#939393;font-family:Calibri;float:left;margin: 25px 50px 30px 50px;text-align:center\">  Hemos recibido una <span style=\"color:#606060\"> solicitud para poder ingresar al sistema,</span> por favor ingrese a su panel de administrador donde podrá <span style=\"color:#606060\" > aceptar ó rechazar </span> la petición recibida <p>Nombre: "+ nombre + "</p>       </div>         <div>            <a href=\"http://201.147.17.215:6060/shake/index.aspx\"><img style=\"height:100px;margin-left: auto; margin-right: auto; display: block;\" src=cid:MyPic2> </a>       </div>        <hr style=\"height: 10px;background-color:#6db23f;border:1px solid #6db23f\"/>    </div></body></html>",
          null, "text/html");
        htmlView.TransferEncoding = System.Net.Mime.TransferEncoding.Base64;
        htmlView.LinkedResources.Add(LinkedImage);
        htmlView.LinkedResources.Add(LinkedImage2);

        msg.AlternateViews.Add(htmlView);

        msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = true;

            //Aquí es donde se hace lo especial
            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("soportesoporte586@gmail.com", "eks2019-");
            client.Port = 587;
            client.Host = "smtp.gmail.com";
            client.EnableSsl = true;
            try
            {
                client.Send(msg);
                //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowEnviarCorreo();", true);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
            }
        //}
    }
    public string CreateBody()
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/Form/Registro.html")))
        {
            body = reader.ReadToEnd();
        }
            return body;
    }
    public void RecuperarContrasena_Click(object sender, EventArgs e)
    {
        string Contrasena;

        conexion.comando.Connection = conexion.miconexion;
        conexion.comando.CommandText = "SELECT contrasena FROM Usuarios WHERE correo = '" + RecibirCorreo.Value.ToString() + "' ";
        conexion.comando.CommandType = CommandType.Text;

        conexion.Conectar();
        conexion.reader = conexion.comando.ExecuteReader();

        if (conexion.reader.Read())
        {
            Contrasena = conexion.reader["contrasena"].ToString();

            conexion.comando.Dispose();
            conexion.Desconectar();

            string correoRecibido = RecibirCorreo.Value.ToString();
            System.Net.Mail.MailMessage msg = new MailMessage();
            msg.To.Add(correoRecibido);
            msg.From = new MailAddress("soportesoporte586@gmail.com", "Web Master", System.Text.Encoding.UTF8);
            msg.Subject = "Recuperacion de contraseña";
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "Hola buen dia, hemos recibido una peticion suya para recuperar sus datos, lamentamos que este\n" +
            " teniendo problemas para poder ingresar al sistema. " +
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
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowEnviarCorreo();", true);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
            }
        }

        
    }

    
}