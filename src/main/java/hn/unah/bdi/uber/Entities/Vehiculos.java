package hn.unah.bdi.uber.Entities;

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
@Table(name = "vehiculos")
public class Vehiculos {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idvehiculo")
    private Float idVehiculo;

    @Column(name = "numplaca")
    private String numPlaca;

    private String color;

    @Column(name = "numpuertas")
    private Integer numPuertas;

    @Column(name = "anio")
    private Integer anio;

    @Column(name = "numasientos")
    private Integer numasientos;

    @OneToOne
    @JoinColumn(name = "idmarca", referencedColumnName =  "idmarca")
    private Marca marca;
    
    @OneToOne
    @JoinColumn(name = "idmodelo", referencedColumnName =  "idmodelo")
    private Modelos modelo;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer visible;
}
