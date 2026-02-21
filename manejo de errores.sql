-- manejo de errores
use mysqlii;
CREATE TABLE Log_Errores (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    Procedimiento VARCHAR(100) NOT NULL,
    Nombre_Tabla VARCHAR(50) NOT NULL,
    Codigo_Error INT NOT NULL,
    Mensaje VARCHAR(255) NOT NULL,
    Fecha_Hora DATETIME DEFAULT NOW()
);

SELECT * FROM Log_Errores;