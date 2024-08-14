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

@Data
@Entity
@Table(name = "numerosfacturas")
public class numerosFacturas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idnumfactura")
    private Float idNumFactura;

    @Column(name = "numeroformulado")
    private String numeroFormulado;

    @Column(name = "numcorrelativo")
    private Integer numCorrelativo;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idtipodocumento", referencedColumnName = "idtipodocumento")
    private tiposDocumentos tipoDocumento;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idestablecimiento", referencedColumnName = "idestablecimiento")
    private Establecimiento establecimiento;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idpuntoemision", referencedColumnName = "idpuntoemision")
    private puntosEmision puntosEmision;

}
