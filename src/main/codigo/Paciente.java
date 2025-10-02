
package src.main.codigo;

import java.time.LocalDate;


public class Paciente {
    private int idPaciente;
    private String nombre;
    private String apPaterno;
    private String apMaterno;
    private LocalDate fechaNacimiento;
    private String genero;
    private String telefono;
    private String email;
    
    // Constructor vacío
    public Paciente() {}
    
    // Constructor completo
    public Paciente(String nombre, String apPaterno, String apMaterno, 
                   LocalDate fechaNacimiento, String genero, String telefono, String email) {
        this.nombre = nombre;
        this.apPaterno = apPaterno;
        this.apMaterno = apMaterno;
        this.fechaNacimiento = fechaNacimiento;
        this.genero = genero;
        this.telefono = telefono;
        this.email = email;
    }
    
    // Getters y Setters
    public int getIdPaciente() {
        return idPaciente;
    }
    
    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getApPaterno() {
        return apPaterno;
    }
    
    public void setApPaterno(String apPaterno) {
        this.apPaterno = apPaterno;
    }
    
    public String getApMaterno() {
        return apMaterno;
    }
    
    public void setApMaterno(String apMaterno) {
        this.apMaterno = apMaterno;
    }
    
    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }
    
    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    
    public String getGenero() {
        return genero;
    }
    
    public void setGenero(String genero) {
        this.genero = genero;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    @Override
    public String toString() {
        return String.format("ID: %d | %s %s %s | Género: %s | Teléfono: %s | Email: %s | Nacimiento: %s",
                idPaciente, nombre, apPaterno, apMaterno != null ? apMaterno : "", 
                genero, telefono, email, fechaNacimiento);
    }
}