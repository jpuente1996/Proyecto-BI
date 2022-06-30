CREATE DATABASE STAGING
GO

USE STAGING;

CREATE TABLE BaseAtenciones(
	num_ticket nvarchar(20) NULL,
	fecha_programada nvarchar(10) NULL,
	fecha_creacion nvarchar(10) NULL,
	fecha_cierre nvarchar(10) NULL,
	estado nvarchar(50) NULL,
	agencia nvarchar(100) NULL,
	service_desk nvarchar(100) NULL,
	tipo_ticket nvarchar(50) NULL,
	proveedor nvarchar(200) NULL,
	costo nvarchar(50) NULL,
	numero_OS nvarchar(50) NULL
)
go

CREATE TABLE BaseTickets(
	num_ticket nvarchar(20) NULL,
	categoria nvarchar(50) NULL,
	tipo nvarchar(50) NULL,
	detalle nvarchar(50) NULL,
	matri nvarchar(50) NULL,
	ubicacion nvarchar(100) NULL,
	region nvarchar(50) NULL,
	modo_reporte nvarchar(50) NULL,
	estado nvarchar(50) NULL,
	prioridad tinyint NULL,
	fecha_creacion nvarchar(10) NULL,
	fecha_termino nvarchar(10) NULL,
	fecha_cierre nvarchar(10) NULL
)
go


CREATE TABLE Categoria(
	CategoriaID int NOT NULL,
	Categoria nvarchar(50) NULL,
	
)
go

CREATE TABLE Tipo(
	TipoID int NOT NULL,
	Tipo nvarchar(50) NULL,
	CONSTRAINT PK_Tipo PRIMARY KEY (TipoID)
)
go

CREATE TABLE Detalle(
	DetalleID int NOT NULL,
	Detalle nvarchar(50) NULL,
	
)
go
CREATE TABLE Atenciones(
	num_ticket nvarchar(20) NOT NULL,
	agenciaID nvarchar(100) NULL,
	categoriaID int NOT NULL,
	tipoID int NOT NULL,
	detalleID int NOT NULL,
	fecha_creacion date NULL,
	fecha_programada date NULL,
	fecha_real_fin date NULL,
	estado nvarchar(50) NULL,
	service_desk nvarchar(100) NULL,
	tipo_ticket nvarchar(50) NULL,
	proveedor nvarchar(200) NULL,
	costo smallmoney NULL,
)
go

