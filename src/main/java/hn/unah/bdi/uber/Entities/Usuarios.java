package hn.unah.bdi.uber.Entities;

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
@Table(name = "Usuarios")
public class Usuarios {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idUsuario")
    private Float idUsuario;

    private String correo;

    private String contrasenia;

    private Boolean visible;

    @Column(name = "latactual")
    private Float latActual;

    @Column(name = "lonactual")
    private Float lonActual;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idpersona", referencedColumnName = "idpersona") //Importante poner para que no cree nuevos atributos, llaves foraneas
    private Personas persona;

    @OneToOne(mappedBy = "usuarios", cascade = CascadeType.ALL)
    private Administradore administrador;

}
