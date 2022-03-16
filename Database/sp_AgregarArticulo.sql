CREATE OR ALTER PROCEDURE sp_AgregarArticulo 
						@nombre varchar(128),
						@Precio MONEY,
						@OutResultCode int OUTPUT
AS

SET NOCOUNT ON;

BEGIN TRY

IF EXISTS (SELECT id
 FROM dbo.Articulo
 Where( Articulo.Nombre=@nombre))
BEGIN
	SET @OutResultCode = 50001; -- Ya existe ese articulo
END
ELSE

INSERT INTO dbo.Articulo(
			Nombre,
			Precio
			) VALUES (@nombre,@Precio);
END TRY

BEGIN CATCH
	IF @@TRANCOUNT>0


		INSERT INTO dbo.BE_DBErrors VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
		);

		SET @OutResultCode=50005;

END CATCH

SET NOCOUNT OFF;

--TESTING
--DECLARE @a varchar(128) = 'Panadol';
--DECLARE @b Money = '950';
--DECLARE @c int;
--EXEC sp_AgregarArticulo @a, @b, @c
--SELECT * FROM dbo.Articulo
