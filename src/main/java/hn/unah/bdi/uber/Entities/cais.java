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
@Table(name = "cais")
public class cais {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcai")
    private Float idcai;

    private String cai;

    @Column(name = "fechalimiteemision")
    private Date fechaLimiteEmision;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer disponible;

}
