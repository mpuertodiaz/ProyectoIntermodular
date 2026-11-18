-- ============================================
-- MindSprint - datos_prueba.sql
-- Ejecutar después de schema.sql
-- Contraseña de prueba de todos los usuarios: Prueba123
-- ============================================

USE mindsprint;

-- USUARIOS
-- puntos_totales = suma de las puntuaciones de sus partidas
INSERT INTO usuario (username, email, password_hash, fecha_registro, nivel_general, puntos_totales, racha_actual, ultimo_dia_jugado) VALUES
('ana_sprint', 'ana.garcia@example.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5BWX4Z3QMh6OS8vB4bZ0rC3vQ6H6a', '2026-10-20 18:02:00', 2, 8015, 7, '2026-11-11'),
('luis_mente', 'luis.romero@example.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5BWX4Z3QMh6OS8vB4bZ0rC3vQ6H6a', '2026-10-22 09:15:00', 1, 1975, 2, '2026-11-10'),
('marta_calc', 'marta.lopez@example.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5BWX4Z3QMh6OS8vB4bZ0rC3vQ6H6a', '2026-10-25 20:47:00', 1, 1888, 1, '2026-11-10'),
('jorge_logic', 'jorge.ruiz@example.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5BWX4Z3QMh6OS8vB4bZ0rC3vQ6H6a', '2026-10-28 17:30:00', 1, 1125, 2, '2026-11-13'),
('dani_novato', 'dani.moreno@example.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5BWX4Z3QMh6OS8vB4bZ0rC3vQ6H6a', '2026-11-12 19:44:00', 1, 550, 1, '2026-11-13');

-- MINIJUEGOS (uno de cada categoría)
INSERT INTO minijuego (nombre, categoria, descripcion, nivel_dificultad_base) VALUES
('Calculo Expres', 'Calculo', 'Resuelve operaciones matematicas antes de que acabe el tiempo', 2),
('Parejas Ocultas', 'Memoria', 'Encuentra todas las parejas de cartas', 1),
('Color Trampa', 'Atencion', 'Pulsa el color en el que esta escrita la palabra', 3),
('Secuencias Logicas', 'Logica', 'Completa la serie con el elemento que falta', 3),
('Palabras al Vuelo', 'Verbal', 'Forma palabras con las letras que aparecen', 2);

-- LOGROS
INSERT INTO logro (nombre, descripcion, icono) VALUES
('Primera partida', 'Termina tu primera partida', 'img/logro_primera.png'),
('Racha de 7 dias', 'Juega al menos una partida 7 dias seguidos', 'img/logro_racha.png'),
('Mil puntos', 'Consigue 1000 puntos o mas en una partida', 'img/logro_mil.png'),
('Sin fallos', 'Termina una partida con 10 aciertos o mas y 0 fallos', 'img/logro_sinfallos.png'),
('Explorador', 'Juega a minijuegos de las 5 categorias', 'img/logro_explorador.png');

-- PARTIDAS
-- puntuacion = aciertos*100 - fallos*25 + (60 - tiempo_empleado), nunca menor que 0 (RN-02)
-- es_reto_diario = TRUE solo en la primera partida del dia de cada usuario (RN-01)
INSERT INTO partida (id_usuario, id_minijuego, puntuacion, aciertos, fallos, tiempo_empleado, fecha_partida, es_reto_diario) VALUES
(1, 1, 1125, 12, 3, 60, '2026-11-05 18:30:00', TRUE),
(1, 2, 755, 8, 2, 55, '2026-11-06 19:10:00', TRUE),
(1, 3, 900, 10, 4, 60, '2026-11-07 17:45:00', TRUE),
(1, 4, 675, 7, 1, 60, '2026-11-08 12:20:00', TRUE),
(1, 5, 827, 9, 3, 58, '2026-11-09 20:05:00', TRUE),
(1, 1, 1350, 14, 2, 60, '2026-11-10 18:00:00', TRUE),
(1, 3, 1108, 11, 0, 52, '2026-11-11 18:40:00', TRUE),
(1, 1, 1275, 13, 1, 60, '2026-11-11 18:55:00', FALSE),
(2, 1, 1450, 15, 2, 60, '2026-11-09 10:15:00', TRUE),
(2, 4, 525, 6, 3, 60, '2026-11-10 11:00:00', TRUE),
(3, 2, 878, 9, 1, 57, '2026-11-10 21:30:00', TRUE),
(3, 2, 1010, 10, 0, 50, '2026-11-10 21:45:00', FALSE),
(4, 5, 375, 5, 5, 60, '2026-11-12 16:00:00', TRUE),
(4, 3, 750, 8, 2, 60, '2026-11-13 16:20:00', TRUE),
(5, 1, 0, 0, 4, 60, '2026-11-13 19:00:00', TRUE),
(5, 1, 550, 6, 2, 60, '2026-11-13 19:10:00', FALSE);

-- LOGROS CONSEGUIDOS
INSERT INTO usuario_logro (id_usuario, id_logro, fecha_desbloqueo) VALUES
(1, 1, '2026-11-05 18:30:00'),
(2, 1, '2026-11-09 10:15:00'),
(3, 1, '2026-11-10 21:30:00'),
(4, 1, '2026-11-12 16:00:00'),
(5, 1, '2026-11-13 19:00:00'),
(1, 2, '2026-11-11 18:40:00'),
(1, 3, '2026-11-05 18:30:00'),
(2, 3, '2026-11-09 10:15:00'),
(3, 3, '2026-11-10 21:45:00'),
(1, 4, '2026-11-11 18:40:00'),
(3, 4, '2026-11-10 21:45:00'),
(1, 5, '2026-11-09 20:05:00');
