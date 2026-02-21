# Actividad Review MySQL II

## Descripción
Normalización de base de datos de clínica universitaria hasta 4FN,
implementación de procedimientos almacenados CRUD y funciones de consulta.

## Contenido

### Tablas Normalizadas (4FN)
- Facultad
- Paciente
- Medico
- Hospital
- Cita
- Cita_Medicamento
- Log_Errores

### Funciones
- `fn_doctores` - Número de doctores por especialidad
- `pacientes_medico` - Total de pacientes atendidos por un médico
- `pacientes_sede` - Cantidad de pacientes atendidos por sede

### CRUD
- Facultad
- Paciente
- Hospital
- Medico
- Cita
- Cita_Medicamento

## Manejo de Errores
Todos los procedimientos y funciones registran errores en la tabla
`Log_Errores` con:
- Procedimiento o función
- Nombre de la tabla
- Código de error
- Mensaje personalizado
- Fecha y hora

## Herramientas
- MySQL
- MySQL Workbench

# Hecho por:
 [Kevin Pico:](https://github.com/kvinnxz)