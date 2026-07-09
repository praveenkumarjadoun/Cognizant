package singleton;

public class Logger {
    // Private static instance of the class
    private static Logger instance;

    // Private constructor to prevent instantiation from other classes
    private Logger() {
        System.out.println("Logger initialized.");
    }

    // Public static method to provide global access to the instance
    public static synchronized Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    // Dummy logging method
    public void log(String message) {
        System.out.println("[LOG]: " + message);
    }
}
