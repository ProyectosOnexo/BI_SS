using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de TablaMP
/// </summary>
public class TablaMP
{
    public TablaMP()
    {}
    public string Descripcion { get; set; }
    public decimal Efectivo { get; set; }
    public decimal Debito { get; set; }
    public decimal Credito { get; set; }
    public decimal Otros { get; set; }
    public decimal Total { get; set; }
    public string SEfectivo { get; set; }
    public string SDebito { get; set; }
    public string SCredito { get; set; }
    public string SOtros { get; set; }
    public string STotal { get; set; }
    public int Tipo { get; set; }//0 entero 1 decimal
}