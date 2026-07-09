package decorator;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Decorator Pattern ---");

        // 1. Basic Notifier (Email only)
        System.out.println("Scenario A: Email Notifier only");
        Notifier emailNotifier = new EmailNotifier();
        emailNotifier.send("System update: Success!");

        System.out.println("\n---------------------------------\n");

        // 2. Decorate Email with SMS
        System.out.println("Scenario B: Email + SMS Notifier");
        Notifier emailAndSMS = new SMSNotifierDecorator(new EmailNotifier());
        emailAndSMS.send("Server overload warning!");

        System.out.println("\n---------------------------------\n");

        // 3. Decorate Email with SMS and Slack (multiple channels)
        System.out.println("Scenario C: Email + SMS + Slack Notifier");
        Notifier multiChannelNotifier = new SlackNotifierDecorator(
                new SMSNotifierDecorator(
                        new EmailNotifier()
                )
        );
        multiChannelNotifier.send("Critical Security Breach detected!");
    }
}
