# API de MindSprint (Tarea 5)

Este documento recoge la elección del backend y el diseño del CRUD. En el Sprint 1 el CRUD solo se diseña; se programará en el Sprint 2.

## 1. Elección del backend

| Opción | Lenguaje | A favor | En contra |
|---|---|---|---|
| **Java Servlets (Jakarta EE) + Jetty/Tomcat** | Java | Lo conocemos de Programación y lo usamos con JDBC en Acceso a Datos. Es más ligero que Spring y se ve bien qué hace cada clase | Hay que escribir a mano cosas como convertir a JSON o leer las rutas |
| Spring Boot | Java | Trae casi todo hecho: rutas, JSON, conexión a la base de datos | Mucha configuración y "magia" que todavía no hemos visto en clase |
| Node.js + Express | JavaScript | Mismo lenguaje que el frontend y muy rápido de empezar | Es un lenguaje de servidor nuevo para el equipo |

**Decisión: Java Servlets.** Es el mismo backend que elegimos en la primera entrega (apartado 5.1), así que el stack no cambia. Lo elegimos por estos motivos:

- Los dos miembros del equipo sabemos Java.
- Con JDBC y `PreparedStatement` cumplimos lo que prometimos en el apartado 3.2 sobre la inyección SQL.
- Cada ruta es un Servlet, así que es fácil repartir el trabajo.

El proyecto usa **Maven**, que descarga solo las librerías. Además, con el plugin de **Jetty** el backend arranca con un único comando (`mvn jetty:run`), sin tener que instalar Tomcat en cada ordenador. Si alguien prefiere Tomcat 10.1, también vale: el proyecto genera un `.war` normal.

### Backend de prueba

El proyecto está en `backend/` y responde en una ruta de prueba:

```
GET http://localhost:8080/api/estado   →   { "ok": true }
```

Las instrucciones para arrancarlo están en el `README.md` principal.

## 2. Diseño del CRUD

Todas las rutas empiezan por `/api`. El backend recibe y devuelve **JSON**.

Códigos de respuesta que usamos:

| Código | Significado |
|---|---|
| 200 | Todo bien |
| 201 | Creado |
| 400 | Datos incorrectos |
| 401 | No has iniciado sesión o la contraseña es incorrecta |
| 404 | No existe |
| 409 | Conflicto (por ejemplo, un email repetido) |

### 2.1 Usuarios

| Método | Ruta | Qué hace | Recibe | Devuelve | HU / RN |
|---|---|---|---|---|---|
| POST | `/api/usuarios` | Registra un usuario nuevo | username, email, password | 201 + usuario, 400 (contraseña no válida) o 409 (email repetido) | HU-01 |
| POST | `/api/login` | Inicia sesión | email, password | 200 + usuario o 401 | HU-01 |
| GET | `/api/usuarios/{id}` | Muestra el perfil para el Dashboard: nivel, puntos y racha | — | 200 + usuario o 404 | HU-01, RN-03 |
| PUT | `/api/usuarios/{id}` | Cambia el username o la contraseña | username y/o password | 200, 400 o 404 | HU-01 |
| DELETE | `/api/usuarios/{id}` | Elimina la cuenta y todas sus partidas y logros | — | 200 o 404 | Apartado 3.1 |

- La contraseña debe tener mínimo 8 caracteres, una mayúscula y un número (HU-01). Se guarda cifrada con BCrypt y nunca se devuelve en el JSON.

### 2.2 Minijuegos

| Método | Ruta | Qué hace | Recibe | Devuelve | HU / RN |
|---|---|---|---|---|---|
| GET | `/api/minijuegos` | Lista los minijuegos. Se puede filtrar con `?categoria=Memoria` | — | 200 + lista | HU-02 |
| GET | `/api/minijuegos/{id}` | Muestra un minijuego con sus instrucciones | — | 200 o 404 | HU-02, CU 4.3 |
| POST | `/api/minijuegos` | Añade un minijuego al catálogo | nombre, categoria, descripcion, nivel_dificultad_base | 201 o 400 | HU-02 |
| PUT | `/api/minijuegos/{id}` | Modifica un minijuego | los mismos campos | 200, 400 o 404 | HU-02 |
| DELETE | `/api/minijuegos/{id}` | Borra un minijuego si nadie lo ha jugado todavía | — | 200, 404 o 409 (tiene partidas) | HU-02 |

### 2.3 Partidas (entidad principal)

| Método | Ruta | Qué hace | Recibe | Devuelve | HU / RN |
|---|---|---|---|---|---|
| GET | `/api/partidas?usuario={id}` | Lista las partidas de un usuario | — | 200 + lista | HU-02 |
| GET | `/api/partidas/{id}` | Muestra una partida (pantalla de resumen) | — | 200 o 404 | HU-02 |
| POST | `/api/partidas` | Guarda una partida cuando el tiempo llega a 0 | id_usuario, id_minijuego, aciertos, fallos, tiempo_empleado | 201 o 400 | HU-02, CU 4.3, RN-01, RN-02, RN-03 |

Las partidas **no tienen PUT ni DELETE**. Una partida terminada no se puede cambiar, porque si no se podrían hacer trampas con la puntuación. Las partidas solo se borran cuando el usuario elimina su cuenta. Las partidas canceladas no llegan al backend (flujo alternativo del CU 4.3).

Qué hace el servidor en el `POST /api/partidas`:

1. Comprueba que el usuario y el minijuego existen, y que `tiempo_empleado` está entre 1 y 60. Si no, devuelve 400.
2. **RN-02.** Calcula la puntuación: `aciertos*100 - fallos*25 + (60 - tiempo_empleado)`. Si sale negativa, guarda 0. La puntuación la calcula el servidor; el frontend no la envía, así nadie puede mandar una puntuación inventada.
3. **RN-01.** Mira si el usuario ya tiene una partida con `es_reto_diario = TRUE` hoy. Si no la tiene, esta partida es el reto del día.
4. Hace el `INSERT` en `partida` y suma los puntos a `usuario.puntos_totales`.
5. **RN-03.** Actualiza `racha_actual` y `ultimo_dia_jugado`. Si la racha llega a 7, inserta el logro "Racha de 7 dias".

### 2.4 Logros

| Método | Ruta | Qué hace | Recibe | Devuelve | HU / RN |
|---|---|---|---|---|---|
| GET | `/api/logros` | Lista todos los logros que existen | — | 200 + lista | RN-03 |
| GET | `/api/usuarios/{id}/logros` | Lista los logros que tiene un usuario | — | 200 + lista o 404 | RN-03 |

Los logros se dan de forma automática al guardar una partida, así que no tienen POST desde el frontend.

### 2.5 Ranking y estadísticas

| Método | Ruta | Qué hace | Devuelve | HU / RN |
|---|---|---|---|---|
| GET | `/api/ranking` | Los 5 usuarios con más puntos | 200 + lista | Pantalla de Clasificación |
| GET | `/api/ranking/reto-diario?fecha=2026-11-10` | Ranking del reto de un día. Sin fecha, el de hoy | 200 + lista | RN-01 |
| GET | `/api/usuarios/{id}/estadisticas` | Partidas jugadas, % de aciertos y mejor puntuación | 200 o 404 | Pantalla de Estadísticas |

## 3. Ejemplos JSON del POST de partidas

### Petición
```http
POST /api/partidas
Content-Type: application/json
```
```json
{
  "id_usuario": 1,
  "id_minijuego": 3,
  "aciertos": 11,
  "fallos": 0,
  "tiempo_empleado": 52
}
```

### Respuesta correcta (201 Created)
```json
{
  "id_partida": 17,
  "id_usuario": 1,
  "id_minijuego": 3,
  "aciertos": 11,
  "fallos": 0,
  "tiempo_empleado": 52,
  "puntuacion": 1108,
  "es_reto_diario": true,
  "fecha_partida": "2026-11-11T18:40:00",
  "racha_actual": 7,
  "logros_nuevos": [
    { "id_logro": 2, "nombre": "Racha de 7 dias" }
  ]
}
```
`puntuacion = 11*100 - 0*25 + (60 - 52) = 1108` (RN-02).

### Respuesta con error (400 Bad Request)
```json
{
  "ok": false,
  "error": "El tiempo empleado debe estar entre 1 y 60 segundos"
}
```

### Ejemplo de registro (POST /api/usuarios)
Petición:
```json
{ "username": "ana_sprint", "email": "ana.garcia@example.com", "password": "Prueba123" }
```
Respuesta 409, si el email ya existe:
```json
{ "ok": false, "error": "Ya existe una cuenta con ese email" }
```
