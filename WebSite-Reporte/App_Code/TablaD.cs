using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de TablaD
/// </summary>
public class TablaD
{
    public TablaD()
    {
    }
    public int Id { get; set; }
    public string Nombre { get; set; }
    public decimal Venta { get; set; }
    public decimal Descuento { get; set; }
    public decimal ImporteCDescuento { get; set; }
    public decimal Neto { get; set; }
    public decimal Descu { get; set; }
    public decimal Porciones { get; set; }
}