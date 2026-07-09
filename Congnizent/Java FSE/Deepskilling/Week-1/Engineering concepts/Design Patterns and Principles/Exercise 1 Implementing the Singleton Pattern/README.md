# Exercise 1: Singleton Pattern

## Scenario
Ensure that a logging utility class in an application has only one instance throughout the application lifecycle to ensure consistent logging.

---

## 1. Design Concept

### Singleton Pattern
The **Singleton Pattern** restricts the instantiation of a class to one single instance and provides a global point of access to it. It is useful when exactly one object is needed to coordinate actions across the system (e.g., database connections, logging, configuration caches).

---

## 2. Implementation Steps

1. **Private Constructor**: Prevents outer code from calling `new Logger()`.
2. **Private Static Reference**: Holds the single initialized instance.
3. **Public Static Getter (`getInstance()`)**: Returns the single instance, performing lazy-initialization when first requested. The method is marked `synchronized` to handle multi-threaded environments safely.
