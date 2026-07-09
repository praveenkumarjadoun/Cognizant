# Exercise 2: E-commerce Platform Search Function

## 1. Understanding Asymptotic Notation

### Big O Notation
Big O notation mathematically describes the upper bound of an algorithm's running time or space requirements in the worst-case scenario as the input size ($N$) grows toward infinity. It abstracts hardware details and compiler optimizations, allowing developers to focus purely on algorithmic efficiency.

### Best, Average, and Worst-Case Scenarios
- **Best-Case ($\Omega$)**: The minimum resources required. For example, finding the target element on the very first try (index 0).
- **Average-Case ($\Theta$)**: The expected resource usage over all typical inputs. Usually represents the average steps taken.
- **Worst-Case ($O$)**: The maximum resources required. For search algorithms, this corresponds to when the target element is at the very end of the collection or not present at all.

---

## 2. Complexity Analysis

### Time Complexity Comparison

| Algorithm | Best-Case | Average-Case | Worst-Case | Space Complexity |
| :--- | :--- | :--- | :--- | :--- |
| **Linear Search** | $O(1)$ | $O(N)$ | $O(N)$ | $O(1)$ |
| **Binary Search** | $O(1)$ | $O(\log N)$ | $O(\log N)$ | $O(1)$ |

---

## 3. Discussion & Suitability

### Which Algorithm is More Suitable?
For an e-commerce platform search engine, **Binary Search** (or indexed lookup mechanisms based on search trees/hash indices) is significantly more suitable. 

- **Why**: As the platform grows to catalog thousands or millions of products, Linear Search ($O(N)$) will suffer heavy performance degradation. For $1,000,000$ products, linear search might take up to $1,000,000$ operations. Binary search, however, will take a maximum of $\log_2(1,000,000) \approx 20$ operations.
- **Caveat**: Binary search requires the array to be sorted. In systems where items are updated frequently, keeping the collection sorted can add cost. However, in e-commerce search, products are read much more frequently than they are inserted/deleted, making the initial sorting cost highly beneficial.
