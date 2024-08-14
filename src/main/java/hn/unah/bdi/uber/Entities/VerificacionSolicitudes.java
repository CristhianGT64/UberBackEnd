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
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "verificacionessolicitudes")
public class VerificacionSolicitudes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idverificacionsolicitud")
    private Float idVerificacionSolicitud;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idsolicitud")
    private Solicitudes solicitud;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idadministrador", referencedColumnName = "idadministrador")
    private Administradore administrador;

    @ManyToOne
    @JoinColumn(name = "idestado", referencedColumnName = "idestado")
    private estados estado;

    @Column(name = "fecharevision")
    private Date fechaRevision;

    private String observaciones;


}
