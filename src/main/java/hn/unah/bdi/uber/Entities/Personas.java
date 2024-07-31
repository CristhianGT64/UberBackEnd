package hn.unah.bdi.uber.Entities;

import java.util.List;

// import org.hibernate.mapping.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "personas")
public class Personas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPersona")
    private Float idPersona;

    private String dni;

    private String nombre1;

    private String nombre2;

    private String apellido1;

    private String apellido2;

    private Usuarios usuario;

    private List<Telefonos> telefonos;

}
