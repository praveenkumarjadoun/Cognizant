# Exercise 5: Task Management System

## 1. Understanding Linked Lists

- **Singly Linked List**: Each node contains data and a pointer (`next`) to the subsequent node. It only allows forward traversal.
- **Doubly Linked List**: Each node contains data, a `next` pointer, and a `prev` pointer to the preceding node. Allows bidirectional traversal (forward and backward) and simplifies deletion when a node reference is already held, but incurs higher memory overhead.

---

## 2. Complexity Analysis

### Time Complexity of Singly Linked List Operations

| Operation | Time Complexity | Description |
| :--- | :--- | :--- |
| **Add (at end)** | $O(1)$ | Because we maintain a `tail` reference, appending does not require list traversal. |
| **Search** | $O(N)$ | Requires sequential traversal from the `head` to locate the task. |
| **Traverse** | $O(N)$ | Visiting and processing every node. |
| **Delete** | $O(N)$ | Requires locating the node and its predecessor to update pointers. |

---

## 3. Advantages of Linked Lists Over Arrays

For dynamic data management (where values are frequently inserted or deleted), Linked Lists are superior to Arrays:
1. **Dynamic Size**: Unlike arrays, linked lists do not have a fixed size. They grow and shrink at runtime without requiring expensive memory reallocation.
2. **Efficient Modifications**: Inserting or deleting nodes does not require shifting elements. Once the node location is known, pointer updates are $O(1)$.
3. **No Memory Wastage**: Memory is allocated only when new nodes are created, preventing the waste of pre-allocating large contiguous blocks.
