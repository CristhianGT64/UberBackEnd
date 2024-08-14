package hn.unah.bdi.uber.Entities;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "tiposfotografias")
public class tiposFotografias {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtipofotografia")
    private Float idTipoFotografia;

    private String nombre;

    @Column(columnDefinition = "TINYINT(1)")
    private Boolean disponible;

    // private String ubicacion;

    @OneToMany(mappedBy = "tiposfotografia")
    private List <FotografiasSolicitud> fotografiasolicitud;

}   
