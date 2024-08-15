package hn.unah.bdi.uber.Services.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import hn.unah.bdi.uber.Services.CondcutoresService;

public class ConductoresImpl implements CondcutoresService{
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
}
