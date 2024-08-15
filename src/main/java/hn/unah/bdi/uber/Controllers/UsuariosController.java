package hn.unah.bdi.uber.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.util.RouteMatcher.Route;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Entities.Personas;
import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.Services.Impl.UsuariosImpl;
import hn.unah.bdi.uber.dtos.UsuarioSesion;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/api")
public class UsuariosController {
    
    @Autowired
    private UsuariosImpl usuariosImpl;

    @PostMapping("/CrearUsuario")
    public Boolean CrearUsuario(@RequestBody Usuarios usuario) {
        return usuariosImpl.CrearUsuario(usuario);
    }

    @GetMapping("/buscarUsuario")
    public UsuarioSesion buscarUsuarioCirrei(@RequestParam String correo) {
        return this.usuariosImpl.buscarUsuario(correo);
    }
    
    @GetMapping("/iniciarSesion")
    public Boolean iniciarSesion(@RequestParam String correo, String contrasenia) {
        return this.usuariosImpl.iniciarSesion(correo, contrasenia);
    }
    


}
