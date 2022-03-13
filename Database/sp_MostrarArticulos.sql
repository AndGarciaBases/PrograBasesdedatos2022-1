CREATE OR ALTER PROCEDURE sp_MostrarArticulos
				@OutResultCode int OUTPUT

AS

SET NOCOUNT ON;

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM dbo.Articulo)
		BEGIN
			SET @OutResultCode=50001; --No hay Articulos
			RETURN
		END;
		BEGIN TRANSACTION Articulos
			SELECT	Id,
					Nombre,
					Precio
			FROM dbo.Articulo
		COMMIT TRANSACTION Articulos
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
--DECLARE @OutResultCode int;
--EXEC MostrarArticulos @OutResultCode