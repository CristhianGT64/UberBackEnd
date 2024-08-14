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
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "solicitudesviajes")
public class solicitudesViajes {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idsolicitudviaje")
    private Float idSolicitudViaje;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idestado", referencedColumnName = "idestado")
    private estados estado;

    @Column(name = "latitudorigen")
    private Double latitudOrigen;

    @Column(name = "longitudorigen")
    private Double longitudOrigen;
    
    @Column(name = "latituddestino")
    private Double latitudDestino;

    @Column(name = "longituddestino")
    private Double longitudDestino;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idusuario", referencedColumnName = "idusuario")
    private Usuarios usuario;

    private Double tarifa;

    private Double distancia;

    private Date fechaSolicitud;

    @OneToOne(mappedBy = "solicitudViaje", cascade = CascadeType.ALL)
    private Viajes viaje;

    @OneToMany(mappedBy = "solicitudViaje" ,cascade = CascadeType.ALL)
    private List <Mensajes> mensaje;

}
