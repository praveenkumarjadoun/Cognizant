package task;

public class TaskLinkedList {
    private static class Node {
        Task task;
        Node next;

        Node(Task task) {
            this.task = task;
            this.next = null;
        }
    }

    private Node head;
    private Node tail;

    public TaskLinkedList() {
        this.head = null;
        this.tail = null;
    }

    // Add task at the end of the list: O(1) time
    public void addTask(Task task) {
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }
        System.out.println("Added: " + task);
    }

    // Search task by ID: O(N) time
    public Task searchTask(String taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.getTaskId().equals(taskId)) {
                return current.task;
            }
            current = current.next;
        }
        return null;
    }

    // Traverse and print all tasks: O(N) time
    public void traverseTasks() {
        System.out.println("--- Task List ---");
        if (head == null) {
            System.out.println("No tasks found.");
        } else {
            Node current = head;
            while (current != null) {
                System.out.println(current.task);
                current = current.next;
            }
        }
        System.out.println("-----------------");
    }

    // Delete task by ID: O(N) time
    public boolean deleteTask(String taskId) {
        if (head == null) {
            System.out.println("List is empty. Cannot delete.");
            return false;
        }

        // Edge case: delete head
        if (head.task.getTaskId().equals(taskId)) {
            if (head == tail) {
                tail = null;
            }
            head = head.next;
            System.out.println("Deleted task with ID: " + taskId);
            return true;
        }

        Node current = head;
        while (current.next != null && !current.next.task.getTaskId().equals(taskId)) {
            current = current.next;
        }

        if (current.next == null) {
            System.out.println("Task with ID " + taskId + " not found.");
            return false;
        }

        // Delete current.next node
        if (current.next == tail) {
            tail = current; // update tail if last element is deleted
        }
        current.next = current.next.next;
        System.out.println("Deleted task with ID: " + taskId);
        return true;
    }
}
