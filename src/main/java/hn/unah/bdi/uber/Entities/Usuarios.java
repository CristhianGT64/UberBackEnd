package hn.unah.bdi.uber.Entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
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
    @Column(name = "idusuario")
    private Float idUsuario;

    private String correo;

    private String contrasenia;

    @Column(columnDefinition = "TINYINT(1)")
    private Integer visible;

    @Column(name = "latactual")
    private Float latActual;

    @Column(name = "lonactual")
    private Float lonActual;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idpersona", referencedColumnName = "idpersona") //Importante poner para que no cree nuevos atributos, llaves foraneas
    private Personas persona;

    // @OneToOne(mappedBy = "usuarios", cascade = CascadeType.ALL)
    // private Administradore administrador;

    @ManyToMany
    @JoinTable(
        name = "usuariosRoles",
        joinColumns = @JoinColumn(name = "idusuario"),
        inverseJoinColumns = @JoinColumn(name = "idrol")
    )
    private List <Roles> rol;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<solicitudesViajes> solicitudViaje;

}
