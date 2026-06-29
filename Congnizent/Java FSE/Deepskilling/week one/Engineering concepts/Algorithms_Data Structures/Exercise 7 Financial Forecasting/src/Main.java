package forecasting;

public class Main {
    public static void main(String[] args) {
        double presentValue = 1000.0; // Initial Investment
        double growthRate = 0.05;     // 5% growth rate
        int periods = 10;             // 10 years

        System.out.println("Present Value: $" + presentValue);
        System.out.println("Annual Growth Rate: " + (growthRate * 100) + "%");
        System.out.println("Periods (Years): " + periods);

        double futureValue = FinancialForecasting.calculateFutureValue(presentValue, growthRate, periods);
        System.out.printf("\nCalculated Future Value (Recursive): $%.2f\n", futureValue);

        // Verification using iterative math calculation: PV * Math.pow(1 + r, n)
        double checkValue = presentValue * Math.pow(1 + growthRate, periods);
        System.out.printf("Verification Value (Formula):       $%.2f\n", checkValue);
    }
}
