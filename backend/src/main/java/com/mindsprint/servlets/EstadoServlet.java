package com.mindsprint.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Ruta de prueba para comprobar que el backend arranca.
 * GET /api/estado  ->  { "ok": true }
 */
@WebServlet("/api/estado")
public class EstadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Permite que el frontend llame al backend aunque esté en otra dirección (CORS)
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("{ \"ok\": true }");
    }
}
