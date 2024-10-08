package hn.unah.bdi.uber.Services.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import hn.unah.bdi.uber.Entities.Personas;
import hn.unah.bdi.uber.Services.vehiculosService;
import hn.unah.bdi.uber.dtos.MarcaDto;
import hn.unah.bdi.uber.dtos.MarcasModelos;
import hn.unah.bdi.uber.dtos.ModeloDto;

@Service
public class VehiculosImpl implements vehiculosService{

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<MarcasModelos> ModelosMarcas() {

        String query = "SELECT ma.idMarca idMarca, ma.nombre nombreMarca,mo.idModelo idModelo, mo.nombre nombreModelo, mo.idMarca ModeloMarca FROM modelos mo ";
	    query += "INNER JOIN marcas ma ON ma.idMarca = mo.idMarca;";

        return this.jdbcTemplate.query(query, new BeanPropertyRowMapper<MarcasModelos>(MarcasModelos.class));
    }

    @Override
    public List<MarcaDto> TraerMarcas() {
        String query = "SELECT ma.idMarca idMarca, ma.nombre nombreMarca FROM marcas ma";
        return this.jdbcTemplate.query(query, new BeanPropertyRowMapper<MarcaDto>(MarcaDto.class));
    }

    @Override
    public List<ModeloDto> TraerModelos() {
        String query = "SELECT mo.idModelo idModelo, mo.nombre nombreModelo, mo.idMarca ModeloMarca FROM modelos mo";
        return this.jdbcTemplate.query(query, new BeanPropertyRowMapper<ModeloDto>(ModeloDto.class));
    }
    
}
