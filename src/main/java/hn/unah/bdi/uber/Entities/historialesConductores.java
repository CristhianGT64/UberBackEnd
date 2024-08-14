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
@Table(name = "historialesConductores")
public class historialesConductores {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idhistorialconductor")
    private Float idhistorialConductor;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idviaje")
    private Viajes viaje;

    private Integer evaluacion;

    private String comentario;
}
