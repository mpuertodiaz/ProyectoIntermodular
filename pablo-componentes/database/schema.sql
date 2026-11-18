-- Creación de la base de datos
DROP DATABASE IF EXISTS agilidad_mental;
CREATE DATABASE agilidad_mental CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE agilidad_mental;

-- 1. Tabla USUARIO
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nivel_general INT DEFAULT 1,
    puntos_totales INT DEFAULT 0
);

-- 2. Tabla MINIJUEGO
CREATE TABLE MINIJUEGO (
    id_minijuego INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria ENUM('Memoria', 'Cálculo', 'Lógica', 'Atención') NOT NULL,
    descripcion TEXT,
    nivel_dificultad_base INT DEFAULT 1
);

-- 3. Tabla PARTIDA
CREATE TABLE PARTIDA (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_minijuego INT NOT NULL,
    puntuacion INT NOT NULL,
    aciertos INT NOT NULL,
    fallos INT NOT NULL,
    tiempo_empleado INT NOT NULL, -- en segundos
    fecha_partida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_minijuego) REFERENCES MINIJUEGO(id_minijuego) ON DELETE CASCADE
);

-- 4. Tabla LOGRO
CREATE TABLE LOGRO (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    icono VARCHAR(100)
);

-- 5. Tabla USUARIO_LOGRO (Relación N:M)
CREATE TABLE USUARIO_LOGRO (
    id_usuario INT NOT NULL,
    id_logro INT NOT NULL,
    fecha_desbloqueo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_logro),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_logro) REFERENCES LOGRO(id_logro) ON DELETE CASCADE
);