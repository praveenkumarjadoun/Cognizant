package mvc;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing MVC Pattern ---");

        // 1. Fetch student record from database/resource
        Student model = retrieveStudentFromDatabase();

        // 2. Create view
        StudentView view = new StudentView();

        // 3. Create controller
        StudentController controller = new StudentController(model, view);

        // 4. Initial view display
        System.out.println("Initial State:");
        controller.updateView();

        System.out.println();

        // 5. Update model data through controller
        System.out.println("--> Updating student name and grade...");
        controller.setStudentName("Bob Johnson");
        controller.setStudentGrade("A+");

        // 6. View display after update
        System.out.println("Updated State:");
        controller.updateView();
    }

    private static Student retrieveStudentFromDatabase() {
        return new Student("S101", "Alice Smith", "B");
    }
}
