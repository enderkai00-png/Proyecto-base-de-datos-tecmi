-- PACIENTES
INSERT INTO pacientes (nombre, ap_paterno, ap_materno, fecha_nacimiento, genero, telefono, email) VALUES
('Juan','Pérez','Lopez','1990-05-10','M','555123456','juanperez@email.com'),
('María','García','Martínez','1985-02-20','F','555987654','maria.garcia@email.com'),
('Luis','Hernández','Torres','2000-07-12','M','555654321','luisht@email.com'),
('Ana','Ramírez','Díaz','1995-09-25','F','555321987','ana.rdz@email.com'),
('Pedro','Sánchez','Flores','1988-11-30','M','555111222','pedrosf@email.com'),
('Sofía','López','Ramírez','1993-03-15','F','555666777','sofia.lopez@email.com'),
('Miguel','Torres','Hernández','1980-06-10','M','555777888','miguel.torres@email.com'),
('Camila','Gómez','Ruiz','2002-01-05','F','555888999','camila.gomez@email.com'),
('Javier','Martínez','Castillo','1998-12-20','M','555999000','javier.mtz@email.com'),
('Fernanda','Vargas','Santos','1991-04-18','F','555000111','fernanda.vs@email.com');

-- ESPECIALIDADES
INSERT INTO especialidades (nombre, descripcion) VALUES
('Cardiología','Especialidad del corazón'),
('Pediatría','Atención médica de niños'),
('Dermatología','Tratamiento de la piel'),
('Neurología','Enfermedades del sistema nervioso'),
('Ginecología','Salud reproductiva femenina'),
('Oftalmología','Tratamiento de enfermedades oculares'),
('Ortopedia','Tratamiento de huesos y articulaciones'),
('Psiquiatría','Atención de trastornos mentales'),
('Endocrinología','Trastornos hormonales y metabólicos'),
('Oncología','Diagnóstico y tratamiento del cáncer');

-- MÉDICOS
INSERT INTO medicos (nombre, ap_paterno, ap_materno, telefono, email, id_especialidad) VALUES
('Carlos','Ruiz','Fernández','555111111','carlos.ruiz@medico.com',1),
('Laura','Mendoza','Ortega','555222222','laura.mendoza@medico.com',2),
('José','Morales','Castro','555333333','jose.morales@medico.com',3),
('Elena','Soto','Ramirez','555444444','elena.soto@medico.com',4),
('Ricardo','Vega','Campos','555555555','ricardo.vega@medico.com',5),
('Patricia','Reyes','Moreno','555666111','patricia.reyes@medico.com',6),
('Andrés','Domínguez','Flores','555777222','andres.dominguez@medico.com',7),
('Claudia','Núñez','García','555888333','claudia.nunez@medico.com',8),
('Héctor','Rojas','Martínez','555999444','hector.rojas@medico.com',9),
('Gabriela','Cruz','Fernández','555000555','gabriela.cruz@medico.com',10);

-- CITAS
INSERT INTO citas (id_paciente, id_medico, fecha, hora, estado) VALUES
(1,1,'2025-08-30','09:00:00','Confirmada'),
(2,2,'2025-08-30','10:30:00','Pendiente'),
(3,3,'2025-08-31','11:00:00','Confirmada'),
(4,4,'2025-09-01','12:00:00','Cancelada'),
(5,5,'2025-09-01','14:30:00','Pendiente'),
(6,6,'2025-09-02','09:15:00','Pendiente'),
(7,7,'2025-09-02','10:45:00','Confirmada'),
(8,8,'2025-09-03','11:30:00','Pendiente'),
(9,9,'2025-09-03','12:45:00','Confirmada'),
(10,10,'2025-09-04','15:00:00','Pendiente');

-- USUARIOS
INSERT INTO usuarios (usuario, contrasena, tipo_usuario, id_paciente, id_medico) VALUES
('juanp','12345','paciente',1,NULL),
('maria_g','12345','paciente',2,NULL),
('carlosr','12345','medico',NULL,1),
('lauram','12345','medico',NULL,2),
('admin','admin123','admin',NULL,NULL),
('sofia_l','clave123','paciente',6,NULL),
('miguel_t','clave123','paciente',7,NULL),
('camila_g','clave123','paciente',8,NULL),
('javier_m','clave123','paciente',9,NULL),
('fernanda_v','clave123','paciente',10,NULL),
('patricia_r','clave123','medico',NULL,6),
('andres_d','clave123','medico',NULL,7),
('claudia_n','clave123','medico',NULL,8),
('hector_r','clave123','medico',NULL,9),
('gabriela_c','clave123','medico',NULL,10);


