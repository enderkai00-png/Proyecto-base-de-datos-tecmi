CREATE DATABASE app_medica;
USE app_medica;

-- Tabla PACIENTES
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ap_paterno VARCHAR(50) NOT NULL,
    ap_materno VARCHAR(50),
    fecha_nacimiento DATE,
    genero ENUM('M','F'),
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- Tabla ESPECIALIDADES
CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla MÉDICOS
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ap_paterno VARCHAR(50) NOT NULL,
    ap_materno VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    id_especialidad INT NOT NULL,
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
);

-- Tabla CITAS
CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado ENUM('Pendiente','Confirmada','Cancelada') DEFAULT 'Pendiente',
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- Tabla USUARIOS
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    tipo_usuario ENUM('paciente','medico','admin') NOT NULL,
    id_paciente INT,
    id_medico INT,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);
