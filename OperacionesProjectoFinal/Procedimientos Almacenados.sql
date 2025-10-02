
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

