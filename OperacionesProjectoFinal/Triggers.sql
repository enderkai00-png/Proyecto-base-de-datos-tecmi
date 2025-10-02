
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