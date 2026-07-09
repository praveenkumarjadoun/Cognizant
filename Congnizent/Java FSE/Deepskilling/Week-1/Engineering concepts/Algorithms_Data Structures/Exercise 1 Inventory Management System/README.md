# Exercise 1: Inventory Management System

## 1. Understanding the Problem

### Why Data Structures and Algorithms are Essential
In handling large-scale warehouses with thousands or millions of products, inefficient data management leads to significant lag and increased costs. Properly chosen data structures and algorithms ensure:
- **Fast Lookup**: Searching for items, checking stock levels, or verifying prices can be done in near constant time.
- **Resource Optimization**: Minimal RAM utilization, which reduces operational costs.
- **Scalability**: System responsiveness remains consistent as the catalog size scales up.

### Suitable Data Structures
- **ArrayList / Array**: Simple sequential structure. Good for iteration, but search, update, and delete take $O(N)$ because of sequential scanning and shifting.
- **LinkedList**: Insertion and deletion are fast once the node is located. However, locating a node takes $O(N)$ time.
- **HashMap (Chosen)**: Key-value mapping where the unique `productId` maps to the `Product` object. Offers $O(1)$ average time complexity for insertions, deletions, and lookup.

---

## 2. Setup & Implementation
The solution contains:
- `Product.java`: The core model.
- `Inventory.java`: The manager using `java.util.HashMap` for storing and managing products.
- `Main.java`: Testing harness to execute methods.

---

## 3. Complexity & Performance Analysis

### Time Complexity Analysis

| Operation | Chosen Data Structure (`HashMap`) | Alternative (`ArrayList`) |
| :--- | :--- | :--- |
| **Add** | $O(1)$ average | $O(1)$ amortized (adding to end) / $O(N)$ check for duplicates |
| **Update** | $O(1)$ average | $O(N)$ to search |
| **Delete** | $O(1)$ average | $O(N)$ to search and shift |

### Optimization & Implementation Discussion
- **Hashing Optimization**: To keep `HashMap` operations at $O(1)$, we must ensure that the hash function distributes keys evenly. Java's default `String.hashCode()` performs well, but we must also set an appropriate initial capacity and load factor (e.g., default `0.75`) to minimize collisions and rehashing costs.
- **Concurrency**: If the inventory is accessed concurrently by multiple worker threads, a synchronized collection or `ConcurrentHashMap` should be used instead of a standard `HashMap` to prevent race conditions.
