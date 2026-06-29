package strategy;

public class PaymentContext {
    private PaymentStrategy paymentStrategy;

    // Allows changing strategy dynamically at runtime
    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void executePayment(double amount) {
        if (paymentStrategy == null) {
            System.out.println("Error: No payment strategy selected.");
        } else {
            paymentStrategy.pay(amount);
        }
    }
}
