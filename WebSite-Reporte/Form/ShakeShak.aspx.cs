using QRCoder;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_ShakeShak : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static List<Producto> BuscarOrden(string a)
    {

        Form_ShakeShak form = new Form_ShakeShak();
        Conexion conexion = new Conexion();
        List<Producto> lista = new List<Producto>();
        List<Producto> listaAux = new List<Producto>();
        listaAux = (List<Producto>)form.Session["Productos"];
        if (listaAux != null)
            lista = (List<Producto>)form.Session["Productos"];
        else
            lista = new List<Producto>();

        form.Session["Productos"] = lista;
        return lista;
    }

    [System.Web.Services.WebMethod]
    public static List<Producto> GetProductos(string linea)
    {
        Conexion conexion = new Conexion();
        List<Producto> lista = new List<Producto>();
        List<ModificadorAux> listaModif = new List<ModificadorAux>();
        Producto producto;
        DataTable table = new DataTable();
        DataTable table2 = new DataTable();
        Form_ShakeShak form = new Form_ShakeShak();
        try
        {
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 31);
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(table);
            foreach (DataRow row in table.Rows)
            {
                producto = new Producto();
                producto.Nombre = row["nombre"].ToString();
                producto.Id_producto = Convert.ToInt32(row["Id_pro"]);
                producto.Precio = Convert.ToDecimal(row["precio"]);
                lista.Add(producto);
            }
        }
        catch (Exception ex) { }
        return lista;
    }

    [System.Web.Services.WebMethod]
    public static List<ModificadorAux> GetModificadores(string id_pro)
    {
        Conexion conexion = new Conexion();
        List<ModificadorAux> listaModif = new List<ModificadorAux>();
        ModificadorAux modificadorAux;
        DataTable table2 = new DataTable();
        Form_ShakeShak form = new Form_ShakeShak();
        try
        {                
            SqlCommand command2 = new SqlCommand("sp_dash", conexion.Conection);
            command2.CommandType = CommandType.StoredProcedure;
            command2.Parameters.AddWithValue("@consulta", 32);
            command2.Parameters.AddWithValue("@id_pro", Convert.ToInt32(id_pro));
            command2.CommandTimeout = 0;
            SqlDataAdapter adapter2 = new SqlDataAdapter();
            adapter2.SelectCommand = command2;
            adapter2.Fill(table2);
            foreach (DataRow row2 in table2.Rows)
            {
                modificadorAux = new ModificadorAux();
                modificadorAux.Modificador = row2["nombre"].ToString();
                modificadorAux.Id_op = Convert.ToInt32(row2["id_op"]);
                modificadorAux.Precio = Convert.ToDecimal(row2["precio"]);
                listaModif.Add(modificadorAux);
            }
        }
        catch (Exception ex) { }
        return listaModif;
    }

    [System.Web.Services.WebMethod]
    public static List<Producto> AddProducto(string id_producto,string cantidad,string precio,string modificador,string num,string nombre,string id_modif)
    {

        Form_ShakeShak form = new Form_ShakeShak();
        Conexion conexion = new Conexion();
        List<Producto> lista = new List<Producto>();
        List<Producto> listaAux = new List<Producto>();
        List<ModificadorAux> listaModif = new List<ModificadorAux>();
        listaAux = (List < Producto >) form.Session["Productos"];
        if (listaAux != null)
            lista = (List<Producto>)form.Session["Productos"];
        else
            lista = new List<Producto>(); 
        Producto  producto = new Producto();
        producto.Num = Convert.ToInt32( num);
        producto.Id_producto = Convert.ToInt32( id_producto);
        producto.Id_modif = Convert.ToInt32( id_modif);
        producto.Precio =Convert.ToDecimal( precio);
        producto.Cantidad =Convert.ToInt32( cantidad);
        producto.Modificador =(modificador).ToString();
        producto.Nombre = nombre;
        string[] cadenaModif = modificador.Split(',');
        for (int i = 0;i< cadenaModif.Length-1;i++)
        {
            if(i> 0)
            {
                string[] cad2 = cadenaModif[i].Split('|');
                ModificadorAux modificadorAux = new ModificadorAux();
                modificadorAux.Id_op = Convert.ToInt32( cad2[0]);
                modificadorAux.Factor = Convert.ToInt32( cad2[1]);
                listaModif.Add(modificadorAux);
            }
        }
        producto.Lista = listaModif;
        lista.Add(producto);

        form.Session["Productos"] = lista;
        return lista;
    }

    [System.Web.Services.WebMethod]
    public static List<Producto> DelProducto(string posicion)
    {
        Form_ShakeShak form = new Form_ShakeShak();
        Conexion conexion = new Conexion();
        List<Producto> lista = new List<Producto>();
        List<Producto> listaAux = new List<Producto>();
        listaAux = (List<Producto>)form.Session["Productos"];
        if (listaAux != null)
            lista = (List<Producto>)form.Session["Productos"];
        else
            lista = new List<Producto>();
        Producto producto = new Producto();

        foreach (Producto item in lista)
        {
            if (item.Num== Convert.ToInt32(posicion))
                lista.Remove(item);
        }


        form.Session["Productos"] = lista;
        return lista;
    }   
    [System.Web.Services.WebMethod]
    public static string Terminar(string a)
    {
        Form_ShakeShak form = new Form_ShakeShak();
        List<Producto> lista = new List<Producto>();
        List<Producto> listaAux = new List<Producto>();
        listaAux = (List<Producto>)form.Session["Productos"];
        if (listaAux != null)
            lista = (List<Producto>)form.Session["Productos"];
        else
            lista = new List<Producto>();
        int resInsert = 0;
        string json = "{";
        if (form.Session["IdOrden"] != null)
        {
            Conexion conexion = new Conexion();
            SqlCommand command = new SqlCommand("sp_dash", conexion.Conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 2);
            command.Connection.Open();
            resInsert = (int)command.ExecuteScalar();
            command.Connection.Close();
        }

        /*    foreach (Producto pro in lista)
        {
            json += "'producto':"+pro.Num+",";
            json += "'id_pro':"+pro.Id_producto + ",";
            json += "'porciones':"+pro.Cantidad + ",";
            json += "'modificadores':{";
            List<ModificadorAux> listaModif = pro.Lista;
            foreach (ModificadorAux modAux in listaModif)
            {
                json += "'id_modif':"+modAux.Id_modif + ",";
                json += "'id_op':"+modAux.Id_op + ",";
                json += "'factor':"+modAux.Factor + ",";
            }
                json += "}";
        }
        json += "}";
        
    */
        System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
        imgBarCode.Height = 50;
        imgBarCode.Width = 50;
        using (MemoryStream ms = new MemoryStream())
        {
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(resInsert.ToString(), QRCodeGenerator.ECCLevel.Q);
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                bitMap.Save(ms, ImageFormat.Png);
                byte[] byteImage = ms.ToArray();
                imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage, 0, byteImage.Length); ;
                string base64String = Convert.ToBase64String(byteImage, 0, byteImage.Length);
                string imageUrl = "data:image/png;base64," + base64String;
                string imageContent = "<img width=250 height=250 src='" + imageUrl + "'  />";
                form.Session["Productos"] = null;
                return imageContent;
            }
        }
        //return "Completado";
    }
    public static string DataSetToJSON(DataTable dt)
    {

        List<object> dict = new List<object>();
        object[] arr = new object[dt.Rows.Count + 1];
        for (int i = 0; i <= dt.Rows.Count - 1; i++)
        {
            arr[i] = dt.Rows[i].ItemArray;
        }
        dict.Add(arr);
        JavaScriptSerializer json = new JavaScriptSerializer();
        return json.Serialize(dict);
    }
    [System.Web.Services.WebMethod]
    public static string Registro(string nombre, string telefono, string correo, string password)
    {
        Form_ShakeShak form = new Form_ShakeShak();
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