USE app_medica;

-- JOIN

-- JOIN para mostrar información completa de citas
SELECT 
    c.id_cita,
    p.nombre AS paciente_nombre,
    p.ap_paterno AS paciente_apellido,
    m.nombre AS medico_nombre,
    m.ap_paterno AS medico_apellido,
    e.nombre AS especialidad,
    c.fecha,
    c.hora,
    c.estado
FROM citas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico
JOIN especialidades e ON m.id_especialidad = e.id_especialidad;

-- LEFT JOIN para incluir todos los médicos aunque no tengan citas
SELECT Propósito: Analizar patrones de citas por día de semana y horarios
Resultado: Citas con día de semana, mes y clasificación por turno (Mañana/Tarde/Noche)
    m.id_medico,
    m.nombre,
    m.ap_paterno,
    m.ap_materno,
    e.nombre AS especialidad,
    COUNT(c.id_cita) AS total_citas
FROM medicos m
LEFT JOIN especialidades e ON m.id_especialidad = e.id_especialidad
LEFT JOIN citas c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre, m.ap_paterno, m.ap_materno, e.nombre;

-- UNION

-- UNION para combinar nombres de pacientes y médicos
SELECT 
    nombre,
    ap_paterno,
    ap_materno,
    'Paciente' AS tipo_persona
FROM pacientes
UNION
SELECT 
    nombre,
    ap_paterno,
    ap_materno,
    'Médico' AS tipo_persona
FROM medicos
ORDER BY tipo_persona, ap_paterno, nombre;

-- UNION para combinar información de contacto
SELECT 
    nombre,
    ap_paterno,
    email,
    telefono,
    'Paciente' AS tipo
FROM pacientes
UNION
SELECT 
    nombre,
    ap_paterno,
    email,
    telefono,
    'Médico' AS tipo
FROM medicos
ORDER BY tipo, ap_paterno;

-- ORDER BY

-- ORDER BY para pacientes por fecha de nacimiento (más jóvenes primero)
SELECT 
    id_paciente,
    nombre,
    ap_paterno,
    ap_materno,
    fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad,
    genero
FROM pacientes
ORDER BY fecha_nacimiento DESC;

-- ORDER BY múltiple para citas

SELECT 
    id_cita,
    (SELECT nombre FROM pacientes WHERE id_paciente = c.id_paciente) AS paciente,
    (SELECT nombre FROM medicos WHERE id_medico = c.id_medico) AS medico,
    fecha,
    hora,
    estado
FROM citas c
ORDER BY 
    CASE estado 
        WHEN 'Confirmada' THEN 1
        WHEN 'Pendiente' THEN 2
        WHEN 'Cancelada' THEN 3
        ELSE 4
    END,
    fecha ASC,
    hora ASC;

-- GROUP BY

-- GROUP BY para contar citas por médico
SELECT 
    m.id_medico,
    m.nombre,
    m.ap_paterno,
    e.nombre AS especialidad,
    COUNT(c.id_cita) AS total_citas,
    SUM(CASE WHEN c.estado = 'Confirmada' THEN 1 ELSE 0 END) AS citas_confirmadas,
    SUM(CASE WHEN c.estado = 'Pendiente' THEN 1 ELSE 0 END) AS citas_pendientes
FROM medicos m
JOIN especialidades e ON m.id_especialidad = e.id_especialidad
LEFT JOIN citas c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre, m.ap_paterno, e.nombre
ORDER BY total_citas DESC;

-- GROUP BY para análisis demográfico de pacientes
SELECT 
    genero,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) < 18 THEN 'Menor de edad'
        WHEN TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) BETWEEN 18 AND 30 THEN '18-30 años'
        WHEN TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) BETWEEN 31 AND 50 THEN '31-50 años'
        ELSE 'Mayor de 50 años'
    END AS grupo_edad,
    COUNT(*) AS cantidad_pacientes,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE())), 1) AS edad_promedio
FROM pacientes
GROUP BY genero, grupo_edad
ORDER BY genero, 
    CASE grupo_edad
        WHEN 'Menor de edad' THEN 1
        WHEN '18-30 años' THEN 2
        WHEN '31-50 años' THEN 3
        ELSE 4
    END;

-- MANIPULACION DE TIEMPO Y FECHAS

-- Manipulación de fechas para análisis de citas
SELECT 
    id_cita,
    fecha,
    hora,
    DAYNAME(fecha) AS dia_semana,
    MONTHNAME(fecha) AS mes,
    DAY(fecha) AS dia_mes,
    YEAR(fecha) AS año,
    CONCAT(
        CASE 
            WHEN HOUR(hora) < 12 THEN 'Mañana'
            WHEN HOUR(hora) BETWEEN 12 AND 17 THEN 'Tarde'
            ELSE 'Noche'
        END,
        ' (',
        DATE_FORMAT(hora, '%h:%i %p'),
        ')'
    ) AS turno,
    estado
FROM citas
-- WHERE fecha >= CURDATE()  -- Comentar esta línea
ORDER BY fecha, hora;

-- Cálculos con fechas para pacientes
SELECT 
    id_paciente,
    nombre,
    ap_paterno,
    fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad_actual,
    DATE_ADD(fecha_nacimiento, INTERVAL 65 YEAR) AS fecha_jubilacion_65,
    TIMESTAMPDIFF(YEAR, CURDATE(), DATE_ADD(fecha_nacimiento, INTERVAL 65 YEAR)) AS años_para_jubilacion,
    DAYOFYEAR(fecha_nacimiento) AS dia_del_año_nacimiento,
    CONCAT(
        'Nació un ',
        DAYNAME(fecha_nacimiento),
        ' en ',
        MONTHNAME(fecha_nacimiento)
    ) AS descripcion_nacimiento
FROM pacientes
ORDER BY fecha_nacimiento;

-- Procedimientos almacenados

-- Procedimiento Almacenado - Reporte de Clientes Vigentes
DELIMITER //

CREATE PROCEDURE CalcularIngresosDiarios(IN fecha_consulta DATE)
BEGIN
    SELECT 
        c.fecha,
        COUNT(*) as total_consultas,
        SUM(500) as ingresos_totales  -- Precio fijo de $500 por consulta
    FROM citas c
    LEFT JOIN medicos m ON c.id_medico = m.id_medico
    WHERE c.fecha = fecha_consulta 
    AND c.estado = 'Confirmada'
    GROUP BY c.fecha;
END //
DELIMITER ;
-- Ejecutar el procedimiento almacenado
CALL CalcularIngresosDiarios('2025-08-30');


-- Manejo de Excepción - Restricción Única de Email
DELIMITER //

CREATE PROCEDURE ReportePacientesTrimestre(IN anio INT)
BEGIN
    SELECT 
        p.id_paciente,
        CONCAT(p.nombre, ' ', p.ap_paterno, ' ', p.ap_materno) as nombre_completo,
        p.email,
        p.telefono,
        COUNT(c.id_cita) as total_citas
    FROM pacientes p
    INNER JOIN citas c ON p.id_paciente = c.id_paciente
    WHERE c.fecha BETWEEN CONCAT(anio, '-07-01') AND CONCAT(anio, '-09-30')
    AND c.estado != 'Cancelada'
    GROUP BY p.id_paciente, nombre_completo, p.email, p.telefono
    ORDER BY total_citas DESC;
END //

DELIMITER ;
-- Ejecutar el procedimiento almacenado
CALL ReportePacientesTrimestre(2025);


-- Manejo de Excepción - Restricción Única de Email

ALTER TABLE pacientes ADD CONSTRAINT uk_pacientes_email UNIQUE (email);

DELIMITER //

CREATE PROCEDURE AgregarPacienteConValidacion(
    IN p_nombre VARCHAR(100),
    IN p_ap_paterno VARCHAR(100),
    IN p_ap_materno VARCHAR(100),
    IN p_fecha_nacimiento DATE,
    IN p_genero CHAR(1),
    IN p_telefono VARCHAR(15),
    IN p_email VARCHAR(150)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SELECT 'Error: El email ya está registrado, intente con otro email' as mensaje_error;
    END;
    
    INSERT INTO pacientes (nombre, ap_paterno, ap_materno, fecha_nacimiento, genero, telefono, email)
    VALUES (p_nombre, p_ap_paterno, p_ap_materno, p_fecha_nacimiento, p_genero, p_telefono, p_email);
    
    SELECT 'Paciente agregado exitosamente' as mensaje_exito;
END //

DELIMITER ;

-- Intento exitoso
CALL AgregarPacienteConValidacion('Roberto', 'Silva', 'Mendez', '1992-08-15', 'M', '555123999', 'roberto.silva@email.com');

-- Intento que generará error (email duplicado)
CALL AgregarPacienteConValidacion('Ana', 'Maria', 'Lopez', '1990-01-01', 'F', '555000000', 'juanperez@email.com');


-- Triggers
-- Control de Citas Duplicadas
DELIMITER //

CREATE TRIGGER PrevenirCitasDuplicadas
BEFORE INSERT ON citas
FOR EACH ROW
BEGIN
    DECLARE cuenta_citas INT;
    
    SELECT COUNT(*) INTO cuenta_citas
    FROM citas 
    WHERE id_paciente = NEW.id_paciente 
    AND id_medico = NEW.id_medico 
    AND fecha = NEW.fecha 
    AND hora = NEW.hora;
    
    IF cuenta_citas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Ya existe una cita programada para este paciente con el mismo médico, fecha y hora';
    END IF;
END //

DELIMITER ;

-- Seguimiento de Nuevas Citas

CREATE TABLE seguimiento_citas (
    id_seguimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_cita INT,
    nombre_paciente VARCHAR(300),
    fecha_cita DATE,
    hora_cita TIME,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(50)
);

DELIMITER //

CREATE TRIGGER SeguimientoNuevasCitas
AFTER INSERT ON citas
FOR EACH ROW
BEGIN
    DECLARE nombre_completo VARCHAR(300);
    
    -- Obtener nombre completo del paciente
    SELECT CONCAT(nombre, ' ', ap_paterno, ' ', ap_materno) 
    INTO nombre_completo
    FROM pacientes 
    WHERE id_paciente = NEW.id_paciente;
    
    -- Insertar en tabla de seguimiento
    INSERT INTO seguimiento_citas (id_cita, nombre_paciente, fecha_cita, hora_cita, accion)
    VALUES (NEW.id_cita, nombre_completo, NEW.fecha, NEW.hora, 'Nueva cita registrada');
END //

DELIMITER ;

-- Probar el trigger insertando una nueva cita
INSERT INTO citas (id_paciente, id_medico, fecha, hora, estado) 
VALUES (1, 1, '2025-09-05', '16:00:00', 'Pendiente');

-- Ver el seguimiento
SELECT * FROM seguimiento_citas;