package hn.unah.bdi.uber.Services;

import java.util.List;

import hn.unah.bdi.uber.Entities.Solicitudes;
import hn.unah.bdi.uber.Entities.VerificacionSolicitudes;
import hn.unah.bdi.uber.dtos.detalleFotografiaSolicitud;
import hn.unah.bdi.uber.dtos.detalleSolicitud;

public interface SolicitudesService {
    
    public Boolean CrearSolicitud(Solicitudes solicitud);

    public List<detalleSolicitud> detallesSolicitud();

    public List<detalleFotografiaSolicitud> detalleFotografiaSolicituds();

    public Boolean AceptarSolicitudes(VerificacionSolicitudes verificacionSolicitud);

    public Boolean rechazarSolicitudes(VerificacionSolicitudes verificacionSolicitud);


}
