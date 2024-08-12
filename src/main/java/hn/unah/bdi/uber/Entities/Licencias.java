package hn.unah.bdi.uber.Entities;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "licencias")
public class Licencias {
    

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idlicencia")
    private Float idLicencia;

    private String licencia;

    @Column(name = "fechavencimiento")
    private Date fechaVencimiento;

}
