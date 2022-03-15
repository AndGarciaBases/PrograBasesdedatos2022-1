CREATE OR ALTER PROCEDURE sp_Login
			@Usuario varchar(16),
			@Contrasenna varchar(16),
			@output int out
AS

SET NOCOUNT ON;

BEGIN TRY

IF EXISTS (SELECT id
FROM dbo.Usuario
WHERE(	Usuario.Nombre=@Usuario
		AND
		Usuario.Contrasena=@Contrasenna))
BEGIN
	SET @output = 1
END
ELSE
BEGIN
	SET @output = 0
END
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

		SET @output=50005;

END CATCH
SET NOCOUNT OFF;

GO