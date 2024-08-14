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

@Data
@Entity
@Table(name = "telefonossucursales")
public class telefonosSucursales {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtelefonossucursales")
    private Float idTelefonosSucursales;

    private String numero;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer disponible;

    @ManyToOne
    @JoinColumn(name = "idsucursal", referencedColumnName = "idsucursal")
    private Sucursales sucursal;
}
