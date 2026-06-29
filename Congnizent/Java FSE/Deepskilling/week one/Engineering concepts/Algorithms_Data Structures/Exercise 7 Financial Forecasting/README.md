# Exercise 7: Financial Forecasting

## 1. Understanding Recursive Algorithms

### Concept of Recursion
Recursion is a programming technique where a method calls itself to solve a smaller instance of the same problem. Every recursive function must contain two components:
1. **Base Case**: The termination condition that does not make a recursive call, preventing infinite execution.
2. **Recursive Step**: The part where the function calls itself with a modified input, gradually working towards the base case.

### How Recursion Simplifies Problems
Recursion naturally models problems with a tree-like structure, nested subproblems, or induction-based definitions (e.g., directory traversal, sorting algorithms like Quick/Merge Sort, Fibonacci, and compound interest calculations). It simplifies code by eliminating the need for complex state-tracking variables and loops.

---

## 2. Complexity Analysis

### Time Complexity
For $N$ periods, the function makes exactly $N$ recursive calls, each doing $O(1)$ constant-time math operations.
- **Time Complexity**: $O(N)$
- **Space Complexity**: $O(N)$ (due to the recursive call stack frames)

### Limitations
If $N$ (periods) is very large (e.g., $10,000$), the system may encounter a `StackOverflowError` because each recursive call adds a frame to the execution stack, which has a limited size.

---

## 3. Optimization Techniques

### 1. Iterative Approach (Loop)
We can convert the recursive function into a simple loop. This keeps the time complexity at $O(N)$ but reduces space complexity to $O(1)$ by eliminating call stack usage.

```java
public static double calculateFutureValueIterative(double presentValue, double growthRate, int periods) {
    double futureValue = presentValue;
    for (int i = 0; i < periods; i++) {
        futureValue *= (1 + growthRate);
    }
    return futureValue;
}
```

### 2. Memoization
For recursive algorithms with overlapping subproblems (like Fibonacci calculation, though not present in this basic linear growth rate case), caching results of past function calls in a map/array (memoization) reduces exponential time complexities (e.g., $O(2^N)$) to linear ($O(N)$).

### 3. Direct Mathematical Formula
For financial growth, we can calculate the value directly in $O(\log N)$ or $O(1)$ using the formula:
$$FV = PV \times (1 + r)^n$$
Which translates in Java to: `presentValue * Math.pow(1 + growthRate, periods)`.
This is the most efficient and robust solution for this specific problem.
