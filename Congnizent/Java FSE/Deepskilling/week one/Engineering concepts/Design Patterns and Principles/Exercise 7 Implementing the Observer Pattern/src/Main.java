package observer;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Observer Pattern ---");

        // Create concrete subject (Apple stock)
        StockMarket appleStock = new StockMarket("AAPL", 175.50);

        // Create observers
        Observer mobileClient1 = new MobileApp("iPhone User 1");
        Observer mobileClient2 = new MobileApp("Android User 2");
        Observer webDashboard = new WebApp("FinancialTerminal");

        // Register observers
        appleStock.registerObserver(mobileClient1);
        appleStock.registerObserver(mobileClient2);
        appleStock.registerObserver(webDashboard);

        // Trigger updates
        appleStock.setPrice(178.20);
        appleStock.setPrice(180.00);

        // Deregister an observer
        System.out.println("\n--- Removing an Observer ---");
        appleStock.deregisterObserver(mobileClient2);

        // Trigger further updates
        appleStock.setPrice(179.40);
    }
}
