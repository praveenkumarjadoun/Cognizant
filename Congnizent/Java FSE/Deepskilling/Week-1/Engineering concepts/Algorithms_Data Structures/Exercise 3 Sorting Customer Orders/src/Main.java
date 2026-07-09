package sorting;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        // Base orders to sort
        Order[] ordersBubble = {
            new Order("O001", "Alice", 250.50),
            new Order("O002", "Bob", 120.00),
            new Order("O003", "Charlie", 450.75),
            new Order("O004", "David", 80.20),
            new Order("O005", "Emma", 310.00)
        };

        Order[] ordersQuick = Arrays.copyOf(ordersBubble, ordersBubble.length);

        System.out.println("--- Original Orders List ---");
        printOrders(ordersBubble);

        System.out.println("\n--- Testing Bubble Sort ---");
        SortingAlgorithms.bubbleSort(ordersBubble);
        printOrders(ordersBubble);

        System.out.println("\n--- Testing Quick Sort ---");
        SortingAlgorithms.quickSort(ordersQuick, 0, ordersQuick.length - 1);
        printOrders(ordersQuick);
    }

    private static void printOrders(Order[] orders) {
        for (Order o : orders) {
            System.out.println("  " + o);
        }
    }
}
