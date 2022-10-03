using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de HCTAORD
/// </summary>
public class HCTAORD
{
    public HCTAORD()
    {    }

    public int Fecha { get; set; }
    public int Id_local { get; set; }
    public int Id_term { get; set; }
    public int Id_coma { get; set; }
    public int Porciones { get; set; }
    public string Producto { get; set; }
    public decimal M_importe { get; set; }
    public decimal M_desc { get; set; }
    public decimal M_total { get; set; }
}