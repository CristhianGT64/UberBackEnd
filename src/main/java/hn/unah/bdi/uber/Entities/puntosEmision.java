package hn.unah.bdi.uber.Entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "puntosemision")
public class puntosEmision {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpuntoemision")
    private Float idPuntoEmision;

    private Integer numero;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idtipodocumento", referencedColumnName = "idtipodocumento")
    private tiposDocumentos tipoDocumento;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idrangoemision", referencedColumnName = "idrangoemision")
    private RangoEmision rangoEmision;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idestablecimiento", referencedColumnName = "idestablecimiento")
    private Establecimiento establecimiento;
}
