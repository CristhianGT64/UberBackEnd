CREATE DATABASE uber;

USE uber;

CREATE TABLE personas(
	idPersona INTEGER PRIMARY KEY,
	dni VARCHAR(255),
	nombre1 VARCHAR(255),
	nombre2 VARCHAR(255),
	apellido1 VARCHAR(255),
	apellido2 VARCHAR(255)
);

CREATE TABLE usuarios(
	idUsuario INTEGER PRIMARY KEY,
	correo VARCHAR(50),
	contrasenia VARCHAR(60),
	idPersona INTEGER REFERENCES personas(idPersona)
);

CREATE TABLE telefonos(
	idTelefono INTEGER PRIMARY KEY,
	numero VARCHAR(60),
	idPersona INTEGER REFERENCES personas(idPersona)
);