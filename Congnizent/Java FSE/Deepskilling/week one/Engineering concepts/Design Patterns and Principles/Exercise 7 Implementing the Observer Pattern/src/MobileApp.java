package observer;

public class MobileApp implements Observer {
    private String name;

    public MobileApp(String name) {
        this.name = name;
    }

    @Override
    public void update(String stockName, double price) {
        System.out.println("[Mobile App - " + name + "] Notification: Stock " + stockName + " is now $" + price);
    }
}
