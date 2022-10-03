using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Reporte
/// </summary>
public class Reporte
{
    public Reporte() {    }
    public string Nombre { get; set; }
    public string Producto { get; set; }
    public decimal Precio { get; set; }
    public decimal Participacion { get; set; }
    public int Porcion { get; set; }
    public string Hora { get; set; }
    public int Folio { get; set; }
    public string Orden { get; set; }
}