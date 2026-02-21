-- Procedimientos almacenados para la tabla Facultad
use mysqlii;
DELIMITER $$

-- insert
CREATE PROCEDURE insert_facultad(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_decano VARCHAR(50))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_facultad', 'Facultad', @cod,
               CONCAT('Error al insertar facultad: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Facultad WHERE Facultad_ID = p_id;
    IF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_facultad', 'Facultad', 404,
               CONCAT('La facultad ', p_id, ' ya existe'));
    ELSE
        INSERT INTO Facultad(Facultad_ID, Nombre_Facultad, Decano)
        VALUES(p_id, p_nombre, p_decano);
    END IF;
END$$

-- update
CREATE PROCEDURE update_facultad(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_decano VARCHAR(50))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_facultad', 'Facultad', @cod,
               CONCAT('Error al actualizar facultad: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Facultad WHERE Facultad_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_facultad', 'Facultad', 404,
               CONCAT('La facultad ', p_id, ' no existe'));
    ELSE
        UPDATE Facultad SET Nombre_Facultad = p_nombre, Decano = p_decano
        WHERE Facultad_ID = p_id;
    END IF;
END$$

-- delete
CREATE PROCEDURE delete_facultad(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_facultad', 'Facultad', @cod,
               CONCAT('Error al eliminar facultad: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Facultad WHERE Facultad_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_facultad', 'Facultad', 404,
               CONCAT('La facultad ', p_id, ' no existe'));
    ELSE
        DELETE FROM Facultad WHERE Facultad_ID = p_id;
    END IF;
END$$

-- select
CREATE PROCEDURE select_facultad(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_facultad', 'Facultad', @cod,
               CONCAT('Error al consultar facultad: ', @msg));
    END;
    IF p_id IS NULL THEN
        SELECT * FROM Facultad;
    ELSE
        SELECT COUNT(*) INTO existe FROM Facultad WHERE Facultad_ID = p_id;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_facultad', 'Facultad', 404,
                   CONCAT('La facultad ', p_id, ' no existe'));
        ELSE
            SELECT * FROM Facultad WHERE Facultad_ID = p_id;
        END IF;
    END IF;
END$$
DELIMITER ;
CALL insert_facultad('F-03', 'Ingeniería', 'Dr. Stark');
CALL update_facultad('F-03', 'Ingeniería de Sistemas', 'Dr. Stark');
CALL select_facultad('F-03');
CALL delete_facultad('F-03');
CALL insert_facultad('F-01', 'Medicina', 'Dr. Wilson');                  