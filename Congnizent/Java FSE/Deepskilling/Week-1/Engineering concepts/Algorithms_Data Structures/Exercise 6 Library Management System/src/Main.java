package library;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        Book[] books = {
            new Book("B003", "The Great Gatsby", "F. Scott Fitzgerald"),
            new Book("B001", "To Kill a Mockingbird", "Harper Lee"),
            new Book("B005", "1984", "George Orwell"),
            new Book("B002", "Pride and Prejudice", "Jane Austen"),
            new Book("B004", "The Catcher in the Rye", "J.D. Salinger")
        };

        System.out.println("--- Linear Search Demonstration (Unsorted) ---");
        String targetTitle = "1984";
        System.out.println("Searching for '" + targetTitle + "' using Linear Search...");
        Book resultLinear = LibrarySearch.linearSearchByTitle(books, targetTitle);
        System.out.println("Result: " + (resultLinear != null ? resultLinear : "Not Found"));

        System.out.println("\n--- Binary Search Demonstration (Sorted) ---");
        // Sort books by title
        Arrays.sort(books);
        System.out.println("Sorted books by title:");
        for (Book b : books) {
            System.out.println("  " + b);
        }

        System.out.println("\nSearching for '" + targetTitle + "' using Binary Search...");
        Book resultBinary = LibrarySearch.binarySearchByTitle(books, targetTitle);
        System.out.println("Result: " + (resultBinary != null ? resultBinary : "Not Found"));

        System.out.println("\nSearching for non-existing title 'Moby Dick'...");
        Book resultFail = LibrarySearch.binarySearchByTitle(books, "Moby Dick");
        System.out.println("Result: " + (resultFail != null ? resultFail : "Not Found"));
    }
}
