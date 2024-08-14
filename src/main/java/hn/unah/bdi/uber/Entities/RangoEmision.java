package hn.unah.bdi.uber.Entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "rangoEmision")
public class RangoEmision {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idrangoemision")
    private Float idRangoEmision;

    @Column(name = "iniciorango")
    private Integer inicioRango;

    @Column(name = "finalrango")
    private Integer finalRango;

}
