package hn.unah.bdi.uber.Entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "conductores")
public class Condcutores {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idconductor")
    private Float idConductor;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idusuario", referencedColumnName = "idusuario")
    private Usuarios usuario;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "numplaca", referencedColumnName = "numplaca")
    private Vehiculos vehiculo;

    @OneToOne(mappedBy = "condcutor")
    @JoinColumn(name = "idcuentaconductor", referencedColumnName = "idcuentaconductor")
    private CuentasConductores cuentaConductor;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer disponible;

    @OneToMany(mappedBy = "condcutor" ,cascade = CascadeType.ALL)
    private List<Viajes> viaje;

}
