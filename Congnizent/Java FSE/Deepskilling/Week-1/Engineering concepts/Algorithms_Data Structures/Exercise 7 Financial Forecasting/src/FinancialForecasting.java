package forecasting;

public class FinancialForecasting {

    /**
     * Calculates the future value recursively.
     * Formula: FV = PV * (1 + r)^n
     * Recursive relation: FV(n) = FV(n - 1) * (1 + r)
     * Base case: FV(0) = PV
     *
     * @param presentValue Current value
     * @param growthRate Growth rate as a decimal (e.g., 0.05 for 5%)
     * @param periods Number of periods (years/months)
     * @return Calculated future value
     */
    public static double calculateFutureValue(double presentValue, double growthRate, int periods) {
        // Base Case
        if (periods == 0) {
            return presentValue;
        }
        // Recursive Step
        return calculateFutureValue(presentValue, growthRate, periods - 1) * (1 + growthRate);
    }
}
