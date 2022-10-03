using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Producto
/// </summary>
public class Producto
{
    public Producto()
    {
    }

    public int Num { get; set; }
    public int Id_producto { get; set; }
    public int Id_modif { get; set; }
    public int Cantidad { get; set; }
    public decimal Precio { get; set; }
    public string Modificador { get; set; }
    public string Nombre { get; set; }
    public List<ModificadorAux> Lista { get; set; }

}