package hn.unah.bdi.uber.Services.Impl;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import hn.unah.bdi.uber.Entities.Usuarios;
import hn.unah.bdi.uber.Services.UsuariosService;

public class UsuariosImpl implements UsuariosService{

    /* Este atributo nos apollara en la manipulacion de la base de datos */
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Boolean CrearUsuario(Usuarios usuarios) {
        
        String queryCrearUsuario = "BEGIN TRANSACTION; " +
        "INSERT INTO  VALUES (' " +usuarios.getPersona().getDni()+ "','" + usuarios.getPersona().getNombre1() + "', '" + usuarios.getPersona().getNombre2() + "', '" + usuarios.getPersona().getApellido1() + "', '"+ usuarios.getPersona().getApellido2() +"'); " +
        "INSERT INTO usuarios VALUES ('" +usuarios.getCorreo()+ "', '" + usuarios.getContrasenia() + "', LAST_INSERT_ROWID()); " +
        "INSERT INTO telefonos VALUES ('" + usuarios.getTelefono().getNumero() + "', AST_INSERT_ROWID()); " +
        "COMMIT;";
        
        if (this.jdbcTemplate.update(queryCrearUsuario) != 0) {
            return true;
        }
        return false;
    }
    
}
