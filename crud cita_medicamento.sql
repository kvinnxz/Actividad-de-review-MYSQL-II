-- procedimientos CRUD para la tabla Cita_Medicamento
use mysqlii;
DELIMITER $$
-- insert
CREATE PROCEDURE insert_cita_med(
    IN p_cod VARCHAR(10),
    IN p_med VARCHAR(50),
    IN p_dosis VARCHAR(20))
BEGIN
    DECLARE existe INT;
    DECLARE existe_cita INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita_med', 'Cita_Medicamento', @cod,
               CONCAT('Error al insertar medicamento: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Cita_Medicamento WHERE Cod_Cita = p_cod AND Medicamento = p_med;
    SELECT COUNT(*) INTO existe_cita FROM Cita WHERE Cod_Cita = p_cod;

    IF existe_cita = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita_med', 'Cita', 404,
               CONCAT('La cita ', p_cod, ' no existe'));
    ELSEIF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita_med', 'Cita_Medicamento', 404,
               CONCAT('El medicamento ', p_med, ' ya existe en la cita ', p_cod));
    ELSE
        INSERT INTO Cita_Medicamento(Cod_Cita, Medicamento, Dosis)
        VALUES(p_cod, p_med, p_dosis);
    END IF;
END$$

-- update
CREATE PROCEDURE update_cita_med(
    IN p_cod VARCHAR(10),
    IN p_med VARCHAR(50),
    IN p_dosis VARCHAR(20))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_cita_med', 'Cita_Medicamento', @cod,
               CONCAT('Error al actualizar medicamento: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Cita_Medicamento WHERE Cod_Cita = p_cod AND Medicamento = p_med;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_cita_med', 'Cita_Medicamento', 404,
               CONCAT('El medicamento ', p_med, ' no existe en la cita ', p_cod));
    ELSE
        UPDATE Cita_Medicamento SET Dosis = p_dosis
        WHERE Cod_Cita = p_cod AND Medicamento = p_med;
    END IF;
END$$

-- delete
CREATE PROCEDURE delete_cita_med(
    IN p_cod VARCHAR(10),
    IN p_med VARCHAR(50))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_cita_med', 'Cita_Medicamento', @cod,
               CONCAT('Error al eliminar medicamento: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Cita_Medicamento WHERE Cod_Cita = p_cod AND Medicamento = p_med;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_cita_med', 'Cita_Medicamento', 404,
               CONCAT('El medicamento ', p_med, ' no existe en la cita ', p_cod));
    ELSE
        DELETE FROM Cita_Medicamento WHERE Cod_Cita = p_cod AND Medicamento = p_med;
    END IF;
END$$

-- select
CREATE PROCEDURE select_cita_med(IN p_cod VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_cita_med', 'Cita_Medicamento', @cod,
               CONCAT('Error al consultar medicamento: ', @msg));
    END;
    IF p_cod IS NULL THEN
        SELECT * FROM Cita_Medicamento;
    ELSE
        SELECT COUNT(*) INTO existe FROM Cita_Medicamento WHERE Cod_Cita = p_cod;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_cita_med', 'Cita_Medicamento', 404,
                   CONCAT('No hay medicamentos para la cita ', p_cod));
        ELSE
            SELECT * FROM Cita_Medicamento WHERE Cod_Cita = p_cod;
        END IF;
    END IF;
END$$
DELIMITER ;
CALL insert_cita_med('C-001', 'Aspirina', '100mg');
CALL insert_cita_med('C-001', 'Paracetamol', '500mg'); 
CALL insert_cita_med('C-999', 'Aspirina', '100mg');    
CALL update_cita_med('C-001', 'Aspirina', '200mg');
CALL select_cita_med('C-001');
CALL delete_cita_med('C-001', 'Aspirina');