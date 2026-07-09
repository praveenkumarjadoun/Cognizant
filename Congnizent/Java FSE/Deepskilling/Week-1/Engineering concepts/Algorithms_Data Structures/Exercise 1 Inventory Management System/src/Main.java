package inventory;

public class Main {
    public static void main(String[] args) {
        Inventory inventory = new Inventory();

        System.out.println("--- Testing Add Operation ---");
        Product p1 = new Product("P001", "Laptop", 10, 999.99);
        Product p2 = new Product("P002", "Smartphone", 25, 499.99);
        Product p3 = new Product("P003", "Headphones", 50, 79.99);

        inventory.addProduct(p1);
        inventory.addProduct(p2);
        inventory.addProduct(p3);
        inventory.printInventory();

        System.out.println("\n--- Testing Update Operation ---");
        // Update price and quantity of smartphone
        inventory.updateProduct("P002", 30, 449.99);
        inventory.printInventory();

        System.out.println("\n--- Testing Delete Operation ---");
        // Delete Laptop
        inventory.deleteProduct("P001");
        inventory.printInventory();

        System.out.println("\n--- Testing Edge Cases ---");
        // Add duplicate product
        inventory.addProduct(new Product("P002", "New Phone", 5, 200.00));
        // Update non-existing product
        inventory.updateProduct("P999", 5, 200.00);
        // Delete non-existing product
        inventory.deleteProduct("P999");
    }
}
