package proxy;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Proxy Pattern ---");

        Image image1 = new ProxyImage("nature_photo_highres.png");
        Image image2 = new ProxyImage("space_nebula_4k.png");

        System.out.println("Proxy images created. No load operations should have executed yet.\n");

        // First display: triggers remote server load
        System.out.println("--> Calling display() on image1 for the first time:");
        image1.display();

        System.out.println();

        // Second display: retrieved directly from proxy's cache
        System.out.println("--> Calling display() on image1 for the second time:");
        image1.display();

        System.out.println("\n-------------------------------------------------\n");

        // Display image2 for the first time
        System.out.println("--> Calling display() on image2 for the first time:");
        image2.display();
    }
}
