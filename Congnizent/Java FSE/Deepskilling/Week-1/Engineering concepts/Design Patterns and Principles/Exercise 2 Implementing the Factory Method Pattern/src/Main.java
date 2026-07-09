package factory;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Factory Method Pattern ---");

        // Factory for Word documents
        DocumentFactory wordFactory = new WordDocumentFactory();
        Document doc1 = wordFactory.createDocument();
        doc1.open();
        doc1.close();

        System.out.println();

        // Factory for PDF documents
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        Document doc2 = pdfFactory.createDocument();
        doc2.open();
        doc2.close();

        System.out.println();

        // Factory for Excel documents
        DocumentFactory excelFactory = new ExcelDocumentFactory();
        Document doc3 = excelFactory.createDocument();
        doc3.open();
        doc3.close();
    }
}
