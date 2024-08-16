package hn.unah.bdi.uber.dtos;

import java.util.List;

import hn.unah.bdi.uber.Entities.Marca;
import lombok.Data;

@Data
public class MarcasModelos {
    
    private Integer idMarca;

    private String nombreMarca;

    private Integer idModelo;

    private String nombreModelo;

    private Integer ModeloMarca;

}
