package employee;

public class Main {
    public static void main(String[] args) {
        EmployeeManagement manager = new EmployeeManagement(5);

        System.out.println("--- Testing Add Operations ---");
        manager.addEmployee(new Employee("E01", "John Doe", "Software Engineer", 75000));
        manager.addEmployee(new Employee("E02", "Jane Smith", "Project Manager", 90000));
        manager.addEmployee(new Employee("E03", "Robert Johnson", "QA Engineer", 60000));
        manager.traverseEmployees();

        System.out.println("\n--- Testing Search Operation ---");
        String targetId = "E02";
        System.out.println("Searching for " + targetId + "...");
        Employee found = manager.searchEmployee(targetId);
        System.out.println("Found: " + (found != null ? found : "Not Found"));

        System.out.println("\n--- Testing Delete Operation ---");
        manager.deleteEmployee("E01");
        manager.traverseEmployees();

        System.out.println("\n--- Testing Array Overflow ---");
        manager.addEmployee(new Employee("E04", "Alice Brown", "Designer", 65000));
        manager.addEmployee(new Employee("E05", "Charlie Green", "HR Specialist", 55000));
        // Array is now full (E02, E03, E04, E05 are the 4 items, since capacity is 5 and we added 2 more it makes 4, we can add 1 more)
        manager.addEmployee(new Employee("E06", "David White", "DevOps Engineer", 80000));
        // Try adding one more (exceeding capacity of 5)
        manager.addEmployee(new Employee("E07", "Eva Black", "CTO", 150000));

        manager.traverseEmployees();
    }
}
