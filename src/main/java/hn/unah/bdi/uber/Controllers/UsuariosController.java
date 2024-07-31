package hn.unah.bdi.uber.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.RouteMatcher.Route;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Services.Impl.UsuariosImpl;

@RestController
@RequestMapping("/api")
public class UsuariosController {
    
    @Autowired
    private UsuariosImpl usuariosImpl;

    /* Usuarios */


}
