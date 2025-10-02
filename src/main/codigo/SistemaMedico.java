
package src.main.codigo;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Scanner;

/**
 * Sistema médico principal con menú interactivo para gestión de pacientes
 */
public class SistemaMedico {
    private static final Scanner scanner = new Scanner(System.in);
    private static final PacienteDAO pacienteDAO = new PacienteDAO();
    private static final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    public static void main(String[] args) {
        System.out.println("=== SISTEMA MÉDICO - GESTIÓN DE PACIENTES ===");
        
        boolean continuar = true;
        while (continuar) {
            mostrarMenu();
            int opcion = leerOpcion();
            
            switch (opcion) {
                case 1:
                    darDeAltaPaciente();
                    break;
                case 2:
                    consultarTodosPacientes();
                    break;
                case 3:
                    buscarPacientePorId();
                    break;
                case 4:
                    actualizarDatosPaciente();
                    break;
                case 5:
                    eliminarPaciente();
                    break;
                case 6:
                    continuar = false;
                    System.out.println("¡Hasta luego!");
                    break;
                default:
                    System.out.println("Opción no válida. Intente de nuevo.");
            }
            
            if (continuar) {
                System.out.println("\nPresione Enter para continuar...");
                scanner.nextLine();
            }
        }
        
        // Cerrar conexión al salir
        DatabaseConnection.closeConnection();
        scanner.close();
    }
    
    private static void mostrarMenu() {
        System.out.println("\n=== SISTEMA MÉDICO - GESTIÓN DE PACIENTES ===");
        System.out.println("1. Dar de alta un paciente");
        System.out.println("2. Consultar todos los pacientes");
        System.out.println("3. Buscar paciente por ID");
        System.out.println("4. Actualizar datos de paciente");
        System.out.println("5. Eliminar paciente");
        System.out.println("6. Salir");
        System.out.print("Selecciona una opción: ");
    }
    
    private static int leerOpcion() {
        try {
            int opcion = Integer.parseInt(scanner.nextLine());
            return opcion;
        } catch (NumberFormatException e) {
            return -1;
        }
    }
    
    private static void darDeAltaPaciente() {
        System.out.println("\n=== DAR DE ALTA UN PACIENTE ===");
        
        try {
            System.out.print("Nombre: ");
            String nombre = scanner.nextLine().trim();
            
            System.out.print("Apellido Paterno: ");
            String apPaterno = scanner.nextLine().trim();
            
            System.out.print("Apellido Materno (opcional): ");
            String apMaterno = scanner.nextLine().trim();
            if (apMaterno.isEmpty()) apMaterno = null;
            
            System.out.print("Fecha de nacimiento (yyyy-MM-dd): ");
            String fechaStr = scanner.nextLine().trim();
            LocalDate fechaNacimiento = LocalDate.parse(fechaStr, dateFormatter);
            
            System.out.print("Género (M/F): ");
            String genero = scanner.nextLine().trim().toUpperCase();
            
            System.out.print("Teléfono: ");
            String telefono = scanner.nextLine().trim();
            
            System.out.print("Email: ");
            String email = scanner.nextLine().trim();
            
            Paciente paciente = new Paciente(nombre, apPaterno, apMaterno, fechaNacimiento, genero, telefono, email);
            
            if (pacienteDAO.crearPaciente(paciente)) {
                System.out.println("✓ Paciente dado de alta exitosamente");
            } else {
                System.out.println("✗ Error al dar de alta el paciente");
            }
            
        } catch (DateTimeParseException e) {
            System.out.println("✗ Error: Formato de fecha inválido. Use yyyy-MM-dd");
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
        }
    }
    
    private static void consultarTodosPacientes() {
        System.out.println("\n=== CONSULTAR TODOS LOS PACIENTES ===");
        
        List<Paciente> pacientes = pacienteDAO.obtenerTodosPacientes();
        
        if (pacientes.isEmpty()) {
            System.out.println("No hay pacientes registrados");
        } else {
            System.out.println("Total de pacientes: " + pacientes.size());
            System.out.println("-".repeat(100));
            for (Paciente paciente : pacientes) {
                System.out.println(paciente);
            }
        }
    }
    
    private static void buscarPacientePorId() {
        System.out.println("\n=== BUSCAR PACIENTE POR ID ===");
        
        try {
            System.out.print("Ingrese ID del paciente: ");
            int id = Integer.parseInt(scanner.nextLine());
            
            Paciente paciente = pacienteDAO.buscarPacientePorId(id);
            
            if (paciente != null) {
                System.out.println("Paciente encontrado:");
                System.out.println(paciente);
            } else {
                System.out.println("✗ No se encontró paciente con ID: " + id);
            }
            
        } catch (NumberFormatException e) {
            System.out.println("✗ Error: ID debe ser un número válido");
        }
    }
    
    private static void actualizarDatosPaciente() {
        System.out.println("\n=== ACTUALIZAR DATOS DE PACIENTE ===");
        
        try {
            System.out.print("Ingrese ID del paciente a actualizar: ");
            int id = Integer.parseInt(scanner.nextLine());
            
            Paciente paciente = pacienteDAO.buscarPacientePorId(id);
            
            if (paciente == null) {
                System.out.println("✗ No se encontró paciente con ID: " + id);
                return;
            }
            
            System.out.println("Paciente actual: " + paciente);
            System.out.println("Ingrese los nuevos datos (Enter para mantener el valor actual):");
            
            System.out.print("Nombre [" + paciente.getNombre() + "]: ");
            String nombre = scanner.nextLine().trim();
            if (!nombre.isEmpty()) paciente.setNombre(nombre);
            
            System.out.print("Apellido Paterno [" + paciente.getApPaterno() + "]: ");
            String apPaterno = scanner.nextLine().trim();
            if (!apPaterno.isEmpty()) paciente.setApPaterno(apPaterno);
            
            System.out.print("Apellido Materno [" + (paciente.getApMaterno() != null ? paciente.getApMaterno() : "N/A") + "]: ");
            String apMaterno = scanner.nextLine().trim();
            if (!apMaterno.isEmpty()) paciente.setApMaterno(apMaterno);
            
            System.out.print("Fecha de nacimiento [" + paciente.getFechaNacimiento() + "] (yyyy-MM-dd): ");
            String fechaStr = scanner.nextLine().trim();
            if (!fechaStr.isEmpty()) {
                paciente.setFechaNacimiento(LocalDate.parse(fechaStr, dateFormatter));
            }
            
            System.out.print("Género [" + paciente.getGenero() + "] (M/F): ");
            String genero = scanner.nextLine().trim().toUpperCase();
            if (!genero.isEmpty()) paciente.setGenero(genero);
            
            System.out.print("Teléfono [" + paciente.getTelefono() + "]: ");
            String telefono = scanner.nextLine().trim();
            if (!telefono.isEmpty()) paciente.setTelefono(telefono);
            
            System.out.print("Email [" + paciente.getEmail() + "]: ");
            String email = scanner.nextLine().trim();
            if (!email.isEmpty()) paciente.setEmail(email);
            
            if (pacienteDAO.actualizarPaciente(paciente)) {
                System.out.println("✓ Paciente actualizado exitosamente");
            } else {
                System.out.println("✗ Error al actualizar el paciente");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("✗ Error: ID debe ser un número válido");
        } catch (DateTimeParseException e) {
            System.out.println("✗ Error: Formato de fecha inválido. Use yyyy-MM-dd");
        } catch (Exception e) {
            System.out.println("✗ Error: " + e.getMessage());
        }
    }
    
    private static void eliminarPaciente() {
        System.out.println("\n=== ELIMINAR PACIENTE ===");
        
        try {
            System.out.print("Ingrese ID del paciente a eliminar: ");
            int id = Integer.parseInt(scanner.nextLine());
            
            Paciente paciente = pacienteDAO.buscarPacientePorId(id);
            
            if (paciente == null) {
                System.out.println("✗ No se encontró paciente con ID: " + id);
                return;
            }
            
            System.out.println("Paciente a eliminar: " + paciente);
            System.out.print("¿Está seguro que desea eliminar este paciente? (s/N): ");
            String confirmacion = scanner.nextLine().trim().toLowerCase();
            
            if (confirmacion.equals("s") || confirmacion.equals("si")) {
                if (pacienteDAO.eliminarPaciente(id)) {
                    System.out.println("✓ Paciente eliminado exitosamente");
                } else {
                    System.out.println("✗ Error al eliminar el paciente");
                }
            } else {
                System.out.println("Operación cancelada");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("✗ Error: ID debe ser un número válido");
        }
    }
}