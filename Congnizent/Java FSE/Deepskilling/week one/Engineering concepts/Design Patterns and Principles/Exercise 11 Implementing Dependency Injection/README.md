# Exercise 11: Dependency Injection

## Scenario
Develop a customer management application where the `CustomerService` class needs to query database records via a repository. To avoid hardcoding concrete classes, use Constructor Dependency Injection.

---

## 1. Design Concept

### Dependency Injection
**Dependency Injection (DI)** is a pattern where an object receives other objects (dependencies) that it requires, rather than creating them itself internally. This is a manifestation of the **Dependency Inversion Principle** (high-level modules should depend on abstractions, not concrete implementations).

- **Loose Coupling**: `CustomerService` only depends on the `CustomerRepository` interface. The implementation can be swapped (e.g., SQL repository, mock repository, XML repository) without changing the service class.
- **Testability**: Makes unit testing extremely easy by allowing mock objects to be injected into the class.

---

## 2. Structure & Classes

- **`CustomerRepository`** (Interface): Defines data access contracts.
- **`CustomerRepositoryImpl`** (Concrete Implementation): Implements database query simulation.
- **`CustomerService`** (Service Class): Declares a constructor taking a `CustomerRepository` parameter, which is injected at creation.
