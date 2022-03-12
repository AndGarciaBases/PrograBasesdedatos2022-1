DROP TABLE Usuario, Articulo
CREATE TABLE Usuario (
	Id int IDENTITY(1,1) PRIMARY KEY,
	Nombre varchar(16),
	Contrasena varchar(16),
)
CREATE TABLE Articulo (
	Id int IDENTITY(1,1) PRIMARY KEY,
	Nombre varchar(128),
	Precio money,
)