# Exercise 4: Employee Management System

## 1. Understanding Array Representation

### Array Memory Representation
An array is stored in contiguous (adjacent) blocks of computer memory. When an array is declared, a block of memory equal to `size * sizeof(element)` is allocated. 

### Advantages of Arrays
- **Random Access**: Because memory is contiguous, the address of any element at index $i$ can be calculated directly using $BaseAddress + i \times SizeOf(Element)$. This allows $O(1)$ direct access by index.
- **Cache Locality**: Elements are stored close to each other, resulting in higher cache hit rates and better performance when traversing linearly.
- **Space Efficiency**: No additional pointers are needed per element (unlike Linked Lists), saving memory overhead.

---

## 2. Complexity Analysis

### Time Complexity of Array Operations

| Operation | Time Complexity | Description |
| :--- | :--- | :--- |
| **Add** | $O(1)$ average / worst-case | Inserting at the end of the array is a direct index update if capacity remains. |
| **Search** | $O(N)$ worst-case | Linear scanning from beginning to end to find an employee by `employeeId`. |
| **Traverse** | $O(N)$ worst-case | Visiting and printing all active indices. |
| **Delete** | $O(N)$ worst-case | Deleting an element requires shifting subsequent elements left to keep the array contiguous. |

---

## 3. Limitations & Best Practices

### Limitations of Arrays
- **Fixed Size**: The array's capacity must be decided at the time of creation and cannot grow or shrink dynamically.
- **Costly Insertion/Deletion**: Modifying items in the middle requires shifting elements, which is expensive ($O(N)$).
- **Memory Inefficiency**: A large array might remain mostly empty, wasting pre-allocated contiguous memory.

### When to Use Arrays
- When the maximum number of items is known in advance.
- When random access (indexing) is the primary operation.
- When memory usage per node needs to be minimized (no pointer overhead).
