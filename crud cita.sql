-- procedimientos CRUD para la tabla Cita
use mysqlii;
DELIMITER $$
-- insert
CREATE PROCEDURE insert_cita(
    IN p_cod VARCHAR(10),
    IN p_fecha DATE,
    IN p_diag VARCHAR(100),
    IN p_pac VARCHAR(10),
    IN p_med VARCHAR(10),
    IN p_hosp VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE existe_pac INT;
    DECLARE existe_med INT;
    DECLARE existe_hosp INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita', 'Cita', @cod,
               CONCAT('Error al insertar cita: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Cita WHERE Cod_Cita = p_cod;
    SELECT COUNT(*) INTO existe_pac FROM Paciente WHERE Paciente_ID = p_pac;
    SELECT COUNT(*) INTO existe_med FROM Medico WHERE Medico_ID = p_med;
    SELECT COUNT(*) INTO existe_hosp FROM Hospital WHERE Hospital_ID = p_hosp;

    IF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita', 'Cita', 404,
               CONCAT('La cita ', p_cod, ' ya existe'));
    ELSEIF existe_pac = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita', 'Paciente', 404,
               CONCAT('El paciente ', p_pac, ' no existe'));
    ELSEIF existe_med = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita', 'Medico', 404,
               CONCAT('El medico ', p_med, ' no existe'));
    ELSEIF existe_hosp = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_cita', 'Hospital', 404,
               CONCAT('El hospital ', p_hosp, ' no existe'));
    ELSE
        INSERT INTO Cita(Cod_Cita, Fecha_Cita, Diagnostico, Paciente_ID, Medico_ID, Hospital_ID)
        VALUES(p_cod, p_fecha, p_diag, p_pac, p_med, p_hosp);
    END IF;
END$$

-- udate
CREATE PROCEDURE update_cita(
    IN p_cod VARCHAR(10),
    IN p_fecha DATE,
    IN p_diag VARCHAR(100),
    IN p_pac VARCHAR(10),
    IN p_med VARCHAR(10),
    IN p_hosp VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_cita', 'Cita', @cod,
               CONCAT('Error al actualizar cita: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Cita WHERE Cod_Cita = p_cod;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_cita', 'Cita', 404,
               CONCAT('La cita ', p_cod, ' no existe'));
    ELSE
        UPDATE Cita SET Fecha_Cita = p_fecha, Diagnostico = p_diag,
            Paciente_ID = p_pac, Medico_ID = p_med, Hospital_ID = p_hosp
        WHERE Cod_Cita = p_cod;
    END IF;
END$$

-- delete
CREATE PROCEDURE delete_cita(IN p_cod VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_cita', 'Cita', @cod,
               CONCAT('Error al eliminar cita: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Cita WHERE Cod_Cita = p_cod;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_cita', 'Cita', 404,
               CONCAT('La cita ', p_cod, ' no existe'));
    ELSE
        DELETE FROM Cita WHERE Cod_Cita = p_cod;
    END IF;
END$$

-- selectt
CREATE PROCEDURE select_cita(IN p_cod VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_cita', 'Cita', @cod,
               CONCAT('Error al consultar cita: ', @msg));
    END;
    IF p_cod IS NULL THEN
        SELECT * FROM Cita;
    ELSE
        SELECT COUNT(*) INTO existe FROM Cita WHERE Cod_Cita = p_cod;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_cita', 'Cita', 404,
                   CONCAT('La cita ', p_cod, ' no existe'));
        ELSE
            SELECT * FROM Cita WHERE Cod_Cita = p_cod;
        END IF;
    END IF;
END$$
DELIMITER ;
CALL insert_cita('C-005', '2024-06-01', 'Fiebre', 'P-501', 'M-10', 'H-01');
CALL insert_cita('C-005', '2024-06-01', 'Fiebre', 'P-501', 'M-10', 'H-01'); 
CALL insert_cita('C-006', '2024-06-01', 'Fiebre', 'P-999', 'M-10', 'H-01'); 
CALL update_cita('C-005', '2024-06-02', 'Fiebre Alta', 'P-501', 'M-10', 'H-01');
CALL select_cita('C-005');
CALL delete_cita('C-005');