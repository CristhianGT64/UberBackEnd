package hn.unah.bdi.uber.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.RouteMatcher.Route;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.Services.Impl.UsuariosImpl;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/api")
public class UsuariosController {
    
    @Autowired
    private UsuariosImpl usuariosImpl;

    @PostMapping("/CrearUsuario")
    public Boolean CrearUsuario(@RequestBody Usuarios usuario) {
        return usuariosImpl.CrearUsuario(usuario);
    }
    


}
