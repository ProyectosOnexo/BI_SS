using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de GraficaMP
/// </summary>
public class GraficaMP
{
    public GraficaMP()
    {}
    private string descripcion;
    private decimal registros;
    private decimal contador;

    public string Descripcion { get => descripcion; set => descripcion = value; }
    public decimal Registros { get => registros; set => registros = value; }
    public decimal Contador { get => contador; set => contador = value; }
}