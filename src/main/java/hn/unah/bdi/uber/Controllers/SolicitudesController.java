package hn.unah.bdi.uber.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Entities.Solicitudes;
import hn.unah.bdi.uber.Services.Impl.SolicitudesImpl;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/api")
public class SolicitudesController {
    @Autowired
    private SolicitudesImpl solicitudesImpl;

    @PostMapping("/solicitus/GuardarSolicitud")
    public Boolean crearSolicitud(@RequestBody Solicitudes solicitud) {
        return this.solicitudesImpl.CrearSolicitud(solicitud);
    }
    
}
