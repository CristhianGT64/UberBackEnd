package hn.unah.bdi.uber.Entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "fotografiassolicitud")
public class FotografiasSolicitud {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idfotografiasolicitud")
    private Float idSolicitud;

    @ManyToOne
    @JoinColumn(name = "idsolicitud", referencedColumnName = "idsolicitud")
    private Solicitudes solicitud;

    @ManyToOne
    @JoinColumn(name = "idtipofotografia", referencedColumnName = "idtipofotografia")
    private tiposFotografias tiposfotografia;

    private String ubicacion;

}
