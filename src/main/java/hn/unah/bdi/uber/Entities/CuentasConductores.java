package hn.unah.bdi.uber.Entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;
// import lombok.ToString;

@Entity
@Data
@Table(name = "CuentasConductores")
public class CuentasConductores {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcuentaconductor")
    private Float idCuentaConductor;

    private Double saldo;

    @OneToMany(mappedBy = "cuentaConductor", cascade = CascadeType.ALL)
    private List<historialCuentas> historialCuenta;

    @OneToOne(cascade = CascadeType.ALL)
    private Condcutores condcutor;

}