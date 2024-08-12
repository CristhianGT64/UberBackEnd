USE master; 
GO
DROP DATABASE IF EXISTS uber;
GO
CREATE DATABASE uber;
Go
USE uber;
Go

--ya
CREATE TABLE personas( 
	idPersona INTEGER PRIMARY KEY IDENTITY(1,1),
	dni VARCHAR(255) UNIQUE,
	nombre1 VARCHAR(255),
	nombre2 VARCHAR(255),
	apellido1 VARCHAR(255),
	apellido2 VARCHAR(255)
);

--ya
CREATE TABLE usuarios(
	idUsuario INTEGER PRIMARY KEY IDENTITY(1,1),
	correo VARCHAR(50) UNIQUE,
	contrasenia VARCHAR(60) NOT NULL,
	latActual DECIMAL(9,7),
	lonActual DECIMAL(9,7),
	idPersona INTEGER REFERENCES personas(idPersona) ON UPDATE CASCADE UNIQUE,
	visible BIT
);

--ya
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
	nombre VARCHAR(255),
	disponible BIT
);

--ya
CREATE TABLE marcas(
	idMarca INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	disponible BIT
);

CREATE TABLE modelos(
	idModelo INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	idMarca INTEGER REFERENCES marcas(idMarca) ON UPDATE CASCADE ON DELETE CASCADE,
	disponible BIT,
	UNIQUE (idMarca, idModelo)
);

CREATE TABLE vehiculos(
	idVehiculo INTEGER PRIMARY KEY IDENTITY(1,1),
	numPlaca VARCHAR(10) UNIQUE,
	color VARCHAR(100),
	idMarca INTEGER REFERENCES marcas(idMarca),
	idModelo INTEGER REFERENCES modelos(idModelo),
	CONSTRAINT fk_marca_placa FOREIGN KEY (idMarca, idModelo) REFERENCES modelos(idMarca, idModelo),
	visible BIT
);

CREATE TABLE tiposFotografias(
	idTipoFotografia INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	diponible BIT,
	ubicacion TEXT
);

CREATE TABLE licencias(
	idLicencia INTEGER PRIMARY KEY IDENTITY(1,1),
	licencia VARCHAR(255) NOT NULL UNIQUE,
	fechaVencimiento DATE
);

CREATE TABLE solicitudes(
	idSolicitud INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	fechaNacimiento DATE,
	idLicencia INTEGER REFERENCES licencias(idLicencia),
	color VARCHAR(255)
);


CREATE TABLE fotografiasSolicitud(
	idFotografiaSolicitud INTEGER PRIMARY KEY IDENTITY(1,1),
	idTipoFotografia INTEGER REFERENCES tiposFotografias(idTipoFotografia),
	idSolicitud INTEGER REFERENCES solicitudes(idSolicitud)
);

CREATE TABLE movimientos(
	idMovimiento INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	diponible INT
);


CREATE TABLE CuentasConductores(
	idCuentaConductor INTEGER PRIMARY KEY IDENTITY(1,1),
	saldo DECIMAL(10,2) CHECK (saldo > 0)
);

CREATE TABLE historialCuentas(
	idHistorialCuentas INTEGER PRIMARY KEY IDENTITY(1,1),
	idCuenta INTEGER REFERENCES CuentasConductores(idCuentaConductor),
	idMovimientos INTEGER REFERENCES movimientos(idMovimiento),
	fechaMovimiento DATETIME,
	cantidad DECIMAL(10,2),
	descripcion TEXT
);

CREATE TABLE conductores(
	idConductor INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	numPlaca VARCHAR(10) REFERENCES vehiculos(numPlaca),
	idCuenta INTEGER REFERENCES CuentasConductores(idCuentaConductor),
	disponible BIT
);


CREATE TABLE roles(
	idRol INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	descripcion TEXT
);

CREATE TABLE usuariosRoles(
	idUsuarioRol INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	idRol INTEGER REFERENCES roles(idRol)
);


CREATE TABLE verificacionesSolicitudes(
	idVerificacionSolicitud INTEGER PRIMARY KEY IDENTITY(1,1),
	idSolicitud INTEGER REFERENCES solicitudes(idSolicitud) UNIQUE,
	idAdministrador INTEGER REFERENCES administradores(idAdministrador),
	idEstado INTEGER REFERENCES estados(idEstado),
	fechaRevision TIMESTAMP,
	observaciones TEXT
);

CREATE TABLE solicitudesViajes(
	idSolicitudViaje INTEGER PRIMARY KEY IDENTITY(1,1),
	idEstado INTEGER REFERENCES estados(idEstado),
	latitudOrigen DECIMAL(9,7),
	longitudOrigen DECIMAL(9,7),
	latitudDestino DECIMAL(9,7),
	latituDestino DECIMAL(9,7),
	idCliente INTEGER REFERENCES usuarios(idUsuario),
	tarifa MONEY,
	distancia FLOAT,
	fechaSolicitud DATETIME,
);

CREATE TABLE viajes(
	idViaje INTEGER PRIMARY KEY IDENTITY(1,1),
	idConductor INTEGER REFERENCES conductores(idConductor),
	fechaIni DATETIME,
	fechaFin DATETIME,
	idSolicitudViaje INTEGER REFERENCES solicitudesViajes(idSolicitudViaje) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE mensajes(
	idMensaje INTEGER PRIMARY KEY IDENTITY(1,1),
	idUsuario INTEGER REFERENCES usuarios(idUsuario),
	mensaje TEXT,
	fechaHora DATETIME,
	idSolicitudViaje INTEGER REFERENCES solicitudesViajes(idSolicitudViaje) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE historialesConductores(
	idhistorialConductor INTEGER PRIMARY KEY IDENTITY(1,1),
	idViaje INTEGER REFERENCES viajes(idViaje),
	evaluacion INTEGER,
	comentario TEXT
);

CREATE TABLE historialesClientes(
	idhistorialClientes INTEGER PRIMARY KEY IDENTITY(1,1),
	idViaje INTEGER REFERENCES viajes(idViaje),
	evaluacion INTEGER,
	comentario TEXT
);

CREATE TABLE cais(
	idCai INTEGER PRIMARY KEY IDENTITY(1,1),
	cai VARCHAR(255) UNIQUE,
	fechaLimiteEmision DATE,
	disponible BIT
);

CREATE TABLE metodosPagos(
	idMetodoPago INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255) UNIQUE,
	disponible BIT
);

CREATE TABLE empresa(
	idEmpresa INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	rtn VARCHAR(20)
);

CREATE TABLE correos(
	idCorreo INTEGER PRIMARY KEY IDENTITY(1,1),
	correo VARCHAR(200),
	disponible BIT,
	idEmpresa INTEGER REFERENCES empresa(idEmpresa)
);

CREATE TABLE sucursales(
	idSucursal INTEGER PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(255),
	domicilio TEXT,
	idEmpresa INTEGER REFERENCES empresa(idEmpresa),
);

CREATE TABLE telefonosSucursales(
	idTelefonosSucursales INTEGER PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(20) UNIQUE,
	disponible BIT,
	idSucursal INTEGER REFERENCES sucursales(idSucursal)
);

CREATE TABLE numCorrelativo(
	idNumCorrelativo INTEGER PRIMARY KEY IDENTITY(1,1),
	correlativo BIGINT
);

CREATE TABLE tiposDocumentos(
	idTipoDocumento INTEGER PRIMARY KEY IDENTITY(1,1),
	numero INTEGER,
	nombre VARCHAR(255),
	idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	UNIQUE (idNumCorrelativo, idTipoDocumento)
);

CREATE TABLE establecimiento(
	idEstablecimiento INTEGER PRIMARY KEY IDENTITY(1,1),
	numero INTEGER,
	idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	idTipoDocumento INTEGER REFERENCES tiposDocumentos(idTipoDocumento),
	CONSTRAINT FK_numCorrelativo_tipoDocumento FOREIGN KEY (idNumCorrelativo,idTipoDocumento) REFERENCES tiposDocumentos(idNumCorrelativo,idTipoDocumento),
	UNIQUE(idNumCorrelativo,idTipoDocumento, idEstablecimiento)
);

CREATE TABLE puntosEmision(
	idPuntoEmision INTEGER PRIMARY KEY IDENTITY(1,1),
	numero INTEGER,
	idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	idTipoDocumento INTEGER REFERENCES tiposDocumentos(idTipoDocumento),
	idEstablecimiento INTEGER REFERENCES establecimiento(idEstablecimiento),
	CONSTRAINT FK_numCorrelativo_tipoDocumento_establecimiento FOREIGN KEY (idNumCorrelativo,idTipoDocumento, idEstablecimiento) REFERENCES establecimiento(idNumCorrelativo,idTipoDocumento, idEstablecimiento),
	UNIQUE(idNumCorrelativo,idTipoDocumento, idEstablecimiento, idPuntoEmision)
);

CREATE TABLE numerosFacturas(
	idNumFactura INTEGER PRIMARY KEY IDENTITY(1,1),
	numeroFormulado VARCHAR(255) UNIQUE,
	idNumCorrelativo INTEGER REFERENCES numCorrelativo(idNumCorrelativo),
	idTipoDocumento INTEGER REFERENCES tiposDocumentos(idTipoDocumento),
	idEstablecimiento INTEGER REFERENCES establecimiento(idEstablecimiento),
	idPuntoEmision INTEGER REFERENCES puntosEmision(idPuntoEmision),
	CONSTRAINT FK_numCorrelativo_tipoDocumento_establecimiento_PEmision FOREIGN KEY (idNumCorrelativo,idTipoDocumento, idEstablecimiento, idPuntoEmision) REFERENCES puntosEmision(idNumCorrelativo,idTipoDocumento, idEstablecimiento, idPuntoEmision),
	UNIQUE(idNumCorrelativo,idTipoDocumento, idEstablecimiento, idPuntoEmision, numeroFormulado)
);


CREATE TABLE facturas(
	idFcatura INTEGER PRIMARY KEY IDENTITY(1,1),
	numFactura VARCHAR(255) REFERENCES numerosFacturas(numeroFormulado) UNIQUE,
	idMetodo INTEGER REFERENCES metodosPagos(idMetodoPago),
	idCais INTEGER REFERENCES cais(idCai),
	subTotal MONEY,
	idViaje INTEGER REFERENCES viajes(idViaje),
	isv MONEY,
	total MONEY,
	idEmpresa INTEGER REFERENCES empresa(idEmpresa)
);



SELECT * FROM usuarios;
SELECT * FROM personas;
SELECT * FROM conductores;
