package hn.unah.bdi.uber.Services;

import java.util.List;

import hn.unah.bdi.uber.dtos.MarcaDto;
import hn.unah.bdi.uber.dtos.MarcasModelos;
import hn.unah.bdi.uber.dtos.ModeloDto;

public interface vehiculosService {
    public List<MarcasModelos> ModelosMarcas();

    public List<MarcaDto> TraerMarcas();

    public List<ModeloDto> TraerModelos();
}
