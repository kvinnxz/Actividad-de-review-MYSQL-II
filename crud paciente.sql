-- procedimientos CRUD para la tabla Paciente
use mysqlii;
DELIMITER $$
-- insert
CREATE PROCEDURE insert_paciente(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_tel VARCHAR(20))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_paciente', 'Paciente', @cod,
               CONCAT('Error al insertar paciente: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
    IF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_paciente', 'Paciente', 404,
               CONCAT('El paciente ', p_id, ' ya existe'));
    ELSE
        INSERT INTO Paciente(Paciente_ID, Nombre_Paciente, Telefono)
        VALUES(p_id, p_nombre, p_tel);
    END IF;
END$$

-- update
CREATE PROCEDURE update_paciente(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_tel VARCHAR(20))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_paciente', 'Paciente', @cod,
               CONCAT('Error al actualizar paciente: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_paciente', 'Paciente', 404,
               CONCAT('El paciente ', p_id, ' no existe'));
    ELSE
        UPDATE Paciente SET Nombre_Paciente = p_nombre, Telefono = p_tel
        WHERE Paciente_ID = p_id;
    END IF;
END$$

-- delete
CREATE PROCEDURE delete_paciente(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_paciente', 'Paciente', @cod,
               CONCAT('Error al eliminar paciente: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_paciente', 'Paciente', 404,
               CONCAT('El paciente ', p_id, ' no existe'));
    ELSE
        DELETE FROM Paciente WHERE Paciente_ID = p_id;
    END IF;
END$$

-- selcet
CREATE PROCEDURE select_paciente(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_paciente', 'Paciente', @cod,
               CONCAT('Error al consultar paciente: ', @msg));
    END;
    IF p_id IS NULL THEN
        SELECT * FROM Paciente;
    ELSE
        SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_paciente', 'Paciente', 404,
                   CONCAT('El paciente ', p_id, ' no existe'));
        ELSE
            SELECT * FROM Paciente WHERE Paciente_ID = p_id;
        END IF;
    END IF;
END$$
DELIMITER ;

CALL insert_paciente('P-504', 'Carlos Lopez', '600-444');
CALL update_paciente('P-504', 'Carlos Lopez Jr', '600-555');
CALL select_paciente('P-504');
CALL delete_paciente('P-504');