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
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "viajes")
public class Viajes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idviaje")
    private Float idViaje;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idconductor", referencedColumnName = "idconductor")
    private Condcutores condcutor;

    @Column(name = "fechaini")
    private Date fechaIni;

    @Column(name = "fechafin")
    private Date fechaFin;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idsolicitudviaje", referencedColumnName = "idsolicitudviaje")
    private solicitudesViajes solicitudViaje;
}
