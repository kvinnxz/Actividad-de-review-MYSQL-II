-- Tablas normalizadas
use mysqlii;
CREATE TABLE Facultad (
    Facultad_ID VARCHAR(10) PRIMARY KEY,
    Nombre_Facultad VARCHAR(50)	 not null,
    Decano VARCHAR(50) not null
);

CREATE TABLE Paciente (
    Paciente_ID VARCHAR(10) PRIMARY KEY,
    Nombre_Paciente VARCHAR(50) not null,
    Telefono VARCHAR(20) not null
);

CREATE TABLE Medico (
    Medico_ID VARCHAR(10) PRIMARY KEY,
    Nombre_Medico VARCHAR(50) not null,
    Especialidad VARCHAR(50) not null,
    Facultad_ID VARCHAR(10)not null,
    FOREIGN KEY (Facultad_ID) REFERENCES Facultad(Facultad_ID)
);

CREATE TABLE Hospital (
    Hospital_ID VARCHAR(10) PRIMARY KEY,
    Hospital_Sede VARCHAR(50) not null,
    Dir_Sede VARCHAR(100) not null
);

CREATE TABLE Cita (
    Cod_Cita VARCHAR(10) PRIMARY KEY,
    Fecha_Cita DATE not null,
    Diagnostico VARCHAR(100) not null,
    Paciente_ID VARCHAR(10) not null,
    Medico_ID VARCHAR(10) not null,
    Hospital_ID VARCHAR(10) not null,
    FOREIGN KEY (Paciente_ID) REFERENCES Paciente(Paciente_ID),
    FOREIGN KEY (Medico_ID)   REFERENCES Medico(Medico_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID)
);

CREATE TABLE Cita_Medicamento (
    Cod_Cita VARCHAR(10) not null,
    Medicamento VARCHAR(50)not null,
    Dosis VARCHAR(20)not null,
    PRIMARY KEY (Cod_Cita, Medicamento),
    FOREIGN KEY (Cod_Cita) REFERENCES Cita(Cod_Cita)
);

INSERT INTO Facultad VALUES 
('F-01', 'Medicina', 'Dr. Wilson'),
('F-02', 'Ciencias', 'Dr. Palmer');

INSERT INTO Paciente VALUES 
('P-501', 'Juan Rivas', '600-111'),
('P-502', 'Ana Soto', '600-222'),
('P-503', 'Luis Paz', '600-333');

INSERT INTO Medico VALUES 
('M-10', 'Dr. House', 'Infectología', 'F-01'),
('M-22', 'Dra. Grey', 'Cardiología', 'F-01'), 
('M-30', 'Dr. Strange', 'Neurocirugía', 'F-02');

INSERT INTO Hospital VALUES 
('H-01', 'Centro Médico', 'Calle 5 #10'),
('H-02', 'Clínica Norte', 'Av. Libertador');

INSERT INTO Cita VALUES 
('C-001', '2024-05-10', 'Gripe Fuerte', 'P-501', 'M-10', 'H-01'),
('C-002', '2024-05-11', 'Infección', 'P-502', 'M-10', 'H-01'),
('C-003', '2024-05-12', 'Arritmia', 'P-501', 'M-22', 'H-02'),
('C-004', '2024-05-15', 'Migraña', 'P-503', 'M-30', 'H-02');

INSERT INTO Cita_Medicamento VALUES
('C-001', 'Paracetamol', '500mg'),
('C-001', 'Ibuprofeno', '400mg'), 
('C-002', 'Amoxicilina', '875mg'),
('C-003', 'Aspirina', '100mg'),
('C-004', 'Ergotamina', '1mg');