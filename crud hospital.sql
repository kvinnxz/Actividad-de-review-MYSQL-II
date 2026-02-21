-- procedimientos CRUD para la tabla Hospital
use mysqlii;
DELIMITER $$
-- insert
CREATE PROCEDURE insert_hospital(
    IN p_id VARCHAR(10), 
    IN p_sede VARCHAR(50), 
    IN p_dir VARCHAR(100))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_hospital', 'Hospital', @cod,
               CONCAT('Error al insertar hospital: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Hospital WHERE Hospital_ID = p_id;
    IF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_hospital', 'Hospital', 404,
               CONCAT('El hospital ', p_id, ' ya existe'));
    ELSE
        INSERT INTO Hospital(Hospital_ID, Hospital_Sede, Dir_Sede)
        VALUES(p_id, p_sede, p_dir);
    END IF;
END$$

-- update
CREATE PROCEDURE update_hospital(
    IN p_id VARCHAR(10), 
    IN p_sede VARCHAR(50), 
    IN p_dir VARCHAR(100))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_hospital', 'Hospital', @cod,
               CONCAT('Error al actualizar hospital: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Hospital WHERE Hospital_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_hospital', 'Hospital', 404,
               CONCAT('El hospital ', p_id, ' no existe'));
    ELSE
        UPDATE Hospital SET Hospital_Sede = p_sede, Dir_Sede = p_dir
        WHERE Hospital_ID = p_id;
    END IF;
END$$

-- delete
CREATE PROCEDURE delete_hospital(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_hospital', 'Hospital', @cod,
               CONCAT('Error al eliminar hospital: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Hospital WHERE Hospital_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_hospital', 'Hospital', 404,
               CONCAT('El hospital ', p_id, ' no existe'));
    ELSE
        DELETE FROM Hospital WHERE Hospital_ID = p_id;
    END IF;
END$$

-- select
CREATE PROCEDURE select_hospital(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_hospital', 'Hospital', @cod,
               CONCAT('Error al consultar hospital: ', @msg));
    END;
    IF p_id IS NULL THEN
        SELECT * FROM Hospital;
    ELSE
        SELECT COUNT(*) INTO existe FROM Hospital WHERE Hospital_ID = p_id;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_hospital', 'Hospital', 404,
                   CONCAT('El hospital ', p_id, ' no existe'));
        ELSE
            SELECT * FROM Hospital WHERE Hospital_ID = p_id;
        END IF;
    END IF;
END$$
DELIMITER ;

CALL insert_hospital('H-03', 'Clínica Sur', 'Av. Principal');
CALL update_hospital('H-03', 'Clínica Sur Actualizada', 'Av. Principal #5');
CALL select_hospital('H-03');
CALL delete_hospital('H-03');