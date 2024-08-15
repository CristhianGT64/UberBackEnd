package hn.unah.bdi.uber.Services.Impl;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import hn.unah.bdi.uber.Entities.Personas;
import hn.unah.bdi.uber.Entities.Roles;
import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.Entities.numerosFacturas;
import hn.unah.bdi.uber.Services.UsuariosService;
import hn.unah.bdi.uber.dtos.UsuarioSesion;

@Service
public class UsuariosImpl implements UsuariosService{

    /* Este atributo nos apollara en la manipulacion de la base de datos */
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Boolean CrearUsuario(Usuarios usuarios) {

        String queryPersona = "INSERT INTO personas (dni, nombre1, nombre2, apellido1, apellido2)  VALUES (? ,?, ?, ?, ?)";
        String recuperarIDPersona = "SELECT idPersona FROM personas WHERE dni = ?";
        String queryUsuario = "INSERT INTO usuarios (correo, contrasenia,visible, latActual, lonActual, idPersona)  VALUES (?, ? , ?, ? , ?, ?)";
        String queryTelefono = "INSERT INTO telefonosUsuarios (numero, idPersona) VALUES (?, ?)";
        try {
            /* Como usar procedimientos almacenados */
            //Almacenar usuario usando setencias preparadas
            Integer validarPersona= jdbcTemplate.update(queryPersona, usuarios.getPersona().getDni(), usuarios.getPersona().getNombre1(), usuarios.getPersona().getNombre2(), usuarios.getPersona().getApellido1(), usuarios.getPersona().getApellido2());
            //Recuperar id de persona
            List<Personas> personas  = this.jdbcTemplate.query(recuperarIDPersona, new BeanPropertyRowMapper<Personas>(Personas.class), usuarios.getPersona().getDni());
            Float idPersona = personas.get(0).getIdPersona();
            //Ingresar un nuevo usuario en la tabla usuarui
            Integer ValidarUsuario = jdbcTemplate.update(queryUsuario, usuarios.getCorreo(), usuarios.getContrasenia(), 1, usuarios.getLatActual(), usuarios.getLonActual(), idPersona);
            //Ingresar un nuevo telefono
            Integer ValidarTelefono = jdbcTemplate.update(queryTelefono, usuarios.getPersona().getTelefonosUsuario().get(0).getNumero(), idPersona);
            if (validarPersona != 0 && ValidarUsuario != 0 && ValidarTelefono != 0) {
                
            }
            
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public UsuarioSesion buscarUsuario(String correo) {

        String buscarUsuario = "SELECT u.idUsuario, u.Correo, ur.idRol, p.nombre1 + ' ' + p.apellido1 nombreCompleto from usuarios u ";
	    buscarUsuario += "INNER JOIN usuariosRoles ur ON u.idUsuario = ur.idUsuario ";
	    buscarUsuario += "INNER JOIN personas p ON u.idPersona = p.idPersona ";
        buscarUsuario += " WHERE u.correo = ? ";

        List<UsuarioSesion> usuarioSesions = this.jdbcTemplate.query(buscarUsuario, new BeanPropertyRowMapper<UsuarioSesion>(UsuarioSesion.class), correo);


        List<Integer> roles = new ArrayList<>();

        //Debido al query nos trae todos los roles de un usuario pero nos trae tres veces ese registro, entonces 
        //mapeamos los roles en una lista y luego la seteamos en ususariosSessions
        for (UsuarioSesion usuarioSesion : usuarioSesions) {
            // usuarioSesions.get(0).getRoles().add(usuarioSesion.getIdRol());
            roles.add(usuarioSesion.getIdRol());
        }

        usuarioSesions.get(0).setRoles(roles);
        usuarioSesions.get(0).setIdRol(null);

        return usuarioSesions.get(0);
    }

    @Override
    public Boolean iniciarSesion(String correo, String contrasenia) {
        String verificacionUsuario = "DECLARE @existe BIT; ";
        this.jdbcTemplate.update(verificacionUsuario);
        verificacionUsuario += "EXEC VerificarUsuario ";
        verificacionUsuario += "@correo = ?, ";
        verificacionUsuario += "@contraseña = ?, ";
        verificacionUsuario += "@existe = @existe OUTPUT; ";
        verificacionUsuario += "SELECT @existe as ExisteUsuario; " ;


        try {
            List<Boolean> ExisteUsuario = this.jdbcTemplate.queryForList(verificacionUsuario, boolean.class, correo, contrasenia);
            
        if (ExisteUsuario.get(0) == true) {
                return true;
            }
        } catch (Exception e) {
            return false;
        }

        return false;

    }
    
}
