package hn.unah.bdi.uber.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Services.Impl.VehiculosImpl;
import hn.unah.bdi.uber.dtos.MarcasModelos;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/api")
public class VehiculoController {
    @Autowired
    private VehiculosImpl vehiculosImpl;

    @GetMapping("/Vehiculos/MarcasModelos")
    public List<MarcasModelos> TraerMarcasModels() {
        return this.vehiculosImpl.ModelosMarcas();
    }
    
}
