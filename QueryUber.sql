USE master;

DROP DATABASE uber;

CREATE DATABASE uber;

USE uber;

CREATE TABLE personas(
	idPersona INTEGER PRIMARY KEY IDENTITY(1,1),
	dni VARCHAR(255),
	nombre1 VARCHAR(255),
	nombre2 VARCHAR(255),
	apellido1 VARCHAR(255),
	apellido2 VARCHAR(255)
);

CREATE TABLE usuarios(
	idUsuario INTEGER PRIMARY KEY IDENTITY(1,1),
	correo VARCHAR(50),
	contrasenia VARCHAR(60),
	idPersona INTEGER REFERENCES personas(idPersona)
);

CREATE TABLE telefonos(
	idTelefono INTEGER PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(60),
	idPersona INTEGER REFERENCES personas(idPersona)
);


-- Tabla Administradores
CREATE TABLE Administradores (
    id_Admin INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla CuentasConductores
CREATE TABLE CuentasConductores (
    idCuenta INT PRIMARY KEY AUTO_INCREMENT,
    cantidad DECIMAL(10, 2) NOT NULL
);

-- Tabla Conductores
CREATE TABLE Conductores (
    idConductor INT PRIMARY KEY AUTO_INCREMENT,
    estado VARCHAR(50) NOT NULL,
    idUsuario INT,
    numPlaca VARCHAR(20) UNIQUE,
    idCuenta INT,
    idSolicitud INT UNIQUE,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idCuenta) REFERENCES CuentasConductores(idCuenta)
);

-- Tabla InformacionSolicitud
CREATE TABLE InformacionSolicitud (
    idSolicitud INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    antecedentesPenales TEXT,
    antecedentesPoliciales TEXT,
    licencia VARCHAR(50),
    rfn VARCHAR(50),
    fechaSolicitud DATE,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla VerificacionSolicitud
CREATE TABLE VerificacionSolicitud (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idSolicitud INT,
    idAdministrador INT,
    estado VARCHAR(50) NOT NULL,
    fechaAprobacion DATE,
    FOREIGN KEY (idSolicitud) REFERENCES InformacionSolicitud(idSolicitud),
    FOREIGN KEY (idAdministrador) REFERENCES Administradores(id_Admin)
);

-- Tabla Marca
CREATE TABLE Marca (
    idMarca INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    disponible BOOLEAN NOT NULL
);

-- Tabla Modelo
CREATE TABLE Modelo (
    idModelo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idMarca INT,
    disponible BOOLEAN NOT NULL,
    FOREIGN KEY (idMarca) REFERENCES Marca(idMarca)
);

-- Tabla Vehiculos
CREATE TABLE Vehiculos (
    numPlaca VARCHAR(20) PRIMARY KEY,
    idModelo INT,
    idMarca INT,
    color VARCHAR(50),
    idConductor INT,
    FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo),
    FOREIGN KEY (idMarca) REFERENCES Marca(idMarca),
    FOREIGN KEY (idConductor) REFERENCES Conductores(idConductor)
);

-- Tabla Clientes
CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla HistorialClientes
CREATE TABLE HistorialClientes (
    idHistorialCliente INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
    idViaje INT,
    evaluacion INT,
    comentario TEXT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

-- Tabla HistorialConductores
CREATE TABLE HistorialConductores (
    idHistorialConductor INT PRIMARY KEY AUTO_INCREMENT,
    idConductor INT,
    idViaje INT,
    evaluacion INT,
    comentario TEXT,
    FOREIGN KEY (idConductor) REFERENCES Conductores(idConductor)
);

-- Tabla Viajes
CREATE TABLE Viajes (
    idViaje INT PRIMARY KEY AUTO_INCREMENT,
    estado VARCHAR(50) NOT NULL,
    nombreOrigen VARCHAR(100) NOT NULL,
    latitudOrigen DECIMAL(9,6) NOT NULL,
    longitudOrigen DECIMAL(9,6) NOT NULL,
    nombreDestino VARCHAR(100) NOT NULL,
    latitudDestino DECIMAL(9,6) NOT NULL,
    longitudDestino DECIMAL(9,6) NOT NULL,
    idCliente INT,
    idConductor INT,
    tarifa DECIMAL(10,2),
    distancia DECIMAL(10,2),
    fechaInicioViaje DATETIME,
    fechaFinViaje DATETIME,
    idChat INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idConductor) REFERENCES Conductores(idConductor)
);

-- Tabla Chat
CREATE TABLE Chat (
    idChat INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idViaje INT,
    FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje)
);

-- Tabla Mensajes
CREATE TABLE Mensajes (
    idMensaje INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    mensaje TEXT NOT NULL,
    fechaHora DATETIME NOT NULL,
    idChat INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idChat) REFERENCES Chat(idChat)
);

-- Tabla MetodosPago
CREATE TABLE MetodosPago (
    idMetodo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);
