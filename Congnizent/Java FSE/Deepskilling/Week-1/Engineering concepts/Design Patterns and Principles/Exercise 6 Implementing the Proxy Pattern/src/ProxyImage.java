package proxy;

public class ProxyImage implements Image {
    private RealImage realImage;
    private String filename;

    public ProxyImage(String filename) {
        this.filename = filename;
    }

    @Override
    public void display() {
        // Lazy initialization and caching
        if (realImage == null) {
            realImage = new RealImage(filename);
        } else {
            System.out.println("Retrieved image '" + filename + "' from cache.");
        }
        realImage.display();
    }
}
