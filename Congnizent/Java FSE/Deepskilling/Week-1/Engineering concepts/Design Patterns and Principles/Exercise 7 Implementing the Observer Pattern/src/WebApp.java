package observer;

public class WebApp implements Observer {
    private String name;

    public WebApp(String name) {
        this.name = name;
    }

    @Override
    public void update(String stockName, double price) {
        System.out.println("[Web Dashboard - " + name + "] Feed update: Stock " + stockName + " price is currently $" + price);
    }
}
