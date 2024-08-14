package hn.unah.bdi.uber.Entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "facturas")
public class Facturas {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idfactura")
    private Float idFactura;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idnumfactura", referencedColumnName = "idnumfactura")
    private numerosFacturas numeroFactura;

    @ManyToOne
    @JoinColumn(name = "idmetodopago", referencedColumnName = "idmetodopago")
    private MetodosPagos metodosPago;

    @ManyToOne
    @JoinColumn(name = "idcai", referencedColumnName = "idcai")
    private cais cai;

    private Double subtotal;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idViaje", referencedColumnName = "idViaje")
    private Viajes viajes;

    private Double isv;

    private Double total;

    @ManyToOne
    @JoinColumn(name = "idempresa", referencedColumnName = "idempresa")
    private Empresa empresa;

}
