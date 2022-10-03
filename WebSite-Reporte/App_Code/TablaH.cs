using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de TablaH
/// </summary>
public class TablaH
{
    public TablaH()
    { }

    public int Id { get; set; }
    public string Descripcion { get; set; }
    public decimal Total { get; set; }
    public decimal Desayunos { get; set; }
    public decimal PDesayunos { get; set; }
    public decimal Comidas { get; set; }
    public decimal PComidas { get; set; }
    public decimal Cenas { get; set; }
    public decimal PCenas { get; set; }
}