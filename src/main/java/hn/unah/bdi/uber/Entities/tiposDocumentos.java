package hn.unah.bdi.uber.Entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "tiposdocumentos")
public class tiposDocumentos {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtipodocumento")
    private Float idTipoDocumento;

    private Integer numero;

    private String nombre;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer disponible;

}
