use "tarea 1";
 GO
 DECLARE @XML AS XML,
		 @hDoc AS INT, 
		 @SQL NVARCHAR (MAX)

 SET @XML = (SELECT CONVERT(XML, BulkColumn) 
			 AS BulkColumn 
			 FROM OPENROWSET(BULK 'C:\Users\andho\Documents\Bases\PrograBasesdedatos2022-1\DatosTarea1.xml', SINGLE_BLOB) AS x)
 EXEC sp_xml_preparedocument @hDoc
 OUTPUT, @XML
 DECLARE @xmlTable 
 Table (id INT IDENTITY(1,1) PRIMARY KEY,	
		Nombre varchar(16),	
		Contrasena varchar(16))
 INSERT 
 INTO @xmlTable 
	SELECT	Nombre,
			Contrasena
 FROM 
	OPENXML(@hDoc, 'Datos/Usuarios/Usuario') 
WITH  
(	
	Nombre varchar(16) '@Nombre',
	Contrasena varchar(16) '@Password'
 );  
INSERT 
	INTO dbo.Usuario
	SELECT Nombre,
		   Contrasena
	FROM @xmlTable;  
EXEC sp_xml_removedocument @hDoc 
GO

GO
DECLARE @XML AS XML,
		@hDoc AS INT, 
		@SQL NVARCHAR (MAX)

SET @XML = (SELECT CONVERT(XML, BulkColumn) 
			AS BulkColumn 
			FROM OPENROWSET(BULK 'C:\Users\andho\Documents\Bases\PrograBasesdedatos2022-1\DatosTarea1.xml', SINGLE_BLOB) AS x)
EXEC sp_xml_preparedocument @hDoc
OUTPUT, @XML
DECLARE @xmlTable 
Table (id INT IDENTITY(1,1) PRIMARY KEY,	
	Nombre varchar(128),	
	Precio Money)
INSERT 
INTO @xmlTable 
SELECT	Nombre,
		Precio
FROM 
OPENXML(@hDoc, 'Datos/Articulos/Articulo') 
WITH  
(	
Nombre varchar(128) '@Nombre',
Precio Money '@Precio'
);  
INSERT 
INTO dbo.Articulo
SELECT Nombre,
		Precio
FROM @xmlTable;  
EXEC sp_xml_removedocument @hDoc 
GO