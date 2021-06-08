package vista;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servicio.*;

@WebServlet(name = "empleadoControl", urlPatterns = {"/empleadoControl"})
public class empleadoControl extends HttpServlet {

    private cuentaServicio cuSer;
    private tipoServicio tipSer;
    private empleadoServicio empSer;
    private personaServicio perSer;
    private UbigeoServicio ubiSer;

    public empleadoControl() {
        cuSer = new cuentaServicioImp();
        tipSer = new tipoServicioImp();
        empSer = new empleadoServicioImp();
        perSer = new personaServicioImp();
        ubiSer = new UbigeoServicioImp();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acc = request.getParameter("acc");
        
        if (acc.equals("Iniciar")) {
            String user = request.getParameter("user");
            String pass = request.getParameter("pass");
            Object[] fil = cuSer.validar(user, pass);
            if (fil != null) {
                //validar a que cargo pertenece
                Object[] emp = empSer.buscar((int) fil[0]);
                Object[] tip = tipSer.buscarId((int) emp[2]);

                switch (tip[1].toString()) {
                    case "admin":
                        Object[] per = perSer.buscarId((int) emp[0]);
                        request.getSession().setAttribute("per", per);
                        request.getSession().setAttribute("tip", tip);
                        request.getSession().setAttribute("fil", fil);
                        response.sendRedirect("Intranet/Admin/index.jsp");
                        break;
                }

            } else {
                request.getSession().setAttribute("msg", "ACCESO NO PERMITIDO");
                response.sendRedirect("Intranet.jsp");
            }
        }
        
        if (acc.equals("Buscar")) {
            String dni=request.getParameter("dni-buscar");
            
            Object[] fil=new Object[13];
            Object[] per=perSer.buscar(dni);
            
            if (per!=null) {
                Object[] fila=buscar(fil, per);
                
                Object[] busC=cuSer.buscarId((int) fila[10]);
                fila[10] = (String) busC[1]; //usuario
                fila[12] = (String) busC[2]; //password

                Object[] busT=tipSer.buscarId((int) fila[11]);
                fila[11] = (String) busT[1]; //nombreTipEmp

                request.getSession().setAttribute("filaBus", fila);
                response.sendRedirect("Intranet/Admin/empleados.jsp");
            } else {
                request.getSession().setAttribute("msg", "Empleado no existe.");
                response.sendRedirect("Intranet/Admin/empleados.jsp");
            }
        }
        
        if (acc.equals("Limpiar")) {
            Object[] fila={"","","","","","","","","","","","",""};
            request.getSession().setAttribute("filaBus", fila);
            response.sendRedirect("Intranet/Admin/empleados.jsp");
        }
        
        if (acc.equals("Registrar")) {
            String Nombre = request.getParameter("Nombre");
            String Apellidos = request.getParameter("Apellidos");
            String Dni = request.getParameter("Dni");
            String Telefono = request.getParameter("Telefono");
            String FechaNa = request.getParameter("FechaNa");
            String Direccion = request.getParameter("Direccion");
            String tipo = request.getParameter("tipo");
            String usu = request.getParameter("usuario");
            String pass = request.getParameter("password");
            String dep = new String(request.getParameter("selectDepartamento").getBytes("ISO-8859-1"),"UTF-8");
            String pro = new String(request.getParameter("selectProvincia").getBytes("ISO-8859-1"),"UTF-8");
            String dis = new String(request.getParameter("selectDistrito").getBytes("ISO-8859-1"),"UTF-8");

            List lisDep = ubiSer.listarDep(dep);
            Object[] f = (Object[]) lisDep.get(1);
            String codDep = (String) f[0];

            List lisPro = ubiSer.listarPro(codDep, pro);
            Object[] x = (Object[]) lisPro.get(1);
            String codPro = (String) x[0];

            List lisDis = ubiSer.listarDis(codDep, dis, codPro);
            Object[] e = (Object[]) lisDis.get(1);
            String codDis = (String) e[0];

            perSer.grabar(Nombre, Apellidos, Dni, Direccion, Telefono, FechaNa, codDis, codPro, codDep);
            cuSer.grabar(usu, pass);

            Object[] busP=perSer.buscar(Dni);
            int IdPerEmp=(int) busP[0];

            Object[] busE=cuSer.buscar(usu);
            int IdCuenta=(int)busE[0];
            
            Object[] busT=tipSer.buscar(tipo);
            int IdTip=(int)busT[0];

            empSer.grabar(IdPerEmp, IdCuenta, IdTip);

            request.getSession().setAttribute("msg", "Empleado Grabado.");
            response.sendRedirect("Intranet/Admin/empleados.jsp");
        }
        
        if (acc.equals("Actualizar")) {
            String Nombre = request.getParameter("Nombre");
            String Apellidos = request.getParameter("Apellidos");
            String Dni = request.getParameter("Dni");
            String Telefono = request.getParameter("Telefono");
            String FechaNa = request.getParameter("FechaNa");
            String Direccion = request.getParameter("Direccion");
            String tipo = request.getParameter("tipo");
            String pass = request.getParameter("password");
            String dep = new String(request.getParameter("selectDepartamento2").getBytes("ISO-8859-1"),"UTF-8");
            String pro = new String(request.getParameter("selectProvincia2").getBytes("ISO-8859-1"),"UTF-8");
            String dis = new String(request.getParameter("selectDistrito2").getBytes("ISO-8859-1"),"UTF-8");

            List lisDep = ubiSer.listarDep(dep);
            Object[] f = (Object[]) lisDep.get(1);
            String codDep = (String) f[0];

            List lisPro = ubiSer.listarPro(codDep, pro);
            Object[] x = (Object[]) lisPro.get(1);
            String codPro = (String) x[0];

            List lisDis = ubiSer.listarDis(codDep, dis, codPro);
            Object[] e = (Object[]) lisDis.get(1);
            String codDis = (String) e[0];
            
            Object[] busP=perSer.buscar(Dni);
            int IdPerEmp=(int) busP[0];
            
            perSer.actualizar(IdPerEmp, Nombre, Apellidos, Dni, Telefono, FechaNa, codDis, codPro, codDep, Direccion);
            
            Object[] fil=new Object[13];
            busP=perSer.buscar(Dni);
            Object[] fila=buscar(fil, busP);

            if (pass!="")
                cuSer.actualizar((int) fila[10], null, pass);
            
            request.getSession().setAttribute("msg", "Empleado Actualizado.");
            request.getSession().setAttribute("filaBus", fila);
            response.sendRedirect("Intranet/Admin/empleados.jsp");
        }
        
        if (acc.equals("Eliminar")) {
            String dni=request.getParameter("dni-eliminar");
            
            Object[] per=perSer.buscar(dni);
            Object[] busE=empSer.buscarId((int) per[0]);
            String msg = empSer.eliminar((int) busE[1]);
            perSer.eliminar((int) busE[0]);
            cuSer.eliminar((int) busE[1]);
            Object[] fila={"","","","","","","","","","","","",""};
            
            request.getSession().setAttribute("msg", msg);
            request.getSession().setAttribute("filaBus", fila);
            response.sendRedirect("Intranet/Admin/empleados.jsp");
        }
    }
    
    private Object[] buscar(Object[] fila, Object[] per) {
        for (int i = 0; i < per.length; i++)
            fila[i] = per[i];
        
        List lisDep = ubiSer.listarDepId((String) fila[9]);
        Object[] f = (Object[]) lisDep.get(1);
        fila[9] = (String) f[1];

        List lisPro = ubiSer.listarProId((String) fila[8]);
        Object[] x = (Object[]) lisPro.get(1);
        fila[8] = (String) x[1];

        List lisDis = ubiSer.listarDisId((String) fila[7]);
        Object[] e = (Object[]) lisDis.get(1);
        fila[7] = (String) e[1];
        
        Object[] busE=empSer.buscarId((int) fila[0]);
        fila[10] = (int) busE[1]; //idCuenta
        fila[11] = (int) busE[2]; //idTipoEmp
        
        return fila;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
