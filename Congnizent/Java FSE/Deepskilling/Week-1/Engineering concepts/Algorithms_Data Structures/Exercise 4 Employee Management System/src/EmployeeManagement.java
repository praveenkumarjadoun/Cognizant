package employee;

public class EmployeeManagement {
    private Employee[] employees;
    private int size;

    public EmployeeManagement(int capacity) {
        this.employees = new Employee[capacity];
        this.size = 0;
    }

    // Add employee
    public boolean addEmployee(Employee employee) {
        if (size >= employees.length) {
            System.out.println("Cannot add employee: Array is full.");
            return false;
        }
        employees[size++] = employee;
        System.out.println("Added: " + employee);
        return true;
    }

    // Search employee by ID
    public Employee searchEmployee(String employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId().equals(employeeId)) {
                return employees[i];
            }
        }
        return null;
    }

    // Traverse and print employees
    public void traverseEmployees() {
        System.out.println("--- Employee Directory ---");
        if (size == 0) {
            System.out.println("No employees found.");
        } else {
            for (int i = 0; i < size; i++) {
                System.out.println(employees[i]);
            }
        }
        System.out.println("--------------------------");
    }

    // Delete employee by ID
    public boolean deleteEmployee(String employeeId) {
        int indexToDelete = -1;
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId().equals(employeeId)) {
                indexToDelete = i;
                break;
            }
        }

        if (indexToDelete == -1) {
            System.out.println("Employee with ID " + employeeId + " not found.");
            return false;
        }

        // Shift elements to the left
        for (int i = indexToDelete; i < size - 1; i++) {
            employees[i] = employees[i + 1];
        }
        employees[size - 1] = null; // Clear reference
        size--;
        System.out.println("Deleted employee with ID: " + employeeId);
        return true;
    }
}
