package hn.unah.bdi.uber.Services.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import hn.unah.bdi.uber.Entities.Solicitudes;
import hn.unah.bdi.uber.Entities.VerificacionSolicitudes;
import hn.unah.bdi.uber.Services.SolicitudesService;
import hn.unah.bdi.uber.dtos.MarcaDto;
import hn.unah.bdi.uber.dtos.detalleFotografiaSolicitud;
import hn.unah.bdi.uber.dtos.detalleSolicitud;

@Service
public class SolicitudesImpl implements SolicitudesService{

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Boolean CrearSolicitud(Solicitudes solicitud) {

        String query = "EXEC P_LICENCIAS_SOLI_FOTO\r\n" + //
                        "    @licencia = ?,\r\n" + //
                        "    @fechaVencimiento = ?,\r\n" + //
                        "    @idUsuario = ?,\r\n" + //
                        "    @fechaNacimiento = ?,\r\n" + //
                        "    @colorVehiculo = ?,\r\n" + //
                        "    @numPlaca = ?,\r\n" + //
                        "    @numPuertas = ?,\r\n" + //
                        "    @anio = ?,\r\n" + //
                        "    @numAsientos = ?,\r\n" + //
                        "    @idmarca = ?,\r\n" + //
                        "    @idmodelo = ?,\r\n" + //
                        "\t@fotoLicencia = ?,\r\n" + //
                        "\t@fotoVehiculo = ?,\r\n" + //
                        "\t@fotoPersona = ?;\r\n" + //
                        "";

        

        try {
            Integer respuestaConsulta = this.jdbcTemplate.update(query, solicitud.getLicencia().getLicencia(), solicitud.getLicencia().getFechaVencimiento(),
            solicitud.getUsuarios().getIdUsuario(), solicitud.getFechaNacimiento(), solicitud.getColorVehiculo(),
            solicitud.getNumPlaca(), solicitud.getNumPuertas(), solicitud.getAnio(), solicitud.getNumasientos(), solicitud.getMarca().getIdMarca(),
            solicitud.getModelo().getIdModelo(), solicitud.getFotografiaSolicitud().get(0).getUbicacion(), solicitud.getFotografiaSolicitud().get(1).getUbicacion(),
            solicitud.getFotografiaSolicitud().get(2).getUbicacion());
            if (respuestaConsulta != 0) {
                return true;
            }
        } catch (Exception e) {
            return false;
        }

        return false;
    }

    @Override
    public List<detalleSolicitud> detallesSolicitud() {
        String query = "EXEC P_DETALLES_SOL";

        return this.jdbcTemplate.query(query, new BeanPropertyRowMapper<detalleSolicitud>(detalleSolicitud.class));
    }

    @Override
    public List<detalleFotografiaSolicitud> detalleFotografiaSolicituds() {
        String query = "EXEC P_FOTOGRAFIAS_PENDIENTES";
        return this.jdbcTemplate.query(query, new BeanPropertyRowMapper<detalleFotografiaSolicitud>(detalleFotografiaSolicitud.class));
    }

    @Override
    public Boolean AceptarSolicitudes(VerificacionSolicitudes verificacionSolicitud) {

        String query = "EXEC P_ACEPTAR_SOLICITUDES @idUsuario = ?, @idSolicitud = ?, @descripcion = ?;";

        try {
            Integer respueta = this.jdbcTemplate.update(query, verificacionSolicitud.getAdministrador().getIdAdministrador(), verificacionSolicitud.getSolicitud().getIdSolicitud(),
            verificacionSolicitud.getObservaciones());
            if (respueta != 0) {
            return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    @Override
    public Boolean rechazarSolicitudes(VerificacionSolicitudes verificacionSolicitud) {
        String query = "EXEC P_CANCELAR_SOLICITUDES @idUsuario = ?, @idSolicitud = ?, @descripcion = ?;";

        try {
            Integer respueta = this.jdbcTemplate.update(query, verificacionSolicitud.getAdministrador().getIdAdministrador(), verificacionSolicitud.getSolicitud().getIdSolicitud(),
            verificacionSolicitud.getObservaciones());
            if (respueta != 0) {
            return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }
    
}
