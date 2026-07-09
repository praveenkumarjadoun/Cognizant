# Exercise 9: Command Pattern

## Scenario
Build a home automation remote control unit that issues turn-on or turn-off commands to living room devices (e.g., Lights) without direct coupling between the remote buttons and the light's hardware logic.

---

## 1. Design Concept

### Command Pattern
The **Command Pattern** is a behavioral design pattern that turns a request into a stand-alone object that contains all information about the request. This transformation lets you pass requests as a method arguments, delay or queue a request's execution, and support undoable operations.

- **Decoupling**: The invoker (`RemoteControl`) only triggers `execute()`. It doesn't need to know *what* device is receiver, or *how* it turns on.
- **Extendable**: You can compose complex macro commands (e.g., PartyMode turning off lights and turning on music) easily by bundling lists of command objects.

---

## 2. Structure & Classes

- **`Command`** (Interface): Defines the standard execution interface `execute()`.
- **`LightOnCommand` / `LightOffCommand`** (Concrete Commands): Implement `Command` and delegate call execution to the receiver.
- **`Light`** (Receiver): Contains actual business logic to turn physical lights on or off.
- **`RemoteControl`** (Invoker): Holds reference to the command object and invokes it when the button is clicked.
