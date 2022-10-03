using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class CatalogoTiendas : System.Web.UI.Page
{
    AbrirConexion conexion = new AbrirConexion();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            this.BindGrid();
        }

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

    public void VerificarTienda()
    {

    }

    private void BindGrid()
    {
        string constr = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
        string query = "select mlocal.id_local, mlocal.nombre AS TIENDA, UbicacionShack.Ubicacion AS UBICACION," +
            " UbicacionShack.lat AS LATITUD, UbicacionShack.Long AS LONGITUD,UbicacionShack.Estado AS ESTADO from mlocal" +
            " left Join UbicacionShack on mlocal.id_local = UbicacionShack.idSucursal";

        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
    }


    /*protected void Insert(object sender, EventArgs e)
    {
        string id = txtId.Text;
        string ubicacion = txtUbicacion.Text;
        string lat = txtLat.Text;
        string lng = txtLng.Text;
        string estado = txtEstado.Text;

        txtId.Text = "";
        txtUbicacion.Text = "";
        txtLat.Text = "";
        txtLng.Text = "";
        txtEstado.Text = "";

        string query = "INSERT INTO UbicacionShack(idSucursal,Ubicacion,lat,long,Estado)" +
        " values(@idSucursal,@Ubicacion,@lat,@long,@Estado)";
        string constr = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@idSucursal", id);
                cmd.Parameters.AddWithValue("@Ubicacion", ubicacion);
                cmd.Parameters.AddWithValue("@lat", lat);
                cmd.Parameters.AddWithValue("@long", lng);
                cmd.Parameters.AddWithValue("@Estado", estado);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGrid();
    }*/

    protected void OnRowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }

    protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int customerId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
        string ubicacion = (row.FindControl("txtUbicacion0") as TextBox).Text;
        string lat = (row.FindControl("txtLat0") as TextBox).Text;
        string lng = (row.FindControl("txtLong0") as TextBox).Text;
        string estado = (row.FindControl("txtEstado0") as TextBox).Text;

        if ((row.FindControl("txtUbicacion0") as TextBox).Text == "" || (row.FindControl("txtUbicacion0") as TextBox).Text == null || (row.FindControl("txtLat0") as TextBox).Text == "" || (row.FindControl("txtLat0") as TextBox).Text == null || (row.FindControl("txtLong0") as TextBox).Text == "" || (row.FindControl("txtLong0") as TextBox).Text == null)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "Funcion()", true);
        }
        else
        {
            string constr = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
            SqlConnection PubsConn = new SqlConnection(constr);

            SqlCommand comando = new SqlCommand("sp_tiendas", PubsConn);
            comando.CommandType = CommandType.StoredProcedure;

            //se limpian los parámetros
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@consulta", 1);
            comando.Parameters.AddWithValue("@ubicacion", ubicacion);
            comando.Parameters.AddWithValue("@lat", lat);
            comando.Parameters.AddWithValue("@long", lng);
            comando.Parameters.AddWithValue("@idSucursal", customerId);

            PubsConn.Open();

            SqlDataReader myReader = comando.ExecuteReader();
            if (myReader.Read())
            {
                comando.Dispose();
                myReader.Close();
                PubsConn.Close();
            };

            GridView1.EditIndex = -1;
            this.BindGrid();
        }

    }

    protected void OnRowCancelingEdit(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
        this.BindGrid();
    }

    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
        string query = "DELETE FROM UbicacionShack WHERE idSucursal =@id";
        string constr = ConfigurationManager.ConnectionStrings["ReportesConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        this.BindGrid();
    }

    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex)
        {
            (e.Row.Cells[6].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('¿Estás seguro de eliminar esta tienda?');";
        }
    }

    protected void OnPaging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        this.BindGrid();
    }

    /*public bool AgregarTienda(int id, string ubicacion, string lat, string lng, string estado)
    {
        bool valor = false;
        //
        conexion.comando.Connection = conexion.miconexion;
        //el simbolo @ nos indica los parametros que le vamos a pasar
        //este codigo es tambien util para update y delete
        conexion.comando.CommandText = "INSERT INTO UbicacionShack(idSucursal,Ubicacion,lat,long,Estado)" +
        " values(@idSucursal,@Ubicacion,@lat,@long,@Estado)";

        conexion.Conectar();
        conexion.comando.Parameters.Clear();
        conexion.comando.Parameters.AddWithValue("idSucursal", id);
        conexion.comando.Parameters.AddWithValue("Ubicacion", ubicacion);
        conexion.comando.Parameters.AddWithValue("lat", lat);
        conexion.comando.Parameters.AddWithValue("long", lng);
        conexion.comando.Parameters.AddWithValue("Estado", estado);

        //comando.ExecuteNonQuery regresa el numero de filas afectadas
        int NFilas = conexion.comando.ExecuteNonQuery();
        if (NFilas > 0)
        {
            conexion.comando.Dispose();
            conexion.Desconectar();
            valor = true;
        }
        else
        {
            conexion.comando.Dispose();
            conexion.Desconectar();
            valor = false;
        }
        return valor;
    }

    public bool ActualizarTienda(string ubicacion, string lat, string lng, string estado, int id)
    {
        bool valor = false;

        conexion.comando.Connection = conexion.miconexion;
        conexion.Conectar();
        conexion.comando.CommandText = "UPDATE UbicacionShack SET Ubicacion = @ubicacion,lat = @lat," +
        "long = @long,Estado = @estado WHERE mlocal.id_local = @id inner join mlocal ON mlocal.id_local = UbicacionShack.idSucursal";
        conexion.comando.CommandType = CommandType.Text;

        conexion.comando.Parameters.Clear();
        conexion.comando.Parameters.AddWithValue("ubicacion", ubicacion);
        conexion.comando.Parameters.AddWithValue("lat", lat);
        conexion.comando.Parameters.AddWithValue("long", lng);
        conexion.comando.Parameters.AddWithValue("estado", estado);
        conexion.comando.Parameters.AddWithValue("id", id);

        int NFilas = conexion.comando.ExecuteNonQuery();
        if (NFilas > 0)
        {
            conexion.Desconectar();
            conexion.comando.Dispose();
            valor = true;
            //ClientScript.RegisterStartupScript(GetType(), "Mensaje", "Refrescar();", true);
        }
        else
        {
            conexion.Desconectar();
            conexion.comando.Dispose();
            valor = false;
        }

        return valor;
    }

    public bool EliminarTienda(int id)
    {
        bool valor = false;
        try
        {
            conexion.comando.Connection = conexion.miconexion;
            conexion.comando.CommandText = "DELETE FROM UbicacionShack WHERE idSucursal = '" + id + "' ";
            conexion.Conectar();

            int NFilas = conexion.comando.ExecuteNonQuery();
            if (NFilas >= 0)
            {
                valor = true;
                conexion.Desconectar();
                conexion.comando.Dispose();
            }
            else
            {
                valor = false;
                conexion.Desconectar();
                conexion.comando.Dispose();
            }
        }
        catch (Exception E)
        {
            Console.Write(E);
        }
        return valor;
    }*/

}