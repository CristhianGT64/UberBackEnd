package hn.unah.bdi.uber.Entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "tiposFotografias")
public class tiposFotografias {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtipofotografia")
    private Float idTipoFotografia;

    private String nombre;

    private Boolean disponible;

    private String ubicacion;



}   
