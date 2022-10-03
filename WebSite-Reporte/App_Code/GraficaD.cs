using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de GraficaD
/// </summary>
public class GraficaD
{
    public GraficaD()
    {}

    private string descripcion;
    private int registros;
    private int contador;

    public string Descripcion { get => descripcion; set => descripcion = value; }
    public int Registros { get => registros; set => registros = value; }
    public int Contador { get => contador; set => contador = value; }
}