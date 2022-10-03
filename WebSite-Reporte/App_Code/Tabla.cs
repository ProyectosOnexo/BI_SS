using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Tabla
/// </summary>
public class Tabla
{
    public Tabla()
    { }
    private int id;
        private string sucursal;
        private string ventaBruta;
        private string ventaNeta;
        private string tickets;
    private int estado;

    public string Sucursal { get => sucursal; set => sucursal = value; }
    public string VentaBruta { get => ventaBruta; set => ventaBruta = value; }
    public string VentaNeta { get => ventaNeta; set => ventaNeta = value; }
    public string Tickets { get => tickets; set => tickets = value; }
    public int Id { get => id; set => id = value; }
    public int Estado { get => estado; set => estado = value; }
}