using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de ModificadorAux
/// </summary>
public class ModificadorAux
{
    public ModificadorAux()
    {    }
    
    public int Id_modif { get; set; }
    public int Id_op { get; set; }
    public string Modificador { get; set; }
    public int Factor { get; set; }
    public decimal Precio { get; set; }
}