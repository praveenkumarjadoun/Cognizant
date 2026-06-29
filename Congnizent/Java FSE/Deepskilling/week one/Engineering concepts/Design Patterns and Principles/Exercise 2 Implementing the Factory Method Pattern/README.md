# Exercise 2: Factory Method Pattern

## Scenario
Develop a document management system that creates different types of documents (e.g., Word, PDF, Excel) without tight coupling between the client application and concrete document classes.

---

## 1. Design Concept

### Factory Method Pattern
The **Factory Method Pattern** defines an interface for creating an object, but lets subclasses decide which class to instantiate. This decouples the client from concrete implementations, supporting the **Open/Closed Principle** (adding new document types only requires adding new document and factory classes, without modifying existing client code).

---

## 2. Structure & Classes

- **`Document`** (Interface): Defines `open()` and `close()` operations.
- **`WordDocument` / `PdfDocument` / `ExcelDocument`** (Concrete Classes): Implement the `Document` interface.
- **`DocumentFactory`** (Abstract Class): Declares the factory method `createDocument()`.
- **`WordDocumentFactory` / `PdfDocumentFactory` / `ExcelDocumentFactory`** (Concrete Factories): Extend `DocumentFactory` to return corresponding concrete document objects.
