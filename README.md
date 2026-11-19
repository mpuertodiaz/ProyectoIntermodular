# MindSprint

Aplicación web de agilidad mental: minijuegos de 60 segundos de cálculo, memoria, lógica, atención y agilidad verbal, con puntuaciones, rachas, logros y ranking.

**Equipo:** Manuel Puerto Díaz (backend y base de datos) y Pablo de la Rosa (frontend).

## Estructura del proyecto

```
ProyectoIntermodular/
├── backend/        API en Java Servlets (Maven)
├── frontend/       Interfaz: HTML, CSS, JavaScript y Bootstrap
├── database/       schema.sql y datos_prueba.sql
├── docs/           Documentación, api.md y PDF corregido
├── .env.example    Plantilla de configuración (sin contraseñas)
├── .gitignore
└── README.md
```

## Qué hace falta instalar

- **Java 17** o superior (JDK)
- **Eclipse** ("Enterprise Java and Web Developers") o IntelliJ. Los dos traen Maven incluido
- **MySQL 8**: XAMPP o MySQL Server con MySQL Workbench
- Un navegador

## 1. Configuración

Copia el fichero `.env.example` y llámalo `.env`. Después pon en él tu usuario y contraseña de MySQL:

```
DB_USER=root
DB_PASSWORD=tu_contraseña
```

El fichero `.env` no se sube a GitHub (está en el `.gitignore`), así que cada uno tiene el suyo.

## 2. Crear la base de datos

Con MySQL arrancado, ejecuta los dos scripts **en este orden**.

**Opción A, con MySQL Workbench:**
1. Abre *File → Open SQL Script* y elige `database/schema.sql`. Ejecútalo con el rayo.
2. Haz lo mismo con `database/datos_prueba.sql`.

**Opción B, desde la consola:**
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p < database/datos_prueba.sql
```

Se puede repetir las veces que haga falta: `schema.sql` borra la base de datos y la crea de nuevo.

## 3. Arrancar el backend

```bash
cd backend
mvn jetty:run
```

La primera vez tarda un poco porque Maven descarga las librerías. Cuando salga `Started Server`, abre en el navegador:

http://localhost:8080/api/estado

Tiene que aparecer `{ "ok": true }`. Para parar el servidor, pulsa `Ctrl + C`.

**Desde Eclipse:**
1. *File → Import… → Maven → Existing Maven Projects* y elige la carpeta `backend`.
2. Clic derecho en el proyecto `mindsprint-backend` → *Run As → Maven build…*.
3. En **Goals** escribe `jetty:run` (con dos puntos) y pulsa *Run*.
4. Cuando en la consola salga `Started Server`, abre http://localhost:8080/api/estado.

**Desde Eclipse:** abre la carpeta `backend` como proyecto Maven. Luego, en el panel *Maven* de la derecha, ve a *Plugins → jetty → jetty:run* y haz doble clic.

## 4. Abrir el frontend

Abre `frontend/index.html` en el navegador. También puedes usar la extensión *Live Server* de VS Code.

## Documentación

- `docs/api.md`: elección del backend, rutas de la API y ejemplos JSON.
- `docs/framework_css.md`: elección del framework CSS.

## Forma de trabajar con Git

- `main`: versiones estables. Protegida.
- `develop`: rama de desarrollo. Protegida.
- `feature/...`: una rama por tarea, creada desde `develop`. Se une a `develop` mediante una Pull Request revisada por el compañero.
- Commits: `feat:` (nueva función), `fix:` (corrección), `docs:` (documentación) y `style:` (estilos).
