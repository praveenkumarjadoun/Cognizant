package search;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        // Create an array of products
        Product[] products = {
            new Product("P105", "Wireless Mouse", "Electronics"),
            new Product("P102", "Mechanical Keyboard", "Electronics"),
            new Product("P109", "Desk Mat", "Office Supplies"),
            new Product("P101", "USB-C Hub", "Electronics"),
            new Product("P107", "Monitor Stand", "Office Supplies")
        };

        System.out.println("--- Linear Search Demonstration (Unsorted Array) ---");
        System.out.println("Products array:");
        for (Product p : products) {
            System.out.println("  " + p);
        }

        String targetId = "P109";
        System.out.println("\nSearching for target '" + targetId + "' using Linear Search...");
        Product resultLinear = SearchAlgorithms.linearSearch(products, targetId);
        System.out.println("Result: " + (resultLinear != null ? resultLinear : "Not Found"));

        System.out.println("\nSearching for non-existent ID 'P999' using Linear Search...");
        Product resultLinearFail = SearchAlgorithms.linearSearch(products, "P999");
        System.out.println("Result: " + (resultLinearFail != null ? resultLinearFail : "Not Found"));


        System.out.println("\n--- Binary Search Demonstration (Sorted Array) ---");
        // Sort products by productId for binary search
        Arrays.sort(products);
        System.out.println("Sorted products array:");
        for (Product p : products) {
            System.out.println("  " + p);
        }

        System.out.println("\nSearching for target '" + targetId + "' using Binary Search...");
        Product resultBinary = SearchAlgorithms.binarySearch(products, targetId);
        System.out.println("Result: " + (resultBinary != null ? resultBinary : "Not Found"));

        System.out.println("\nSearching for non-existent ID 'P999' using Binary Search...");
        Product resultBinaryFail = SearchAlgorithms.binarySearch(products, "P999");
        System.out.println("Result: " + (resultBinaryFail != null ? resultBinaryFail : "Not Found"));
    }
}
