package task;

public class Main {
    public static void main(String[] args) {
        TaskLinkedList list = new TaskLinkedList();

        System.out.println("--- Testing Add Operations ---");
        list.addTask(new Task("T001", "Design Database Schema", "Pending"));
        list.addTask(new Task("T002", "Implement Authentication", "In Progress"));
        list.addTask(new Task("T003", "Write Unit Tests", "Pending"));
        list.addTask(new Task("T004", "Deploy to Staging", "Completed"));
        list.traverseTasks();

        System.out.println("\n--- Testing Search Operation ---");
        String targetId = "T002";
        System.out.println("Searching for task " + targetId + "...");
        Task found = list.searchTask(targetId);
        System.out.println("Found: " + (found != null ? found : "Not Found"));

        System.out.println("\n--- Testing Delete Operations ---");
        // Delete middle node
        list.deleteTask("T003");
        list.traverseTasks();

        // Delete head node
        list.deleteTask("T001");
        list.traverseTasks();

        // Delete tail node
        list.deleteTask("T004");
        list.traverseTasks();

        // Try deleting non-existing task
        list.deleteTask("T999");
    }
}
