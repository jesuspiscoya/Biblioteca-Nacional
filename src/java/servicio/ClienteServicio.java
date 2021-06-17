package servicio;

import java.util.List;

public interface ClienteServicio {
    public String grabarCliente(String nombre, String apellidos, String dni, String direccion, String telefono, String fecha, String dep, String pro, String dis, String usuario, String password);
    public Object[] buscarCliente(String dni);
    public List listarCliente();
    public String eliminarCliente(int cod,String usu);
}