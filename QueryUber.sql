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
	idMarca INTEGER REFERENCES marcas(idMarca),
	disponible BIT,
	UNIQUE (idMarca, idModelo)
);

--ya YA
CREATE TABLE vehiculos(
	idVehiculo INTEGER PRIMARY KEY IDENTITY(1,1),
	numPlaca VARCHAR(10),
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
	numPlaca VARCHAR(10),
	numPuertas INTEGER CHECK (numPuertas > 0 AND numPuertas < 5),
	anio INTEGER CHECK(anio > 2014 AND anio < 2030),
	numAsientos INTEGER CHECK (numAsientos > 0 AND numAsientos < 6),
	idMarca INTEGER REFERENCES marcas(idMarca),
	idModelo INTEGER REFERENCES modelos(idModelo),
	CONSTRAINT FK_PLACA_MARCA FOREIGN KEY (idMarca, idModelo) REFERENCES modelos(idMarca, idModelo)
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
	idVehiculo INTEGER REFERENCES vehiculos(idVehiculo),
	idCuenta INTEGER REFERENCES CuentasConductores(idCuentaConductor),
	idSolicitud INTEGER REFERENCES solicitudes(idSolicitud),
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
	fechaRevision DATE,
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
	CONSTRAINT FK_TIPDOC_SI FOREIGN KEY (idTipoDocumento, idEstablecimiento) REFERENCES establecimiento(idTipoDocumento, idEstablecimiento),
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


-- Insert de catalogos
INSERT INTO estados VALUES('Pendiente', 1);
INSERT INTO estados VALUES('Aceptada', 1);
INSERT INTO estados VALUES('Rechazada', 1);
INSERT INTO estados VALUES('Cancelada', 1);
INSERT INTO estados VALUES('Realizada', 1);
INSERT INTO estados VALUES('En Proceso', 1);
GO

INSERT INTO marcas VALUES('Ford', 1);
INSERT INTO marcas VALUES('Toyota', 1);
INSERT INTO marcas VALUES('Nissan', 1);
INSERT INTO marcas VALUES('Honda', 1);
INSERT INTO marcas VALUES('Hyundai', 1);
INSERT INTO marcas VALUES('Kia', 1);
INSERT INTO marcas VALUES('Volkswagen', 1);
INSERT INTO marcas VALUES('Renault', 1);
INSERT INTO marcas VALUES('Mazda', 1);
INSERT INTO marcas VALUES('Suzuki', 1);
GO

INSERT INTO modelos VALUES('Focus', 1, 1);
INSERT INTO modelos VALUES('Fiesta', 1, 1);
INSERT INTO modelos VALUES('Corolla', 2, 1);
INSERT INTO modelos VALUES('Camry', 2, 1);
INSERT INTO modelos VALUES('Yaris', 2, 1);
INSERT INTO modelos VALUES('Sentra', 3, 1);
INSERT INTO modelos VALUES('Civic', 4, 1);
INSERT INTO modelos VALUES('Fit', 4, 1);
INSERT INTO modelos VALUES('Elantra', 5, 1);
INSERT INTO modelos VALUES('Accent', 5, 1);
INSERT INTO modelos VALUES('Tucson', 5, 1);
INSERT INTO modelos VALUES('Picanto', 6, 1);
INSERT INTO modelos VALUES('JETTA', 7, 1);
INSERT INTO modelos VALUES('Clio', 8, 1);
INSERT INTO modelos VALUES('3', 9, 1);
INSERT INTO modelos VALUES('Swift', 9, 1);
GO

INSERT INTO roles VALUES('Administrador', 'Administrador del sistema');
INSERT INTO roles VALUES('Conductor', 'Conductor de un vehiculo');
INSERT INTO roles VALUES('Cliente', 'Consumidor de servicios');

INSERT INTO tiposFotografias VALUES('Carnet', 1);
INSERT INTO tiposFotografias VALUES('Foto Licencia', 1);
INSERT INTO tiposFotografias VALUES('Foto Vehiculo', 1);
INSERT INTO tiposFotografias VALUES('Foto Persona', 1);
INSERT INTO tiposFotografias VALUES('Foto Confirmacion', 1);


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
GO

--Ingresar un usuario administrador

INSERT INTO personas VALUES('08012002069270', 'Cristhian', 'David', 'Ordoniez', 'Lopez');
GO
INSERT INTO usuarios VALUES('crisadmin2@correo.com', '1234', 2, 2, 1, 1);
GO
INSERT INTO telefonosUsuarios VALUES ('22237889', 1);
GO
INSERT INTO usuariosRoles VALUES(1,2),(1,1)
GO
INSERT INTO administradores VALUES(1);
GO

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
GO

--PROCEDIMIENTO ALMACENADO PARA INGRESAR licencias y solictudes y fotografias
CREATE OR ALTER PROC P_LICENCIAS_SOLI_FOTO
	@licencia VARCHAR(255),
    @fechaVencimiento DATE,
    @idUsuario INTEGER,
    @fechaNacimiento DATE,
    @colorVehiculo VARCHAR(255),
    @numPlaca VARCHAR(10),
    @numPuertas INTEGER,
    @anio INTEGER,
    @numAsientos INTEGER,
    @idMarca INTEGER,
    @idModelo INTEGER,
	@fotoLicencia TEXT,
	@fotoVehiculo TEXT,
	@fotoPersona TEXT
AS
BEGIN
	BEGIN TRANSACTION;
		BEGIN TRY 
			 -- Insertar en la tabla licencias
			INSERT INTO licencias
			VALUES (@licencia, @fechaVencimiento);
			-- Obtener el último idLicencia insertado
			DECLARE @ultimaLicencia INTEGER;
			SET @ultimaLicencia = SCOPE_IDENTITY();
			--Almacenar la solicitud
			INSERT INTO solicitudes
			VALUES(
				@idUsuario,
				@fechaNacimiento,
				@ultimaLicencia,
				@colorVehiculo,
				@numPlaca,
				@numPuertas,
				@anio,
				@numAsientos,
				@idMarca,
				@idModelo
			);
			--Almacenar el id de la solicitud
			DECLARE @ultimaSolicitud INTEGER;
			SET @ultimaSolicitud = SCOPE_IDENTITY();
			--Ingresar fotokgrafias segun solicitud
			INSERT INTO fotografiasSolicitud VALUES
			(2, @ultimaSolicitud, @fotoLicencia),
			(3,@ultimaSolicitud, @fotoVehiculo),
			(4, @ultimaSolicitud, @fotoPersona);

			--Llenar la tabla de verificacionde solicitides
			INSERT INTO verificacionesSolicitudes
			VALUES (@ultimaSolicitud,null,1,null,null);

			        -- Si todo sale bien, se confirma la transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, se revierte la transacción
        ROLLBACK TRANSACTION;
        -- Opcional: Puedes lanzar el error o manejarlo de otra forma
        THROW;
    END CATCH
END;
GO
---fIN DEL PROCEDIMIENTO ALMACENADO	

--Procedimiento almacenado para traer un detalle mas vistoso de las solicitudes
CREATE OR ALTER PROC P_DETALLES_SOL
AS
	BEGIN
		SELECT S.idSolicitud ,u.correo, p.nombre1 + ' ' + p.nombre2+ ' ' + p.apellido1 + ' ' + p.apellido2 nombreCompleto,
		t.numero, s.fechaNacimiento, l.licencia, l.fechaVencimiento, s.colorVehiculo,
		s.numPlaca, s.numPuertas, s.anio, s.numAsientos, ma.nombre nombreMarca, mo.nombre nombreModelo FROM solicitudes s
		INNER JOIN usuarios u ON u.idUsuario = s.idUsuario
		INNER JOIN telefonosUsuarios t ON t.idPersona = u.idPersona
		INNER JOIN personas p ON u.idPersona = p.idPersona
		INNER JOIN licencias l ON l.idLicencia = s.idLicencia
		INNER JOIN marcas ma ON ma.idMarca = s.idMarca
		INNER JOIN modelos mo ON mo.idModelo = s.idModelo
		INNER JOIN verificacionesSolicitudes vs ON vs.idSolicitud = s.idSolicitud
		WHERE vs.idEstado = 1;
	END;


		--EXEC P_DETALLES_SOL;

GO

--Procedimiento almacenado que trae LAS fotografias que estan pendientes de ver
CREATE OR ALTER PROC P_FOTOGRAFIAS_PENDIENTES
AS
	BEGIN
		SELECT fs.idTipoFotografia, fs.idSolicitud, fs.ubicacion FROM fotografiasSolicitud fs
		INNER JOIN verificacionesSolicitudes vs ON fs.idSolicitud = vs.idSolicitud
		where vs.idEstado = 1;
	END;
GO
		--EXEC P_FOTOGRAFIAS_PENDIENTES;


--PROCEDIMIENTO ALMACENADO PARA ACEPTAR SOLICITUDES
CREATE OR ALTER PROC P_ACEPTAR_SOLICITUDES
    @idUsuario INTEGER,
    @idSolicitud INTEGER
AS
BEGIN
	BEGIN TRANSACTION;
		BEGIN TRY 
			DECLARE @idAdministrador INTEGER;
			SET @idAdministrador =(SELECT idAdministrador FROM administradores WHERE idUsuario = @idUsuario);

			UPDATE verificacionesSolicitudes SET idAdministrador = @idAdministrador WHERE idSolicitud = @idSolicitud;
			UPDATE verificacionesSolicitudes SET fechaRevision = GETDATE() WHERE idSolicitud = @idSolicitud;
			UPDATE verificacionesSolicitudes SET observaciones = 'Solicitud Aceptada' WHERE idSolicitud = @idSolicitud;
			UPDATE verificacionesSolicitudes SET idEstado = 2 WHERE idSolicitud = @idSolicitud;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, se revierte la transacción
        ROLLBACK TRANSACTION;
        -- Opcional: Puedes lanzar el error o manejarlo de otra forma
        THROW;
    END CATCH
END;
---fIN DEL PROCEDIMIENTO ALMACENADO para aceptar Solicitudes
GO

--PROCEDIMIENTO ALMACENADO PARA CANCELAR SOLICITUDES
CREATE OR ALTER PROC P_CANCELAR_SOLICITUDES
    @idUsuario INTEGER,
    @idSolicitud INTEGER
AS
BEGIN
	BEGIN TRANSACTION;
		BEGIN TRY 
			DECLARE @idAdministrador INTEGER;
			SET @idAdministrador =(SELECT idAdministrador FROM administradores WHERE idUsuario = @idUsuario);

			UPDATE verificacionesSolicitudes SET idAdministrador = @idAdministrador WHERE idSolicitud = @idSolicitud;
			UPDATE verificacionesSolicitudes SET fechaRevision = GETDATE() WHERE idSolicitud = @idSolicitud;
			UPDATE verificacionesSolicitudes SET observaciones = 'Solicitud no aceptada por documentacion o informacion invalida' WHERE idSolicitud = @idSolicitud;
			UPDATE verificacionesSolicitudes SET idEstado = 3 WHERE idSolicitud = @idSolicitud;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, se revierte la transacción
        ROLLBACK TRANSACTION;
        -- Opcional: Puedes lanzar el error o manejarlo de otra forma
        THROW;
    END CATCH
END;
---fIN DEL PROCEDIMIENTO ALMACENADO para cancelar Solicitudes
GO

--Triger que para cuando se actualice el estado de la solciitud a aceptado almacene en vehiculos:
CREATE OR ALTER TRIGGER T_SOLICITUD_VEHICULO_G
ON verificacionesSolicitudes
AFTER UPDATE
AS
BEGIN
    BEGIN
        INSERT INTO vehiculos
        SELECT s.numPlaca, s.colorVehiculo, s.numPuertas,s.anio, s.numAsientos,s.idMarca, s.idModelo,  1
        FROM solicitudes s
        INNER JOIN verificacionesSolicitudes vs ON s.idSolicitud = vs.idSolicitud
        WHERE vs.idEstado = 2;
    END
END;
GO

EXEC P_CANCELAR_SOLICITUDES 
		@idUsuario = 1,
		@idSolicitud = 8;

GO

SELECT * FROM usuarios;

SELECT * FROM licencias;
SELECT * FROM fotografiasSolicitud;
SELECT * FROM tiposFotografias;
SELECT * FROM verificacionesSolicitudes;
SELECT * FROM solicitudes;
SELECT * FROM vehiculos;
SELECT * FROM conductores;
SELECT * FROM estados;
SELECT * FROM administradores;

INSERT INTO administradores VALUES(1);
INSERT INTO verificacionesSolicitudes VALUES (5,null,1,null,null);
UPDATE verificacionesSolicitudes SET idAdministrador = 1 WHERE idVerificacionSolicitud = 1;
UPDATE verificacionesSolicitudes SET fechaRevision = GETDATE() WHERE idVerificacionSolicitud = 1;
UPDATE verificacionesSolicitudes SET observaciones = 'Solicitud Aceptada' WHERE idVerificacionSolicitud = 1;
UPDATE verificacionesSolicitudes SET idEstado = 1 WHERE idVerificacionSolicitud = 1;


GO


		




SELECT * FROM verificacionesSolicitudes;
SELECT * FROM usuarios;

CREATE 




--Trabajar despues de llenar solicitudes y sean aceptadas.
--Procedimiento almacenado para llevar informacion especifica de conductores
CREATE OR ALTER PROC p_Conductores_map
AS	
	--IF EXISTS (SELECT * FROM usuariosRoles where usuariosRoles.idRol = 2)
	--SELECT u.idUsuario, u.latActual, u.lonActual,c.disponible FROM usuarios u
	--INNER JOIN conductores c ON c.idUsuario = u.idUsuario;
	SELECT * FROM usuarios;

EXEC p_Conductores_map;

	SELECT u.idUsuario, u.latActual, u.lonActual,c.disponible FROM usuarios u
	INNER JOIN conductores c ON c.idUsuario = u.idUsuario;
SELECT * FROM conductores;
