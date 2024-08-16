package hn.unah.bdi.uber.Entities;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "solicitudes")
public class Solicitudes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idsolicitud")
    private Float idSolicitud;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idusuario", referencedColumnName = "idusuario")
    private Usuarios usuarios;

    @Column(name = "fechanacimiento")
    private Date fechaNacimiento;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idlicencia", referencedColumnName = "idlicencia")
    private Licencias licencia;

    @Column(name = "colorvehiculo")
    private String colorVehiculo;

    @Column(name = "numplaca")
    private String numPlaca;

    @Column(name = "numpuertas")
    private Integer numPuertas;

    @Column(name = "anio")
    private Integer anio;

    @Column(name = "numasientos")
    private Integer numasientos;

    @OneToMany(mappedBy = "solicitud")
    private List <FotografiasSolicitud> fotografiaSolicitud;

    @OneToOne
    @JoinColumn(name = "idmarca", referencedColumnName =  "idmarca")
    private Marca marca;
    
    @OneToOne
    @JoinColumn(name = "idmodelo", referencedColumnName =  "idmodelo")
    private Modelos modelo;
}
