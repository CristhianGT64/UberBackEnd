package hn.unah.bdi.uber.Services;

import java.util.List;

import hn.unah.bdi.uber.Entities.Personas;
import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.dtos.UsuarioSesion;

public interface UsuariosService {
    
    public Boolean CrearUsuario(Usuarios usuarios);

    public UsuarioSesion buscarUsuario(String correo);

    public Boolean iniciarSesion(String correo, String contrasenia);
    
}
