# Exercise 6: Library Management System

## 1. Complexity Comparison

### Time Complexity

| Algorithm | Best-Case | Average-Case | Worst-Case | Requires Sorted Data |
| :--- | :--- | :--- | :--- | :--- |
| **Linear Search** | $O(1)$ | $O(N)$ | $O(N)$ | No |
| **Binary Search** | $O(1)$ | $O(\log N)$ | $O(\log N)$ | Yes |

---

## 2. Suitability & Strategy Decisions

### When to Use Linear Search
- **Small Datasets**: If the library has only a few dozen books, the overhead of sorting the array ($O(N \log N)$) is higher than just running a simple linear scan.
- **Unsorted / High-Write Collections**: If books are frequently added and removed, sorting the array constantly becomes a bottleneck. In such environments, linear search might be acceptable if searches are infrequent.

### When to Use Binary Search
- **Large Datasets**: For catalogs containing thousands of books, binary search is essential, as scanning sequentially is far too slow.
- **Mostly Read-Only / Sorted Collections**: In libraries, the list of books is mostly static with infrequent additions. The collection can be sorted once (or maintained in a sorted order during insertion), making subsequent searches highly performant at $O(\log N)$.
