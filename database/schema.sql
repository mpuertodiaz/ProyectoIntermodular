-- ============================================
-- MindSprint - App web de agilidad mental
-- schema.sql: crea la base de datos desde cero
-- Autores: Manuel Puerto Díaz y Pablo de la Rosa
-- ============================================

DROP DATABASE IF EXISTS mindsprint;
CREATE DATABASE mindsprint CHARACTER SET utf8mb4;
USE mindsprint;

-- Tabla USUARIO
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivel_general INT DEFAULT 1,
    puntos_totales INT DEFAULT 0,
    racha_actual INT DEFAULT 0,
    ultimo_dia_jugado DATE
);

-- Tabla MINIJUEGO
CREATE TABLE minijuego (
    id_minijuego INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria ENUM('Memoria', 'Calculo', 'Logica', 'Atencion', 'Verbal') NOT NULL,
    descripcion VARCHAR(255),
    nivel_dificultad_base INT DEFAULT 1
);

-- Tabla PARTIDA
CREATE TABLE partida (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_minijuego INT NOT NULL,
    puntuacion INT DEFAULT 0,
    aciertos INT DEFAULT 0,
    fallos INT DEFAULT 0,
    tiempo_empleado INT NOT NULL,
    fecha_partida DATETIME DEFAULT CURRENT_TIMESTAMP,
    es_reto_diario BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_minijuego) REFERENCES minijuego(id_minijuego)
);

-- Tabla LOGRO
CREATE TABLE logro (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    icono VARCHAR(100)
);

-- Tabla USUARIO_LOGRO (relación N:M entre usuario y logro)
CREATE TABLE usuario_logro (
    id_usuario INT NOT NULL,
    id_logro INT NOT NULL,
    fecha_desbloqueo DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_logro),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_logro) REFERENCES logro(id_logro) ON DELETE CASCADE
);
