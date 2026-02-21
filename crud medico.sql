--procedimientos CRUD para la tabla Medico
use mysqlii;
DELIMITER $$
-- insert
CREATE PROCEDURE insert_medico(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_esp VARCHAR(50),
    IN p_fac VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE existe_fac INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_medico', 'Medico', @cod,
               CONCAT('Error al insertar medico: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Medico WHERE Medico_ID = p_id;
    SELECT COUNT(*) INTO existe_fac FROM Facultad WHERE Facultad_ID = p_fac;
    
    IF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_medico', 'Medico', 404,
               CONCAT('El medico ', p_id, ' ya existe'));
    ELSEIF existe_fac = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_medico', 'Facultad', 404,
               CONCAT('La facultad ', p_fac, ' no existe'));
    ELSE
        INSERT INTO Medico(Medico_ID, Nombre_Medico, Especialidad, Facultad_ID)
        VALUES(p_id, p_nombre, p_esp, p_fac);
    END IF;
END$$

-- update
CREATE PROCEDURE update_medico(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_esp VARCHAR(50),
    IN p_fac VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_medico', 'Medico', @cod,
               CONCAT('Error al actualizar medico: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Medico WHERE Medico_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_medico', 'Medico', 404,
               CONCAT('El medico ', p_id, ' no existe'));
    ELSE
        UPDATE Medico SET Nombre_Medico = p_nombre, Especialidad = p_esp, Facultad_ID = p_fac
        WHERE Medico_ID = p_id;
    END IF;
END$$

-- delete
CREATE PROCEDURE delete_medico(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_medico', 'Medico', @cod,
               CONCAT('Error al eliminar medico: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Medico WHERE Medico_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_medico', 'Medico', 404,
               CONCAT('El medico ', p_id, ' no existe'));
    ELSE
        DELETE FROM Medico WHERE Medico_ID = p_id;
    END IF;
END$$

-- selct
CREATE PROCEDURE select_medico(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_medico', 'Medico', @cod,
               CONCAT('Error al consultar medico: ', @msg));
    END;
    IF p_id IS NULL THEN
        SELECT * FROM Medico;
    ELSE
        SELECT COUNT(*) INTO existe FROM Medico WHERE Medico_ID = p_id;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_medico', 'Medico', 404,
                   CONCAT('El medico ', p_id, ' no existe'));
        ELSE
            SELECT * FROM Medico WHERE Medico_ID = p_id;
        END IF;
    END IF;
END$$

DELIMITER ;