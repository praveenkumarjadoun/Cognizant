# Exercise 8: Strategy Pattern

## Scenario
Build a checkout payment system where different payment methods (e.g., Credit Card, PayPal) can be dynamically swapped at runtime depending on user selection.

---

## 1. Design Concept

### Strategy Pattern
The **Strategy Pattern** is a behavioral design pattern that lets you define a family of algorithms, put each of them into a separate class, and make their objects interchangeable.

- **Open/Closed Principle**: You can introduce new payment strategies (e.g., Crypto, Apple Pay) without modifying context or existing strategies.
- **Dynamic Selection**: The context's strategy reference is mutable, allowing runtime algorithm swaps.

---

## 2. Structure & Classes

- **`PaymentStrategy`** (Strategy Interface): Defines `pay(amount)`.
- **`CreditCardPayment` / `PayPalPayment`** (Concrete Strategies): Implement the strategy algorithms for respective channels.
- **`PaymentContext`** (Context): Maintains reference to a `PaymentStrategy` and delegates the execution calls.
