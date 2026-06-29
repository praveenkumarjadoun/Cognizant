# Exercise 10: MVC Pattern

## Scenario
Create a simple student record management system containing Model, View, and Controller components to decouple data representation from the UI.

---

## 1. Design Concept

### MVC (Model-View-Controller) Pattern
The **MVC Pattern** is an architectural pattern that separates an application into three main logical components:

- **Model**: Represents the application data and business logic. It has no knowledge of the UI or view.
- **View**: Renders the Model data for the user. It is a stateless presentation layer.
- **Controller**: Intercepts user inputs, updates the Model, and tells the View to refresh. Decouples the Model and View layers.

---

## 2. Structure & Classes

- **`Student`** (Model): The raw record schema containing `id`, `name`, and `grade` attributes.
- **`StudentView`** (View): Handles rendering logic. Contains `displayStudentDetails()`.
- **`StudentController`** (Controller): Directs data flow, updates model values, and coordinates view updates.
