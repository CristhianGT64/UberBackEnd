package hn.unah.bdi.uber.Entities;

import java.sql.Date;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "mensajes")
public class Mensajes {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idmensaje")
    private Float idMensaje;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idusuario", referencedColumnName = "idusuario")
    private Usuarios usuario;

    private String mensaje;

    @Column(name = "fechahora")
    private Date fechaHora;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idsolicitudviaje", referencedColumnName = "idsolicitudviaje")
    private solicitudesViajes solicitudViaje;

}
