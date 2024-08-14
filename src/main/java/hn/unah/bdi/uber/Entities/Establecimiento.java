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
@Table(name = "establecimiento")
public class Establecimiento {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idestablecimiento")
    private Float idestablecimiento;

    private Integer numero;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idtipodocumento", referencedColumnName = "idtipodocumento")
    private tiposDocumentos tiposDocumento;
}
