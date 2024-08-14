package hn.unah.bdi.uber.Entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "idCorreo")
public class Correos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcorreo")
    private Float idCorreo;

    private String correo;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer disponible;

    // private Empresa empresa;

}
