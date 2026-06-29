# Exercise 3: Sorting Customer Orders

## 1. Understanding Sorting Algorithms

- **Bubble Sort**: A simple comparison-based algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. It continues until no swaps are needed.
- **Insertion Sort**: Builds the final sorted array one item at a time. It takes each element from the unsorted part and inserts it into its correct position within the sorted part. Highly efficient for small or nearly-sorted datasets.
- **Quick Sort**: A divide-and-conquer algorithm that selects a "pivot" element, partitions the array into elements smaller and larger than the pivot, and recursively sorts the sub-arrays. It is an in-place sort, meaning it does not require significant auxiliary memory.
- **Merge Sort**: A divide-and-conquer algorithm that splits the array in half, recursively sorts each half, and then merges the sorted halves together. It is a stable sort with guaranteed time complexity, but requires $O(N)$ extra space.

---

## 2. Performance Comparison

### Time and Space Complexity

| Algorithm | Best-Case | Average-Case | Worst-Case | Space Complexity |
| :--- | :--- | :--- | :--- | :--- |
| **Bubble Sort** | $O(N)$ (optimized) | $O(N^2)$ | $O(N^2)$ | $O(1)$ |
| **Quick Sort** | $O(N \log N)$ | $O(N \log N)$ | $O(N^2)$ (rare) | $O(\log N)$ (call stack) |

---

## 3. Discussion & Preference

### Why Quick Sort is Generally Preferred Over Bubble Sort
1. **Speed & Scalability**: Bubble Sort's average and worst-case complexity is quadratic ($O(N^2)$). As the number of orders increases from $1,000$ to $100,000$, Bubble Sort jumps from $1,000,000$ comparisons to $10,000,000,000$. Quick Sort's average-case of $O(N \log N)$ stays around $1,600,000$ operations, which is orders of magnitude faster.
2. **Cache Friendliness**: Quick Sort shows excellent locality of reference, meaning it performs very well with standard CPU caching mechanisms compared to other algorithms like Merge Sort.
3. **In-place Sorting**: Unlike Merge Sort, which requires a copy of the array, Quick Sort sorts in place with minimal auxiliary space.
