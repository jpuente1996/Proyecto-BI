CREATE DATABASE DATAWAREHOUSE;
GO

USE DATAWAREHOUSE;

CREATE TABLE DimCategoria(
	CategoriaID int NOT NULL,
	Categoria nvarchar(50) NULL,
	CONSTRAINT PK_Categoria PRIMARY KEY (CategoriaID)
)
go 

CREATE TABLE DimTipo(
	TipoID int NOT NULL,
	Tipo nvarchar(50) NULL,
	CONSTRAINT PK_Tipo PRIMARY KEY (TipoID)
)
go

CREATE TABLE DimDetalle(
	DetalleID int NOT NULL,
	Detalle nvarchar(50) NULL,
	CONSTRAINT PK_Detalle PRIMARY KEY (DetalleID)
)
go

CREATE TABLE FactAtenciones(
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
	FOREIGN KEY (categoriaID) REFERENCES DimCategoria(CategoriaID),
	FOREIGN KEY (tipoID) REFERENCES DimTipo(TipoID),
	FOREIGN KEY (detalleID) REFERENCES DimDetalle(DetalleID)
)
go