package builder;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Builder Pattern ---");

        // Basic computer (only required fields, others are default)
        Computer officePC = new Computer.Builder("Intel i3", "8GB RAM").build();
        System.out.println("Office PC: " + officePC);

        // Gaming computer (customizing optional fields)
        Computer gamingPC = new Computer.Builder("AMD Ryzen 9", "32GB RAM")
                .setStorage("2TB NVMe SSD")
                .setGraphicsCardEnabled(true)
                .setBluetoothEnabled(true)
                .build();
        System.out.println("Gaming PC: " + gamingPC);

        // Developer computer (customizing some optional fields)
        Computer devLaptop = new Computer.Builder("Apple M2 Pro", "16GB RAM")
                .setStorage("512GB SSD")
                .setBluetoothEnabled(true)
                .build();
        System.out.println("Developer Laptop: " + devLaptop);
    }
}
