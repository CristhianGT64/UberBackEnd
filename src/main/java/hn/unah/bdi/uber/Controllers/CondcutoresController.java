package hn.unah.bdi.uber.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hn.unah.bdi.uber.Services.Impl.ConductoresImpl;

@RestController
@RequestMapping("/api")
public class CondcutoresController {
    
    @Autowired
    ConductoresImpl conductoresImpl;

}
