public class Solicitud
{
    private string nombre;
        private string correo;
        private string rol;
        private string fecha;
        private string estado;
        private int id;
    private int numero;
    private string fechaacceso;
    public int Id { get => id; set => id = value; }
    public int Numero { get => numero; set => numero = value; }
    public string Nombre { get => nombre; set => nombre = value; }
    public string Correo { get => correo; set => correo = value; }
    public string Rol { get => rol; set => rol = value; }
    public string Fecha { get => fecha; set => fecha = value; }
    public string Estado { get => estado; set => estado = value; }
    public string Fechaacceso { get => fechaacceso; set => fechaacceso = value; }
}