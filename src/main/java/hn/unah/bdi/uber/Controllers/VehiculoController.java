package hn.unah.bdi.uber.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Entities.Marca;
import hn.unah.bdi.uber.Services.Impl.VehiculosImpl;
import hn.unah.bdi.uber.dtos.MarcaDto;
import hn.unah.bdi.uber.dtos.MarcasModelos;
import hn.unah.bdi.uber.dtos.ModeloDto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/api")
public class VehiculoController {
    @Autowired
    private VehiculosImpl vehiculosImpl;

    @GetMapping("/Vehiculos/Marcas")
    public List<MarcaDto> TraerMarcas() {
        return this.vehiculosImpl.TraerMarcas();
    }

    @GetMapping("/Vehiculos/Modelos")
    public List<ModeloDto> TraerModelos() {
        return this.vehiculosImpl.TraerModelos();
    }
    
}
