package hn.unah.bdi.uber.Services.Impl;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.Services.UsuariosService;

@Service
public class UsuariosImpl implements UsuariosService{

    /* Este atributo nos apollara en la manipulacion de la base de datos */
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Boolean CrearUsuario(Usuarios usuarios) {
        
        String queryCrearUsuario = "BEGIN TRANSACTION; " +
        "INSERT INTO personas  (dni, nombre1, nombre2, apellido1, apellido2)  VALUES " +
        "(' " +usuarios.getPersona().getDni()+ "','" + usuarios.getPersona().getNombre1() + "', '" + usuarios.getPersona().getNombre2() + "', '" + usuarios.getPersona().getApellido1() + "', '"+ usuarios.getPersona().getApellido2() +"'); " +
        "DECLARE @idPersona INT; SET @idPersona = SCOPE_IDENTITY();" +
        "INSERT INTO usuarios (correo, contrasenia, idPersona)  VALUES ('" +usuarios.getCorreo()+ "', '" + usuarios.getContrasenia() + "', @idPersona); " +
        "INSERT INTO telefonos (numero, idPersona) VALUES ('" + usuarios.getPersona().getTelefonos().get(0).getNumero() + "', @idPersona); " +
        "COMMIT;";
        
        if (this.jdbcTemplate.update(queryCrearUsuario) != 0) {
            return true;
        }
        return false;
    }
    
}
