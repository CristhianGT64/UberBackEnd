package hn.unah.bdi.uber.dtos;

import java.util.List;

import hn.unah.bdi.uber.Entities.Roles;
import lombok.Data;

@Data
public class UsuarioSesion {
    
    private Float idUsuario;

    private String correo;

    private Integer idRol;

    private String nombreCompleto;

    private List<Integer> roles;

}
