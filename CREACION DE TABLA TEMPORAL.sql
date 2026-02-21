-- CREACION DE TABLA TEMPORAL

CREATE DATABASE mysqlii;
USE mysqlii;

CREATE TABLE registro_clinica (
    Paciente_ID INT,
    Nombre_Paciente VARCHAR(100),
    Telefono_Paciente VARCHAR(20),
    Medico_ID INT,
    Nombre_Medico VARCHAR(100),
    Especialidad VARCHAR(100),
    Facultad_Origen VARCHAR(100),
    Decano_Facultad VARCHAR(100),
    Cod_Cita VARCHAR(20),
    Fecha_Cita DATE,
    Diagnostico TEXT,
    Medicamentos_Recetados VARCHAR(150),
    Dosis_Medicamento VARCHAR(50),
    Hospital_Sede VARCHAR(100),
    Dir_Sede VARCHAR(150)
);

ALTER TABLE registro_clinica 
MODIFY COLUMN Paciente_ID VARCHAR(10);

ALTER TABLE registro_clinica 
MODIFY COLUMN Medico_ID VARCHAR(10);

INSERT INTO registro_clinica 
	(Paciente_ID, Nombre_Paciente, Telefono_Paciente, Medico_ID, Nombre_Medico, Especialidad, Facultad_Origen, Decano_Facultad, 
    Cod_Cita, Fecha_Cita, Diagnostico, Medicamentos_Recetados, Dosis_Medicamento, Hospital_Sede, Dir_Sede)
VALUES 
('P-501', 'Juan Rivas', '600-111', 'M-10', 'Dr. House', 'Infectología', 'Medicina', 'Dr. Wilson', 'C-001', '2024-05-10', 
'Gripe Fuerte','Paracetamol, Ibuprofeno', '500mg, 400mg', 'Centro Médico', 'Calle 5 #10'),
('P-502', 'Ana Soto', '600-222', 'M-10', 'Dr. House', 'Infectología', 'Medicina', 'Dr. Wilson', 'C-002', '2024-05-11',
'Infección', 'Amoxicilina', '875mg', 'Centro Médico', 'Calle 5 #10'),
('P-501', 'Juan Rivas', '600-111', 'M-22', 'Dra. Grey', 'Cardiología', 'Medicina', 'Dr. Wilson', 'C-003', '2024-05-12',
'Arritmia', 'Aspirina', '100mg', 'Clínica Norte', 'Av. Libertador'),
('P-503', 'Luis Paz', '600-333', 'M-30', 'Dr. Strange', 'Neurocirugía', 'Ciencias', 'Dr. Palmer', 'C-004', '2024-05-15',
'Migraña', 'Ergotamina', '1mg', 'Clínica Norte', 'Av. Libertador');

SELECT * FROM registro_clinica;
SELECT COUNT(*) FROM registro_clinica;
