# Exercise 7: Observer Pattern

## Scenario
Create a stock market monitoring system where multiple clients (e.g., mobile apps, web dashboards) are notified dynamically of real-time price updates for active stocks.

---

## 1. Design Concept

### Observer Pattern
The **Observer Pattern** is a behavioral design pattern that defines a one-to-many dependency between objects, so that when one object (the subject) changes state, all its dependents (observers) are notified and updated automatically.

- **Loose Coupling**: The subject only knows that the observers implement a generic `Observer` interface. It does not need to know concrete class specifics.
- **Push Model**: The subject pushes state updates directly to observers, eliminating the need for observers to continuously poll for changes.

---

## 2. Structure & Classes

- **`Stock`** (Subject Interface): Defines registration, deregistration, and notification contracts.
- **`StockMarket`** (Concrete Subject): Maintains list of registered observers and pushes price notifications upon state changes.
- **`Observer`** (Observer Interface): Defines the callback contract `update(...)`.
- **`MobileApp` / `WebApp`** (Concrete Observers): Receive updates and handle customized rendering.
