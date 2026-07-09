package decorator;

public class SlackNotifierDecorator extends NotifierDecorator {
    public SlackNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String message) {
        super.send(message); // sends via wrapped channels
        sendSlack(message);
    }

    private void sendSlack(String message) {
        System.out.println("Sending Slack Message: " + message);
    }
}
