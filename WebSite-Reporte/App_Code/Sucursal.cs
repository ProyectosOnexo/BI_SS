using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Sucursal
/// </summary>
public class Sucursal
{
    public Sucursal()
    {
        
    }
    private string nombre;
    private bool estado;
    private int id_local;

    public string Nombre { get => nombre; set => nombre = value; }
    public bool Estado { get => estado; set => estado = value; }
    public int Id_local { get => id_local; set => id_local = value; }
}