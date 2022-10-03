using Spire.Xls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_MasterDetail : System.Web.UI.Page
{
   public   DataSet dtSet = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void ExportExcel(object sender, EventArgs e)
    {
        try
        {
            Workbook workbook = new Workbook();
            workbook.CreateEmptySheets(1);
            Worksheet sheet = workbook.Worksheets[0];
            string nombreArchivo = "";
            sheet.GridLinesVisible = false;
            if (Convert.ToInt32(Request.QueryString["Reporte"]) == 3)
            {
                Maestro();
                DataRelation dtRelation;
                DataColumn custCol = dtSet.Tables[0].Columns["categoria"];
                DataColumn orderCol = dtSet.Tables[1].Columns["categoria"];
                dtRelation = new DataRelation("CustOrderRelation ", custCol, orderCol);
                dtSet.Tables[1].ParentRelations.Add(dtRelation);
                Import(sheet, dtSet.Tables[0]);
                nombreArchivo = "ProductosGrupos";
            }
            if (Convert.ToInt32(Request.QueryString["Reporte"]) == 2)
            {
               DataTable tabla = ComandaVerde();
                sheet.InsertDataTable(tabla, true, 1, 1);
                sheet.Range[1, 1, 1, 6].Style.Color = (Color.FromArgb(0, 255, 0));
                sheet.Range[1, 1, 1, 6].Style.Font.IsBold = true;
                nombreArchivo = "ComandaVerde";
            }
            // sheet.AllocatedRange.AutoFitColumns();
            // sheet.AllocatedRange.HorizontalAlignment = HorizontalAlignType.Center;
            #region descargar web
            MemoryStream MyMemoryStream = new MemoryStream();            
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename="+nombreArchivo+".xlsx");
            workbook.SaveToStream(MyMemoryStream, FileFormat.Version2010);
            MyMemoryStream.WriteTo(Response.OutputStream);
            Response.Flush();
            Response.End();
            #endregion 
        }
        catch (Exception ex) { }
    }

    private static void Import(Worksheet sheet, DataTable dataTable)
    {
        //relation
        DataRelation relation = dataTable.ChildRelations[0];

        //child data table
        DataTable childDataTable = dataTable.ChildRelations[0].ChildTable;

        //columns in master table
        DataColumn[] exportedColumns = GetAvailableColumns(dataTable, relation.ParentColumns);

        //insert master table
        sheet.InsertDataTable(dataTable, true, 1, 1, -1, -1, exportedColumns, false);

        sheet.Range[1, 1, 1, exportedColumns.Length].Style.Borders.LineStyle = LineStyleType.Thin;
        sheet.Range[1, 1, 1, exportedColumns.Length].Borders[BordersLineType.DiagonalDown].LineStyle = LineStyleType.None;
        sheet.Range[1, 1, 1, exportedColumns.Length].Borders[BordersLineType.DiagonalUp].LineStyle = LineStyleType.None;
        sheet.Range[1, 1, 1, exportedColumns.Length].Style.Color = (Color.FromArgb(237, 237, 237));
        sheet.Range[1, 1, 1, exportedColumns.Length].Style.Font.IsBold = true;
        sheet.Range[2, 1, dataTable.Rows.Count + 1, exportedColumns.Length].Style.Color = (Color.FromArgb(237, 237, 237));

        //insert child table
        int childDataInSheetRowIndex = 3;
        DataTable subDataTable = childDataTable.Clone();

        DataColumn[] childTableColumns = GetAvailableColumns(subDataTable, relation.ChildColumns);
        for (int i = 0, count = dataTable.Rows.Count; i < count; i++, childDataInSheetRowIndex++)
        {
            DataRow parentRow = dataTable.Rows[i];
            DataRow[] childRows = parentRow.GetChildRows(relation);
            subDataTable.Rows.Clear();
            foreach (DataRow row in childRows)
            {
                subDataTable.Rows.Add(row.ItemArray);
            }

            sheet.InsertRow(childDataInSheetRowIndex, childRows.Length + 1);
            sheet.InsertDataTable(subDataTable, true, childDataInSheetRowIndex, 1, -1, -1, childTableColumns, false);
            sheet.GroupByRows(childDataInSheetRowIndex, childDataInSheetRowIndex + childRows.Length, true);
            //set the sheet style
            sheet.Range[childDataInSheetRowIndex - 1, 1, childDataInSheetRowIndex - 1, exportedColumns.Length].Style.Borders.LineStyle = LineStyleType.Thin;
            sheet.Range[childDataInSheetRowIndex - 1, 1, childDataInSheetRowIndex - 1, exportedColumns.Length].Borders[BordersLineType.DiagonalDown].LineStyle = LineStyleType.None;
            sheet.Range[childDataInSheetRowIndex - 1, 1, childDataInSheetRowIndex - 1, exportedColumns.Length].Borders[BordersLineType.DiagonalUp].LineStyle = LineStyleType.None;
            sheet.Range[childDataInSheetRowIndex, 1, childDataInSheetRowIndex, childTableColumns.Length].Style.Color = (Color.FromArgb(237, 237, 237));
            sheet.Range[childDataInSheetRowIndex + 1, 1, childDataInSheetRowIndex + childRows.Length, childTableColumns.Length].Style.Color = Color.White;
            sheet.Range[childDataInSheetRowIndex, 1, childDataInSheetRowIndex + childRows.Length, childTableColumns.Length].Style.Borders.LineStyle = LineStyleType.Thin;
            sheet.Range[childDataInSheetRowIndex, 1, childDataInSheetRowIndex + childRows.Length, childTableColumns.Length].Borders[BordersLineType.DiagonalDown].LineStyle = LineStyleType.None;
            sheet.Range[childDataInSheetRowIndex, 1, childDataInSheetRowIndex + childRows.Length, childTableColumns.Length].Borders[BordersLineType.DiagonalUp].LineStyle = LineStyleType.None;
            childDataInSheetRowIndex = childDataInSheetRowIndex + childRows.Length + 1;
        }
    }
    private static DataColumn[] GetAvailableColumns(DataTable dataTable, DataColumn[] dynamicalColumns)
    {
        List<String> dynamicalColumnList
            = new List<String>();
        foreach (DataColumn column in dynamicalColumns)
        {
            dynamicalColumnList.Add(column.ColumnName);
        }
        List<DataColumn> exportedColumnList = new List<DataColumn>();
        foreach (DataColumn column in dataTable.Columns)
        {
            if (!dynamicalColumnList.Contains(column.ColumnName))
            {
                exportedColumnList.Add(column);
            }
        }
        return exportedColumnList.ToArray();
    }
    private DataTable ComandaVerde()
    {
            DataTable dt = new DataTable();
        try
        {
            string ID = (string)(Session["ID"]);
            string nombre = Request.QueryString["nombre"];
            string fecha = Request.QueryString["fecha"];
            string fecha2 = Request.QueryString["fecha2"];
            int idlocal = ObtenerId(nombre);
            DateTime FechaModificada = DateTime.Parse(fecha);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(fecha2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            string strConnString = ConfigurationManager.ConnectionStrings["ToksBdConnectionString"].ConnectionString;
            SqlConnection conection = new SqlConnection(strConnString);
            SqlCommand command = new SqlCommand("sp_dash", conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 122);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.Parameters.AddWithValue("@idUsuario", ID); ;
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(dt);

            string empleado ="";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if(empleado== dt.Rows[i]["Nombre"].ToString())
                    dt.Rows[i]["Nombre"]="";
                else
                    empleado = dt.Rows[i]["Nombre"].ToString();
            }


            return dt;
        }
        catch (Exception ex)
        {
            return dt;
        }
    }

    private void Maestro()
    {
        try
        {
            DataTable dt = new DataTable();
            string ID = (string)(Session["ID"]);
            string nombre = Request.QueryString["nombre"];
            string fecha = Request.QueryString["fecha"];
            string fecha2 = Request.QueryString["fecha2"];
            int idlocal = ObtenerId(nombre);
            DateTime FechaModificada = DateTime.Parse(fecha);
            string a1 = FechaModificada.ToString("yyyy-MM-dd");
            DateTime FechaModificada2 = DateTime.Parse(fecha2);
            string a2 = FechaModificada2.ToString("yyyy-MM-dd");
            string strConnString = ConfigurationManager.ConnectionStrings["ToksBdConnectionString"].ConnectionString;
            SqlConnection conection = new SqlConnection(strConnString);
            SqlCommand command = new SqlCommand("sp_dash", conection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@consulta", 24);
            command.Parameters.AddWithValue("@fecha", a1);
            command.Parameters.AddWithValue("@fecha2", a2);
            command.Parameters.AddWithValue("@idSucursal", idlocal);
            command.Parameters.AddWithValue("@idUsuario", ID); ;
            command.CommandTimeout = 0;
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(dtSet);
        }
        catch (Exception ex) { }
    }

    public int ObtenerId(string nombre)
    {
        Conexion conexion = new Conexion();
        int idlocal = 0;
        if (!nombre.Equals("Todas"))
        {
            conexion.Conectar();
            conexion.comando = new SqlCommand("select id_local from mlocal where nombre = '" + nombre + "'", conexion.miconexion);
            conexion.reader = conexion.comando.ExecuteReader();

            if (conexion.reader.Read())
            {
                idlocal = (Int32)conexion.reader["id_local"];

                conexion.reader.Close();
                conexion.comando.Dispose();
                conexion.Desconectar();
            }
        }
        return idlocal;
    }
}