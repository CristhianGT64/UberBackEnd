package hn.unah.bdi.uber.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Entities.Solicitudes;
import hn.unah.bdi.uber.Services.Impl.SolicitudesImpl;
import hn.unah.bdi.uber.dtos.ModeloDto;
import hn.unah.bdi.uber.dtos.detalleFotografiaSolicitud;
import hn.unah.bdi.uber.dtos.detalleSolicitud;

import org.springframework.web.bind.annotation.GetMapping;
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

    @GetMapping("/solicitud/detallesSolicitud")
    public List<detalleSolicitud> TraerDetalles() {
        return this.solicitudesImpl.detallesSolicitud();
    }

    @GetMapping("/solicitud/fotografiasSolicitudes")
    public List<detalleFotografiaSolicitud> TraerFotografiasDetalles() {
        return this.solicitudesImpl.detalleFotografiaSolicituds();
    }
    
}
