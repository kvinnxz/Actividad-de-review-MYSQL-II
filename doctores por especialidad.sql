-- numero de doctores por especialidad
use mysqlii;
DELIMITER $$
CREATE FUNCTION fn_doctores(p_especialidad VARCHAR(50))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('fn_doctores', 'Medico', @cod, 
               CONCAT('Error al buscar doctores por especialidad: ', @msg));
        RETURN -1;
    END;
    SELECT COUNT(*) INTO total 
    FROM Medico 
    WHERE Especialidad = p_especialidad;
    RETURN total;
END$$
DELIMITER ;

SELECT fn_doctores('Infectología') AS Total_Infectologos;
SELECT fn_doctores('Cardiología') AS Total_Cardiologos;
SELECT fn_doctores('Neurocirugía') AS Total_Neurocirujanos;
