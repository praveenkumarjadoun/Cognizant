# Exercise 5: Decorator Pattern

## Scenario
Build a notification delivery engine where notifications are always sent via Email by default, but users can dynamically toggle or bundle other notification channels (e.g., SMS, Slack) at runtime without changing the original class design.

---

## 1. Design Concept

### Decorator Pattern
The **Decorator Pattern** is a structural design pattern that lets you attach new behaviors to objects dynamically by placing these objects inside special wrapper objects that contain the behaviors.

- **Composition over Inheritance**: Avoids class explosion. Instead of creating classes like `EmailAndSMSNotifier`, `EmailAndSlackNotifier`, and `EmailAndSMSAndSlackNotifier`, decorators can be nested at runtime to compose custom behavior.
- **Single Responsibility**: The notifier class handles sending, and decorators focus purely on the target medium extension.

---

## 2. Structure & Classes

- **`Notifier`** (Component Interface): Defines `send(message)`.
- **`EmailNotifier`** (Concrete Component): Core implementation sending the base email.
- **`NotifierDecorator`** (Abstract Decorator): Implements `Notifier` and maintains a delegate reference to another `Notifier`.
- **`SMSNotifierDecorator` / `SlackNotifierDecorator`** (Concrete Decorators): Extend `NotifierDecorator` to add additional channel actions.
