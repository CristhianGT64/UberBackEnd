USE master; 
GO
DROP DATABASE IF EXISTS uber;
GO
CREATE DATABASE uber;
Go
USE uber;
Go

--ya ya
CREATE TABLE personas( 
	idPersona INTEGER PRIMARY KEY IDENTITY(1,1),
	dni VARCHAR(255) UNIQUE,
	nombre1 VARCHAR(255),
	nombre2 VARCHAR(255),
	apellido1 VARCHAR(255),
	apellido2 VARCHAR(255)
);

--ya YA
CREATE TABLE usuarios(
	idUsuario INTEGER PRIMARY KEY IDENTITY(1,1),
	correo VARCHAR(50) UNIQUE,
	contrasenia VARCHAR(60) NOT NULL,
	latActual DECIMAL(9,7),
	lonActual DECIMAL(9,7),
	idPersona INTEGER REFERENCES personas(idPersona) UNIQUE,
	visible BIT
);

--ya YA
CREATE TABLE administradores(
	idAdministrador INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario)
);

--ya
CREATE TABLE telefonosUsuarios(
	idTelefono INTEGER PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(60) UNIQUE,
	idPersona INTEGER REFERENCES personas(idPersona) ON UPDATE CASCADE
);

--ya
CREATE TABLE estados(
	idEstado INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	disponible BIT
);

--ya YA
CREATE TABLE marcas(
	idMarca INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	disponible BIT
);

--ya YA
CREATE TABLE modelos(
	idModelo INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	idMarca INTEGER REFERENCES marcas(idMarca) ON UPDATE CASCADE ON DELETE CASCADE,
	disponible BIT,
	UNIQUE (idMarca, idModelo)
);

--ya YA
CREATE TABLE vehiculos(
	idVehiculo INTEGER PRIMARY KEY IDENTITY(1,1),
	numPlaca VARCHAR(10) UNIQUE,
	color VARCHAR(100),
	numPuertas INTEGER CHECK (numPuertas > 0 AND numPuertas < 5),
	anio INTEGER CHECK(anio > 2014 AND anio < 2030),
	numAsientos INTEGER CHECK (numAsientos > 0 AND numAsientos < 6),
	idMarca INTEGER REFERENCES marcas(idMarca),
	idModelo INTEGER REFERENCES modelos(idModelo),
	CONSTRAINT fk_marca_placa FOREIGN KEY (idMarca, idModelo) REFERENCES modelos(idMarca, idModelo),
	visible BIT
);

--ya YA
CREATE TABLE tiposFotografias(
	idTipoFotografia INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	diponible BIT,
);


--ya YA
CREATE TABLE licencias(
	idLicencia INTEGER PRIMARY KEY IDENTITY(1,1),
	licencia VARCHAR(255) NOT NULL UNIQUE,
	fechaVencimiento DATE
);

--YA YA
CREATE TABLE solicitudes(
	idSolicitud INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	fechaNacimiento DATE,
	idLicencia INTEGER REFERENCES licencias(idLicencia),
	colorVehiculo VARCHAR(255),
	numPlaca VARCHAR(10) UNIQUE,
	numPuertas INTEGER CHECK (numPuertas > 0 AND numPuertas < 5),
	anio INTEGER CHECK(anio > 2014 AND anio < 2030),
	numAsientos INTEGER CHECK (numAsientos > 0 AND numAsientos < 6),
	idMarca INTEGER REFERENCES marcas(idMarca),
	idModelo INTEGER REFERENCES modelos(idModelo),
	CONSTRAINT fk_marca_placa FOREIGN KEY (idMarca, idModelo) REFERENCES modelos(idMarca, idModelo),
	
);

--ya YA
CREATE TABLE fotografiasSolicitud(
	idFotografiaSolicitud INTEGER PRIMARY KEY IDENTITY(1,1),
	idTipoFotografia INTEGER REFERENCES tiposFotografias(idTipoFotografia),
	idSolicitud INTEGER REFERENCES solicitudes(idSolicitud),
	ubicacion TEXT
);

--ya YA
CREATE TABLE movimientos(
	idMovimiento INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	disponible bit
);

--ya YA
CREATE TABLE CuentasConductores(
	idCuentaConductor INTEGER PRIMARY KEY IDENTITY(1,1),
	saldo DECIMAL(10,2) CHECK (saldo > 0)
);
--ya YA
CREATE TABLE historialCuentas(
	idHistorialCuentas INTEGER PRIMARY KEY IDENTITY(1,1),
	idCuenta INTEGER REFERENCES CuentasConductores(idCuentaConductor),
	idMovimientos INTEGER REFERENCES movimientos(idMovimiento),
	fechaMovimiento DATETIME,
	cantidad DECIMAL(10,2),
	descripcion TEXT
);

--ya YA
CREATE TABLE conductores(
	idConductor INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	numPlaca VARCHAR(10) REFERENCES vehiculos(numPlaca),
	idCuenta INTEGER REFERENCES CuentasConductores(idCuentaConductor),
	disponible BIT
);

--ya YA
CREATE TABLE roles(
	idRol INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) UNIQUE,
	descripcion TEXT
);

--ya YA
CREATE TABLE usuariosRoles(
	idUsuarioRol INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	idRol INTEGER REFERENCES roles(idRol)
);

--ya YA
CREATE TABLE verificacionesSolicitudes(
	idVerificacionSolicitud INTEGER PRIMARY KEY IDENTITY(1,1),
	idSolicitud INTEGER REFERENCES solicitudes(idSolicitud) UNIQUE,
	idAdministrador INTEGER REFERENCES administradores(idAdministrador),
	idEstado INTEGER REFERENCES estados(idEstado),
	fechaRevision TIMESTAMP,
	observaciones TEXT
);

--ya YA
CREATE TABLE solicitudesViajes(
	idSolicitudViaje INTEGER PRIMARY KEY IDENTITY(1,1),
	idEstado INTEGER REFERENCES estados(idEstado),
	latitudOrigen DECIMAL(9,7),
	longitudOrigen DECIMAL(9,7),
	latitudDestino DECIMAL(9,7),
	longitudDestino DECIMAL(9,7),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	tarifa MONEY,
	distancia FLOAT,
	fechaSolicitud DATETIME,
);

--ya YA
CREATE TABLE viajes(
	idViaje INTEGER PRIMARY KEY IDENTITY(1,1),
	idConductor INTEGER REFERENCES conductores(idConductor),
	fechaIni DATETIME,
	fechaFin DATETIME,
	idSolicitudViaje INTEGER REFERENCES solicitudesViajes(idSolicitudViaje)
);

--Ya YA
CREATE TABLE mensajes(
	idMensaje INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	mensaje TEXT,
	fechaHora DATETIME,
	idSolicitudViaje INTEGER REFERENCES solicitudesViajes(idSolicitudViaje) 
);

--ya YA
CREATE TABLE historialesConductores(
	idhistorialConductor INTEGER PRIMARY KEY IDENTITY(1,1),
	idViaje INTEGER REFERENCES viajes(idViaje),
	evaluacion INTEGER,
	comentario TEXT
);

--CREATE TABLE historialesClientes(
	--idhistorialClientes INTEGER PRIMARY KEY IDENTITY(1,1),
	--idViaje INTEGER REFERENCES viajes(idViaje),
	--evaluacion INTEGER,
	--comentario TEXT
--);

--ya YA
CREATE TABLE cais(
	idCai INTEGER PRIMARY KEY IDENTITY(1,1),
	cai VARCHAR(255) UNIQUE,
	fechaLimiteEmision DATE,
	disponible BIT
);

--YA YA
CREATE TABLE metodosPagos(
	idMetodoPago INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	disponible BIT
);

--YA YA
CREATE TABLE empresa(
	idEmpresa INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255)UNIQUE,
	rtn VARCHAR(20) UNIQUE
);

--YA YA
CREATE TABLE correos(
	idCorreo INTEGER PRIMARY KEY IDENTITY(1,1),
	correo VARCHAR(200) UNIQUE,
	disponible BIT,
	idEmpresa INTEGER REFERENCES empresa(idEmpresa)
);
--YA YA
CREATE TABLE sucursales(
	idSucursal INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	domicilio TEXT,
	idEmpresa INTEGER REFERENCES empresa(idEmpresa),
);

--YA  YA
CREATE TABLE telefonosSucursales(
	idTelefonosSucursales INTEGER PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(20) UNIQUE,
	disponible BIT,
	idSucursal INTEGER REFERENCES sucursales(idSucursal)
);

--CREATE TABLE numCorrelativo(
	--idNumCorrelativo INTEGER PRIMARY KEY IDENTITY(1,1),
	--correlativo BIGINT
--);

--YA YA
CREATE TABLE tiposDocumentos(
	idTipoDocumento INTEGER PRIMARY KEY IDENTITY(1,1),
	numero INTEGER UNIQUE,
	nombre VARCHAR(255) UNIQUE,
	disponible BIT
	--idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	--UNIQUE (idNumCorrelativo, idTipoDocumento)
);

--YA YA
CREATE TABLE establecimiento(
	idEstablecimiento INTEGER PRIMARY KEY IDENTITY(1,1),
	numero INTEGER UNIQUE,
	--idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	idTipoDocumento INTEGER REFERENCES tiposDocumentos(idTipoDocumento),
	--CONSTRAINT FK_numCorrelativo_tipoDocumento FOREIGN KEY (idTipoDocumento) REFERENCES tiposDocumentos(idNumCorrelativo,idTipoDocumento),
	UNIQUE(idTipoDocumento, idEstablecimiento)
);

--Ya YA
CREATE TABLE rangoEmision(
	idRangoEmision INTEGER PRIMARY KEY IDENTITY(1,1),
	inicioRango INTEGER CHECK(inicioRango > 0),
	finalRango INTEGER 
);

--YA YA
CREATE TABLE puntosEmision(
	idPuntoEmision INTEGER PRIMARY KEY IDENTITY(1,1),
	numero INTEGER,
	--idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	idTipoDocumento INTEGER REFERENCES tiposDocumentos(idTipoDocumento),
	idRangoEmision INTEGER REFERENCES rangoEmision(idRangoEmision),
	idEstablecimiento INTEGER REFERENCES establecimiento(idEstablecimiento),
	CONSTRAINT FK_tipoDocumento_establecimiento FOREIGN KEY (idTipoDocumento, idEstablecimiento) REFERENCES establecimiento(idTipoDocumento, idEstablecimiento),
	UNIQUE(idTipoDocumento, idEstablecimiento, idPuntoEmision)
);

--YA YA
CREATE TABLE numerosFacturas(
	idNumFactura INTEGER PRIMARY KEY IDENTITY(1,1),
	numeroFormulado VARCHAR(255) UNIQUE,
	numCorrelativo INTEGER UNIQUE,
	--idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	idTipoDocumento INTEGER REFERENCES tiposDocumentos(idTipoDocumento),
	idEstablecimiento INTEGER REFERENCES establecimiento(idEstablecimiento),
	idPuntoEmision INTEGER REFERENCES puntosEmision(idPuntoEmision),
	CONSTRAINT FK_tipoDocumento_establecimiento_PEmision FOREIGN KEY (idTipoDocumento, idEstablecimiento, idPuntoEmision) REFERENCES puntosEmision(idTipoDocumento, idEstablecimiento, idPuntoEmision),
	UNIQUE(idTipoDocumento, idEstablecimiento, idPuntoEmision, numCorrelativo),
);



--ya 
CREATE TABLE facturas(
	idFactura INTEGER PRIMARY KEY IDENTITY(1,1),
	numFactura VARCHAR(255) REFERENCES numerosFacturas(numeroFormulado) UNIQUE,
	idMetodoPago INTEGER REFERENCES metodosPagos(idMetodoPago),
	idCai INTEGER REFERENCES cais(idCai),
	subTotal MONEY,
	idViaje INTEGER REFERENCES viajes(idViaje),
	isv MONEY,
	total MONEY,
	idEmpresa INTEGER REFERENCES empresa(idEmpresa)
);



SELECT * FROM usuarios;
SELECT * FROM personas;
SELECT * FROM telefonosUsuarios;
GO

-- Insert de catalogos
INSERT INTO estados VALUES('Pendiente', 1);
INSERT INTO estados VALUES('Aceptada', 1);
INSERT INTO estados VALUES('Rechazada', 1);
INSERT INTO estados VALUES('Cancelada', 1);
INSERT INTO estados VALUES('Realizada', 1);
INSERT INTO estados VALUES('En Proceso', 1);
INSERT INTO marcas VALUES('Ford', 1);
INSERT INTO marcas VALUES('Toyota', 1);
INSERT INTO marcas VALUES('Nissan', 1);
INSERT INTO marcas VALUES('Honda', 1);
INSERT INTO marcas VALUES('Hyundai', 1);
INSERT INTO marcas VALUES('Kia', 1);
INSERT INTO marcas VALUES('Volkswagen', 1);
INSERT INTO marcas VALUES('Renault', 1);
INSERT INTO marcas VALUES('Peugeot', 1);
INSERT INTO marcas VALUES('Mazda', 1);
INSERT INTO marcas VALUES('Suzuki', 1);
INSERT INTO marcas VALUES('BMW', 1);
GO

INSERT INTO modelos VALUES('Focus', 1, 1);
INSERT INTO modelos VALUES('Fiesta', 1, 1);
INSERT INTO modelos VALUES('Corolla', 1, 1);
INSERT INTO modelos VALUES('Camry', 2, 2);
INSERT INTO modelos VALUES('Yaris', 2, 2);
INSERT INTO modelos VALUES('Sentra', 2, 2);
INSERT INTO modelos VALUES('Civic', 2, 2);
INSERT INTO modelos VALUES('Fit', 3, 3);
INSERT INTO modelos VALUES('Tucson', 3, 3);
INSERT INTO modelos VALUES('Elantra', 3, 3);
INSERT INTO modelos VALUES('Accent', 4, 4);
INSERT INTO modelos VALUES('Picanto', 4, 4);
INSERT INTO modelos VALUES('JETTA', 5, 5);
INSERT INTO modelos VALUES('Clio', 5, 5);
INSERT INTO modelos VALUES('Pegout', 5, 5);
GO

INSERT INTO modelos VALUES('Focus', 1, 1);
INSERT INTO modelos VALUES('Fiesta', 1, 1);
INSERT INTO modelos VALUES('Corolla', 1, 1);
INSERT INTO modelos VALUES('Camry', 2, 2);
INSERT INTO modelos VALUES('Yaris', 2, 2);
INSERT INTO modelos VALUES('Sentra', 2, 2);
INSERT INTO modelos VALUES('Civic', 2, 2);
INSERT INTO modelos VALUES('Fit', 3, 3);
INSERT INTO modelos VALUES('Tucson', 3, 3);
INSERT INTO modelos VALUES('Elantra', 3, 3);
INSERT INTO modelos VALUES('Accent', 4, 4);
INSERT INTO modelos VALUES('Picanto', 4, 4);
INSERT INTO modelos VALUES('JETTA', 5, 5);
INSERT INTO modelos VALUES('Clio', 5, 5);
INSERT INTO modelos VALUES('Pegout', 5, 5);
GO

INSERT INTO roles VALUES('Administrador', 'Administrador del sistema');
INSERT INTO roles VALUES('Conductor', 'Conductor de un vehiculo');
INSERT INTO roles VALUES('Cliente', 'Consumidor de servicios');

SELECT * FROM roles;

INSERT INTO tiposFotografias VALUES('Carnet', 1);
INSERT INTO tiposFotografias VALUES('Foto Licencia', 1);
INSERT INTO tiposFotografias VALUES('Foto Vehiculo', 1);
INSERT INTO tiposFotografias VALUES('Foto Persona', 1);
INSERT INTO tiposFotografias VALUES('Foto Confirmacion', 1);

SELECT * FROM tiposFotografias;


INSERT INTO movimientos VALUES('Entrada', 1);
INSERT INTO movimientos VALUES('Salida', 1);
INSERT INTO rangoEmision VALUES(1, 100);
INSERT INTO rangoEmision VALUES(101, 200);
INSERT INTO rangoEmision VALUES(301, 300);
INSERT INTO tiposDocumentos VALUES(01, 'Factura', 1);
INSERT INTO establecimiento VALUES(1, 01);
INSERT INTO puntosEmision VALUES(001, 1, 01, 01, 1);
INSERT INTO metodosPagos VALUES('Efectivo', 1);
INSERT INTO metodosPagos VALUES('Credito', 1);
INSERT INTO empresa VALUES('Uber', 08012024123456);
INSERT INTO cais VALUES('1234-5689', '12-12-2024', 1);
INSERT INTO telefonosSucursales VALUES(1234-5689);
INSERT INTO Correos VALUES('uber@gmail.com', 1, 1)
INSERT INTO Sucursales VALUES('Sucursal 1','Col Vista Hermosa', 1);
GO
SELECT * FROM usuariosRoles;

INSERT INTO personas VALUES('0801200206928', 'Cristhian', 'David', 'Ordoniez', 'Lopez');
INSERT INTO usuarios VALUES('crisadmin@correo.com', '1234', 2, 2, 1, 1);
INSERT INTO telefonosUsuarios VALUES ('22237877', 1);
INSERT INTO usuariosRoles VALUES(1,2),(1,1)
GO
--Triguer que cuando se inserta un nuevo usuario se le asigna un nuevo rol

CREATE or ALTER TRIGGER T_usuarios_roles 
ON usuarios 
AFTER INSERT
AS	
BEGIN
    INSERT INTO usuariosRoles (idUsuario, idRol)
    SELECT i.idUsuario, 3
    FROM inserted i;
END;

--procedimiento almacenado para confirmar si un usuario existe o no
CREATE or ALTER PROCEDURE VerificarUsuario
    @correo NVARCHAR(255),
    @contraseña NVARCHAR(255),
    @existe BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @count INT;
    SELECT @count = COUNT(*)
    FROM usuarios
    WHERE correo = @correo AND contrasenia = @contraseña;
    IF @count > 0
    BEGIN
        SET @existe = 1;
    END
    ELSE
    BEGIN
        SET @existe = 0;
    END
END;

--fIN DEL PROCEDIMIENTO ALMACENADO

--Uso del procedimiento almacenado
DECLARE @existe BIT;
EXEC VerificarUsuario
    @correo = 'crisadmin@correo.com',
    @contraseña = '1234',
    @existe = @existe OUTPUT;
SELECT @existe AS ExisteUsuario;
--Fin del procedimiento Almacenado

SELECT * FROM usuarios;