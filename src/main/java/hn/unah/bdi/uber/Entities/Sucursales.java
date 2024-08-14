package hn.unah.bdi.uber.Entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "sucursales")
public class Sucursales {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idsucursal")
    private Float idSucursal;

    private String nombre;

    private String domicilio;

    @ManyToOne
    @JoinColumn(name = "idempresa", referencedColumnName = "idempresa")
    private Empresa empresa;

    @OneToMany(mappedBy = "sucursal", cascade = CascadeType.ALL)
    private List<telefonosSucursales> telefonoSucursal;

}
