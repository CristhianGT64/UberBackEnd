package hn.unah.bdi.uber.dtos;

import java.sql.Date;

import lombok.Data;

@Data
public class detalleSolicitud {
    private Integer idSolicitud;

    private String correo;

    private String nombreCompleto;

    private String numero;
    
    private Date fechaNacimiento;

    private String licencia;

    private Date fechaVencimiento;

    private String colorVehiculo;

    private String numPlaca;

    private Integer numPuertas;

    private Integer anio;

    private Integer numAsientos;

    private String nombreMarca;

    private String nombreModelo;

}
