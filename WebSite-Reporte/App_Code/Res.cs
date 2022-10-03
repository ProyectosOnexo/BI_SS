using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Res
/// </summary>
public class Res
{
    public Res()
    {
    }
    private string ventas;
    private string presupuesto;
    private string descuentos;
    private string cancelaciones;
    private string tendencia;
    private string tickets;
    private string ticketsPromedio;
    private List<Area> listArea;
    private Dona dona;
    private List<Tabla> listTabla;
    private List<TablaDDetalle> listDetalle;

    public string Ventas { get => ventas; set => ventas = value; }
    public string Descuentos { get => descuentos; set => descuentos = value; }
    public string Cancelaciones { get => cancelaciones; set => cancelaciones = value; }
    public string Presupuesto { get => presupuesto; set => presupuesto = value; }
    public string Tickets { get => tickets; set => tickets = value; }
    public string TicketsPromedio { get => ticketsPromedio; set => ticketsPromedio = value; }
    public string Tendencia { get => tendencia; set => tendencia = value; }
    public List<Area> ListArea { get => listArea; set => listArea = value; }
    public Dona Dona { get => dona; set => dona = value; }
    public List<Tabla> ListTabla { get => listTabla; set => listTabla = value; }
    //nuevos indicadores
    private List<GraficaHoras> listGaficaH;
    private List<TablaH> listVentasH;
    private List<GraficaC> listGaficaC;
    private List<TablaC> listVentasC;
    private List<GraficaD> listGaficaD;
    private List<TablaD> listVentasD;
    private List<TipoCancelacion> listStatusCancel;
    private List<TipoCancelacion> listTipoCancel;
    private List<TablaMP> listMP;
    private List<GraficaMP> listGraficaMP3;
    private List<GraficaMP> listGraficaMP4;

    public List<GraficaHoras> ListGaficaH { get => listGaficaH; set => listGaficaH = value; }
    public List<TablaH> ListVentasH { get => listVentasH; set => listVentasH = value; }
    public List<TablaC> ListVentasC { get => listVentasC; set => listVentasC = value; }
    public List<TablaD> ListVentasD { get => listVentasD; set => listVentasD = value; }
    public List<GraficaC> ListGaficaC { get => listGaficaC; set => listGaficaC = value; }
    public List<GraficaD> ListGaficaD { get => listGaficaD; set => listGaficaD = value; }
    public List<TipoCancelacion> ListTipoCancel { get => listTipoCancel; set => listTipoCancel = value; }
    public List<TipoCancelacion> ListStatusCancel { get => listStatusCancel; set => listStatusCancel = value; }
    public List<TablaMP> ListMP { get => listMP; set => listMP = value; }
    public List<GraficaMP> ListGraficaMP3 { get => listGraficaMP3; set => listGraficaMP3 = value; }
    public List<GraficaMP> ListGraficaMP4 { get => listGraficaMP4; set => listGraficaMP4 = value; }
    public List<TablaDDetalle> ListDetalle { get => listDetalle; set => listDetalle = value; }
}