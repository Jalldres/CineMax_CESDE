USE CineMaxCESDE;
GO
-- 1. Insertando Peliculas
INSERT INTO Peliculas (Titulo, DuracionMinutos, ClasificacionEdad, PrecioBase, Genero)
VALUES 
('Avengers: Endgame', 181, 'PG-13', 15000, 'Acción'),
('Toy Story 4', 100, 'G', 12000, 'Animación'),
('Joker', 122, 'R', 14000, 'Drama'),
('Frozen 2', 103, 'G', 12000, 'Animación');

-- 2. Insertando Salas
INSERT INTO Salas (NombreSala, Capacidad)
VALUES 
('Sala IMAX', 200),
('Sala 2D - A', 150),
('Sala VIP', 50);

-- 3. Insertando Clientes
INSERT INTO Clientes (Nombre, CorreoElectronico)
VALUES 
('Juan Perez', 'juan.perez@email.com'),
('Maria Lopez', 'maria.lopez@email.com'),
('Andres Castro', 'andres.c@email.com');

-- 4. Insertando Funcionmes
INSERT INTO Funciones (FK_PeliculaID, FK_SalaID, Horario)
VALUES 
(1, 1, '2025-10-20 18:00:00'),
(2, 2, '2025-10-20 15:00:00'),
(3, 3, '2025-10-20 21:00:00');

--5. (UPDATE Y DELETE)
UPDATE Salas
SET Capacidad = Capacidad - 1
WHERE SalaID = 1;
DELETE FROM Clientes
WHERE ClienteID NOT IN (SELECT FK_ClienteID FROM Tickets);
GO

-- 6. Consulta Reportes
SELECT Genero, COUNT(*) AS TotalPeliculas
FROM Peliculas
GROUP BY Genero;

-- ¿Cuál es la capacidad total sumando todas las salas? (SUM)
SELECT SUM(Capacidad) AS CapacidadTotalCine
FROM Salas;

-- Reporte Detallado (Uso de INNER JOIN)
SELECT 
    P.Titulo AS [Título de la Película],
    F.Horario,
    S.NombreSala AS [Nombre de la Sala],
    S.Capacidad AS [Capacidad de la Sala]
FROM Funciones F
INNER JOIN Peliculas P ON F.FK_PeliculaID = P.PeliculaID
INNER JOIN Salas S ON F.FK_SalaID = S.SalaID;
GO

PRINT 'Datos de prueba DML procesados correctamente.';
