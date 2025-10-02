
package src.main.codigo;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {
    private static final String CONFIG_FILE = "config.properties";
    private static Connection connection = null;
    
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Properties props = new Properties();
                // Cargar el archivo desde resources
                InputStream inputStream = DatabaseConnection.class.getClassLoader().getResourceAsStream(CONFIG_FILE);
                if (inputStream == null) {
                    throw new IOException("Archivo de configuración '" + CONFIG_FILE + "' no encontrado en resources");
                }
                props.load(inputStream);
                
                String url = props.getProperty("db.url");
                String username = props.getProperty("db.username");
                String password = props.getProperty("db.password");
                
                // Registrar el driver JDBC
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Conexión establecida exitosamente");
                
            } catch (ClassNotFoundException e) {
                throw new SQLException("Driver MySQL no encontrado: " + e.getMessage());
            } catch (IOException e) {
                throw new SQLException("Error al leer archivo de configuración: " + e.getMessage());
            }
        }
        return connection;
    }
    
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Conexión cerrada");
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}