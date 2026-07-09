# Exercise 6: Proxy Pattern

## Scenario
Create an image viewer application that loads high-resolution images from a remote server. To save network bandwidth and speed up startup time, load images lazily (only when displayed) and cache them to avoid duplicate requests.

---

## 1. Design Concept

### Proxy Pattern
The **Proxy Pattern** is a structural design pattern that lets you provide a substitute or placeholder for another object. A proxy controls access to the original object, allowing you to perform something either before or after the request reaches the original object (e.g., lazy loading, security check, caching, logging).

- **Lazy Loading**: Instead of loading $50$ large image files on app start, the proxy holds placeholder references and loads them from the database/server only when requested.
- **Caching**: The proxy stores a reference to the loaded `RealImage` object. When requested again, the proxy serves the cached instance instead of making another network request.

---

## 2. Structure & Classes

- **`Image`** (Subject Interface): Defines `display()`.
- **`RealImage`** (Real Subject): Loads the image from the remote server (simulating network latency).
- **`ProxyImage`** (Proxy): Implements `Image`, manages the loading state, and holds the cache of `RealImage`.
