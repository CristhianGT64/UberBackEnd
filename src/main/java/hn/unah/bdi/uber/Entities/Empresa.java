package hn.unah.bdi.uber.Entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "empresa")
public class Empresa {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idempresa")
    private Float idEmpresa;

    private String nombre;

    private String rtn;

    @OneToMany(cascade = CascadeType.ALL)
    private List<Correos> correo;

    @OneToMany(mappedBy = "empresa")
    private List<Sucursales> sucursales;

}
