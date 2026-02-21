-- cantidad de pacientes atendidos por sede
use mysqlii;
DELIMITER $$
CREATE FUNCTION pacientes_sede(p_hospital_id VARCHAR(10))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('pacientes_sede', 'Cita', @cod,
               CONCAT('Error al buscar pacientes por sede: ', @msg));
        RETURN -1;
    END;
    SELECT COUNT(*) INTO existe FROM Hospital WHERE Hospital_ID = p_hospital_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('pacientes_sede', 'Hospital', 404,
               CONCAT('La sede ', p_hospital_id, ' no existe'));
        RETURN -1;
    END IF;
    SELECT COUNT(DISTINCT Paciente_ID) INTO total 
    FROM Cita 
    WHERE Hospital_ID = p_hospital_id;
    RETURN total;
END$$
DELIMITER ;
SELECT pacientes_sede('H-01');  
SELECT pacientes_sede('H-99');          