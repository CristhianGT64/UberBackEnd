package hn.unah.bdi.uber.Entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "telefonos")
public class Telefonos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idTelefono")
    private Integer idTelefono;

    private String numero;

    @ManyToOne
    @JoinColumn(name = "idpersona", referencedColumnName = "idpersona") //Importante poner para que no cree nuevos atributos, llaves foraneas
    private Personas persona;

}
