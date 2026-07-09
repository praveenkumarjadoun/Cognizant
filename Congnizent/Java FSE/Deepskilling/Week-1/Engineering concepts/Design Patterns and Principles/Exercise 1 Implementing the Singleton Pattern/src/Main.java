package singleton;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Singleton Pattern ---");

        // Retrieve instances of Logger
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        // Check if both references point to the same memory instance
        System.out.println("Logger 1 reference: " + logger1);
        System.out.println("Logger 2 reference: " + logger2);

        if (logger1 == logger2) {
            System.out.println("SUCCESS: Both variables reference the same Logger instance.");
        } else {
            System.out.println("FAILURE: Multiple Logger instances detected.");
        }

        // Use the logger
        logger1.log("This is a test log message from logger1.");
        logger2.log("This is another test log message from logger2.");
    }
}
