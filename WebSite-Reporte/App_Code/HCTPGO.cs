using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de HCTPGO
/// </summary>
public class HCTPGO
{
    public HCTPGO()
    { }

    public int Fecha { get; set; }
    public int Id_local { get; set; }
    public int Id_term { get; set; }
    public int Id_coma { get; set; }
    public decimal Tc_monto { get; set; }
    public string Forma_pago { get; set; }
}