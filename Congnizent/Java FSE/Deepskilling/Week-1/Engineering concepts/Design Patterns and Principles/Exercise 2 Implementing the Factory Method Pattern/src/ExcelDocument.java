package factory;

public class ExcelDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Excel spreadsheet...");
    }

    @Override
    public void close() {
        System.out.println("Closing Excel spreadsheet.");
    }
}
