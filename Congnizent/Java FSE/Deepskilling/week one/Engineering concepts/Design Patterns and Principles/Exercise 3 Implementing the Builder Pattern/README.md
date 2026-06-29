# Exercise 3: Builder Pattern

## Scenario
Create complex objects (like a `Computer` with multiple optional parts like CPU, RAM, Storage, GraphicsCard, etc.) where constructor combinations could lead to telescoping constructor anti-patterns.

---

## 1. Design Concept

### Builder Pattern
The **Builder Pattern** is a creational design pattern that lets you construct complex objects step-by-step. The pattern allows you to produce different types and representations of an object using the same construction code.

- **Solves Telescoping Constructors**: Avoids having $10$ constructors with different optional fields.
- **Improves Readability**: Uses method-chaining (`setStorage("1TB").setGraphicsCardEnabled(true)`), which self-documents construction.
- **Immutability**: The target object can have all `final` fields and no setters, ensuring thread-safety.
