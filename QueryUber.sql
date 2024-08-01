USE master;

DROP DATABASE uber;

CREATE DATABASE uber;

USE uber;

CREATE TABLE personas(
	idPersona INTEGER PRIMARY KEY IDENTITY(1,1),
	dni VARCHAR(255) UNIQUE,
	nombre1 VARCHAR(255),
	nombre2 VARCHAR(255),
	apellido1 VARCHAR(255),
	apellido2 VARCHAR(255)
);

CREATE TABLE usuarios(
	idUsuario INTEGER PRIMARY KEY IDENTITY(1,1),
	correo VARCHAR(50) UNIQUE,
	contrasenia VARCHAR(60),
	idPersona INTEGER REFERENCES personas(idPersona)
);

CREATE TABLE telefonos(
	idTelefono INTEGER PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(60) UNIQUE,
	idPersona INTEGER REFERENCES personas(idPersona)
);


SELECT * FROM usuarios;
SELECT * FROM telefonos;
SELECT * FROM personas;
