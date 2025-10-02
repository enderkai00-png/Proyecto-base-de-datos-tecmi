
package src.main.codigo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PacienteDAO {
    
    public boolean crearPaciente(Paciente paciente) {
        String sql = "INSERT INTO pacientes (nombre, ap_paterno, ap_materno, fecha_nacimiento, genero, telefono, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, paciente.getNombre());
            pstmt.setString(2, paciente.getApPaterno());
            pstmt.setString(3, paciente.getApMaterno());
            pstmt.setDate(4, Date.valueOf(paciente.getFechaNacimiento()));
            pstmt.setString(5, paciente.getGenero());
            pstmt.setString(6, paciente.getTelefono());
            pstmt.setString(7, paciente.getEmail());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al crear paciente: " + e.getMessage());
            return false;
        }
    }
    
    public List<Paciente> obtenerTodosPacientes() {
        List<Paciente> pacientes = new ArrayList<>();
        String sql = "SELECT * FROM pacientes ORDER BY id_paciente";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Paciente paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("id_paciente"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setApPaterno(rs.getString("ap_paterno"));
                paciente.setApMaterno(rs.getString("ap_materno"));
                
                Date fecha = rs.getDate("fecha_nacimiento");
                if (fecha != null) {
                    paciente.setFechaNacimiento(fecha.toLocalDate());
                }
                
                paciente.setGenero(rs.getString("genero"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setEmail(rs.getString("email"));
                
                pacientes.add(paciente);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener pacientes: " + e.getMessage());
        }
        
        return pacientes;
    }
    
    public Paciente buscarPacientePorId(int id) {
        String sql = "SELECT * FROM pacientes WHERE id_paciente = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Paciente paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("id_paciente"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setApPaterno(rs.getString("ap_paterno"));
                paciente.setApMaterno(rs.getString("ap_materno"));
                
                Date fecha = rs.getDate("fecha_nacimiento");
                if (fecha != null) {
                    paciente.setFechaNacimiento(fecha.toLocalDate());
                }
                
                paciente.setGenero(rs.getString("genero"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setEmail(rs.getString("email"));
                
                return paciente;
            }
            
        } catch (SQLException e) {
            System.err.println("Error al buscar paciente: " + e.getMessage());
        }
        
        return null;
    }
    
    public boolean actualizarPaciente(Paciente paciente) {
        String sql = "UPDATE pacientes SET nombre = ?, ap_paterno = ?, ap_materno = ?, fecha_nacimiento = ?, genero = ?, telefono = ?, email = ? WHERE id_paciente = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, paciente.getNombre());
            pstmt.setString(2, paciente.getApPaterno());
            pstmt.setString(3, paciente.getApMaterno());
            pstmt.setDate(4, Date.valueOf(paciente.getFechaNacimiento()));
            pstmt.setString(5, paciente.getGenero());
            pstmt.setString(6, paciente.getTelefono());
            pstmt.setString(7, paciente.getEmail());
            pstmt.setInt(8, paciente.getIdPaciente());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar paciente: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminarPaciente(int id) {
        String sql = "DELETE FROM pacientes WHERE id_paciente = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar paciente: " + e.getMessage());
            return false;
        }
    }
}