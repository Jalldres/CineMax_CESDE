-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE CineMaxCESDE;
GO
--
USE CineMaxCESDE;
GO
-- 2. TABLA PELICULAS
CREATE TABLE Peliculas (
    -- PeliculaID es la Clave Primaria (PK)
    PeliculaID INT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(100) NOT NULL,
    DuracionMinutos INT,
    ClasificacionEdad VARCHAR(10) NOT NULL, -- Ej: 'G', 'PG', 'R'
    PrecioBase DECIMAL(10,2) NOT NULL,
    Genero VARCHAR(50),
    CONSTRAINT UQ_Pelicula_Titulo UNIQUE (Titulo)
);
GO
-- 3. TABLA SALAS
CREATE TABLE Salas (
    SalaID INT PRIMARY KEY IDENTITY(1,1),
    NombreSala VARCHAR(50) NOT NULL,
    Capacidad INT NOT NULL
);
GO
-- 4. TABLA CLIENTES
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    -- CorreoElectronico UNIQUE: No Email Repetido
    CorreoElectronico VARCHAR(100) UNIQUE NOT NULL
);
GO
-- 5. TABLA FUNCIONES (Relación entre Películas y Salas)
CREATE TABLE Funciones (
    FuncionID INT PRIMARY KEY IDENTITY(1,1),
    FK_PeliculaID INT NOT NULL,
    FK_SalaID INT NOT NULL,
    Horario DATETIME NOT NULL,
    -- FOREIGN KEY (FK)
    FOREIGN KEY (FK_PeliculaID) REFERENCES Peliculas(PeliculaID),
    FOREIGN KEY (FK_SalaID) REFERENCES Salas(SalaID)
);
GO
-- 6. TABLA TICKETS (Registro de ventas)
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    FK_ClienteID INT NOT NULL,
    FK_FuncionID INT NOT NULL,
    CantidadTickets INT NOT NULL,
    PrecioTotalPagado DECIMAL(10,2) NOT NULL,
    FechaCompra DATETIME DEFAULT GETDATE(), -- Fecha actual automáticamente
    FOREIGN KEY (FK_ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (FK_FuncionID) REFERENCES Funciones(FuncionID)
);
GO
-- 7. CONTROL DE ACCESO (DCL)
-- Cajero acceso limitado
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'CajeroLogin')
BEGIN
    CREATE LOGIN CajeroLogin WITH PASSWORD = 'Password123*';
END
GO
CREATE USER Cajero FOR LOGIN CajeroLogin;
GO
-- GRANT SELECT: no puede borrar ni cambiar datos.
GRANT SELECT ON Peliculas TO Cajero;
GO
PRINT 'Estructura DDL (Tablas y Restricciones) creada exitosamente.';