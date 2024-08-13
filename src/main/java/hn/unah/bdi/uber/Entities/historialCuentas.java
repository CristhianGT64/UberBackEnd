package hn.unah.bdi.uber.Entities;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "historialCuentas")
public class historialCuentas {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idhistorialcuentas")
    private Float idHistorialCuentas;

    @ManyToOne
    @JoinColumn(name = "idcuentaconductor")
    private CuentasConductores cuentaConductor;

    @ManyToOne
    @JoinColumn(name = "idmovimiento")
    private Movimientos movimiento;

    @Column(name = "fechamovimiento")
    private Date fechaMovimiento;

    // @Column(name = "cantidad")
    private Double cantidad;

    private String descripcion;


}
