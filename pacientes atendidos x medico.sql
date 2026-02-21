-- pacientes atendidos por medico
use mysqlii;
DELIMITER $$
CREATE FUNCTION pacientes_medico(p_medico_id VARCHAR(10))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('pacientes_medico', 'Cita', @cod,
               CONCAT('Error al buscar pacientes por medico: ', @msg));
        RETURN -1;
    END;
    SELECT COUNT(*) INTO existe FROM Medico WHERE Medico_ID = p_medico_id;   
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('pacientes_medico', 'Medico', 404, 
               CONCAT('El medico ', p_medico_id, ' no existe'));
        RETURN -1;
    END IF;   
    SELECT COUNT(DISTINCT Paciente_ID) INTO total 
    FROM Cita 
    WHERE Medico_ID = p_medico_id;
    RETURN total;
END$$
DELIMITER ;
SELECT pacientes_medico('M-10');
SELECT pacientes_medico('M-22');
SELECT pacientes_medico('M-30');