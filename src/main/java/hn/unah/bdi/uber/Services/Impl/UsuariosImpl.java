package hn.unah.bdi.uber.Services.Impl;

import java.sql.PreparedStatement;
import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import hn.unah.bdi.uber.Entities.Personas;
import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.Entities.numerosFacturas;
import hn.unah.bdi.uber.Services.UsuariosService;

@Service
public class UsuariosImpl implements UsuariosService{

    /* Este atributo nos apollara en la manipulacion de la base de datos */
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Boolean CrearUsuario(Usuarios usuarios) {
        
        // String queryCrearUsuario = "BEGIN TRANSACTION; " +
        // "INSERT INTO personas  (dni, nombre1, nombre2, apellido1, apellido2)  VALUES " +
        // "('? ','?', '?', '?', '?'); " +
        // "DECLARE @idPersona INT; SET @idPersona = SCOPE_IDENTITY();" +
        // "INSERT INTO usuarios (correo, contrasenia,visible, latActual, lonActual, idPersona)  VALUES ('?', '?' , ?, ? , ?, @idPersona); " +
        // "INSERT INTO telefonosUsuarios (numero, idPersona) VALUES ('?', @idPersona); " +
        // "COMMIT;";

        String queryPersona = "INSERT INTO personas (dni, nombre1, nombre2, apellido1, apellido2)  VALUES (? ,?, ?, ?, ?)";
        String recuperarIDPersona = "SELECT idPersona FROM personas WHERE dni = ?";
        String queryUsuario = "INSERT INTO usuarios (correo, contrasenia,visible, latActual, lonActual, idPersona)  VALUES (?, ? , ?, ? , ?, ?)";
        String queryTelefono = "INSERT INTO telefonosUsuarios (numero, idPersona) VALUES (?, ?)";
        try {
            /* Como usar procedimientos almacenados */
            //Almacenar usuario usando setencias preparadas
            jdbcTemplate.update(queryPersona, usuarios.getPersona().getDni(), usuarios.getPersona().getNombre1(), usuarios.getPersona().getNombre2(), usuarios.getPersona().getApellido1(), usuarios.getPersona().getApellido2());
            //Recuperar id de persona
            List<Personas> personas  = this.jdbcTemplate.query(recuperarIDPersona, new BeanPropertyRowMapper<Personas>(Personas.class), usuarios.getPersona().getDni());
            Float idPersona = personas.get(0).getIdPersona();
            //Ingresar un nuevo usuario en la tabla usuarui
            jdbcTemplate.update(queryUsuario, usuarios.getCorreo(), usuarios.getContrasenia(), 1, usuarios.getLatActual(), usuarios.getLonActual(), idPersona);
            //Ingresar un nuevo telefono
            jdbcTemplate.update(queryTelefono, usuarios.getPersona().getTelefonosUsuario().get(0).getNumero(), idPersona);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
}
