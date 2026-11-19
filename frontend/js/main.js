// MindSprint - JavaScript principal del frontend
// Dirección del backend (Java Servlets)
const API_URL = "http://localhost:8080/api";

// Prueba: comprueba si el backend está arrancado (GET /api/estado)
fetch(API_URL + "/estado")
    .then(respuesta => respuesta.json())
    .then(datos => console.log("Backend conectado:", datos))
    .catch(() => console.log("El backend no está arrancado"));
