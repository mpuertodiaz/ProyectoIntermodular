package com.mindsprint.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Conexión con la base de datos MySQL.
 * Lee los datos del fichero .env de la raíz del proyecto
 * (copia .env.example como .env y pon tu contraseña).
 * Se usará en el Sprint 2 para el CRUD.
 */
public class ConexionBD {

    private static final Properties config = new Properties();

    static {
        // El backend se arranca desde la carpeta backend/, por eso el .env está en ../
        try (FileInputStream fichero = new FileInputStream("../.env")) {
            config.load(fichero);
        } catch (IOException e) {
            System.out.println("No se ha encontrado el fichero .env: " + e.getMessage());
        }
    }

    public static Connection getConexion() throws SQLException {
        String host = config.getProperty("DB_HOST", "localhost");
        String puerto = config.getProperty("DB_PORT", "3306");
        String nombre = config.getProperty("DB_NAME", "mindsprint");
        String usuario = config.getProperty("DB_USER", "root");
        String password = config.getProperty("DB_PASSWORD", "");

        String url = "jdbc:mysql://" + host + ":" + puerto + "/" + nombre;
        return DriverManager.getConnection(url, usuario, password);
    }
}
