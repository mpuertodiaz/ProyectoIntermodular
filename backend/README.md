# backend/

API del proyecto hecha con **Java Servlets** y **Maven**.

- `pom.xml`: configuración de Maven, con las librerías (Servlets y driver de MySQL) y el servidor Jetty.
- `src/main/java/com/mindsprint/servlets/`: un Servlet por cada ruta de la API. De momento solo está `EstadoServlet` (`GET /api/estado`).
- `src/main/java/com/mindsprint/util/`: clases de ayuda. `ConexionBD` conecta con MySQL usando los datos del `.env`.

En el Sprint 2 se añadirán:
- `modelo/`: las clases Usuario, Partida, Minijuego, Logro…
- `dao/`: las consultas SQL con `PreparedStatement`.

## Arrancar

```bash
cd backend
mvn jetty:run
```

Abre http://localhost:8080/api/estado y tiene que salir `{ "ok": true }`. Para pararlo, pulsa `Ctrl + C`.

Las rutas de la API están en `docs/api.md`.
