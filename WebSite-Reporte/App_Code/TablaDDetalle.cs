using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de TablaDDetalle
/// </summary>
public class TablaDDetalle
{
    public TablaDDetalle()
    {    }
    public string Id { get; set; }
    public string Tipo { get; set; }
    public string Quien { get; set; }
    public string Empleado { get; set; }
    public string Aquien { get; set; }
    public decimal Descuento { get; set; }
    public decimal Monto { get; set; }
}