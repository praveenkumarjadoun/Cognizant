package inventory;

import java.util.HashMap;
import java.util.Map;

public class Inventory {
    private Map<String, Product> products;

    public Inventory() {
        this.products = new HashMap<>();
    }

    // Add product
    public void addProduct(Product product) {
        if (products.containsKey(product.getProductId())) {
            System.out.println("Product with ID " + product.getProductId() + " already exists.");
        } else {
            products.put(product.getProductId(), product);
            System.out.println("Added: " + product);
        }
    }

    // Update product
    public void updateProduct(String productId, int quantity, double price) {
        if (products.containsKey(productId)) {
            Product product = products.get(productId);
            product.setQuantity(quantity);
            product.setPrice(price);
            System.out.println("Updated: " + product);
        } else {
            System.out.println("Product with ID " + productId + " not found.");
        }
    }

    // Delete product
    public void deleteProduct(String productId) {
        if (products.containsKey(productId)) {
            Product removed = products.remove(productId);
            System.out.println("Deleted: " + removed);
        } else {
            System.out.println("Product with ID " + productId + " not found.");
        }
    }

    // Print all products
    public void printInventory() {
        System.out.println("--- Current Inventory ---");
        if (products.isEmpty()) {
            System.out.println("Inventory is empty.");
        } else {
            for (Product p : products.values()) {
                System.out.println(p);
            }
        }
        System.out.println("-------------------------");
    }
}
