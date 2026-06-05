USE CineMaxCESDE;
GO

--Registrar Cliente
CREATE PROCEDURE usp_Registrar_Cliente
    @Nombre VARCHAR(100),
    @CorreoElectronico VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Clientes (Nombre, CorreoElectronico)
    VALUES (@Nombre, @CorreoElectronico);

    PRINT 'Cliente registrado correctamente.';
END;
GO

EXEC usp_Registrar_Cliente
    @Nombre = 'Andres Bernal',
    @CorreoElectronico = 'andres@gmail.com';

--Registrar Pelicula
CREATE PROCEDURE usp_Registrar_Pelicula
    @Titulo VARCHAR(100),
    @DuracionMinutos INT,
    @ClasificacionEdad VARCHAR(10),
    @PrecioBase DECIMAL(10,2),
    @Genero VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Peliculas
    (
        Titulo,
        DuracionMinutos,
        ClasificacionEdad,
        PrecioBase,
        Genero
    )
    VALUES
    (
        @Titulo,
        @DuracionMinutos,
        @ClasificacionEdad,
        @PrecioBase,
        @Genero
    );

    PRINT 'Película registrada correctamente.';
END;
GO

EXEC usp_Registrar_Pelicula
    @Titulo = 'Avatar',
    @DuracionMinutos = 180,
    @ClasificacionEdad = 'PG-13',
    @PrecioBase = 15000,
    @Genero = 'Ciencia Ficcion';

CREATE PROCEDURE usp_Mostrar_Tickets
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        T.TicketID,
        C.Nombre AS Cliente,
        T.FK_FuncionID AS Funcion,
        T.CantidadTickets,
        T.PrecioTotalPagado,
        T.FechaCompra
    FROM Tickets T
    INNER JOIN Clientes C
        ON T.FK_ClienteID = C.ClienteID;
END;
GO

EXEC usp_Mostrar_Tickets;