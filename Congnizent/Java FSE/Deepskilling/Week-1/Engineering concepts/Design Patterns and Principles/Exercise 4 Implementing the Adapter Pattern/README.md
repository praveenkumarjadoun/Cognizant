# Exercise 4: Adapter Pattern

## Scenario
Integrate an application with multiple third-party payment gateways (e.g., PayPal, Stripe) that offer different method signatures (`makePayment()` vs `charge()`) using a single uniform target interface (`PaymentProcessor.processPayment()`).

---

## 1. Design Concept

### Adapter Pattern
The **Adapter Pattern** is a structural design pattern that allows objects with incompatible interfaces to collaborate. It acts as a wrapper (or translator) between the client application and a third-party or legacy class, converting calls to the target interface into calls understood by the adaptee.

---

## 2. Structure & Components

- **`PaymentProcessor`** (Target Interface): The uniform interface used by the client application (`processPayment()`).
- **`PayPalGateway` / `StripeGateway`** (Adaptees): Incompatible third-party APIs containing varying signatures (`makePayment()` and `charge()`).
- **`PayPalAdapter` / `StripeAdapter`** (Adapters): Wrapper classes that implement `PaymentProcessor` and forward the payment processing requests to their respective SDK gateways.
