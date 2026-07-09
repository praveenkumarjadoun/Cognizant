package adapter;

public class PayPalAdapter implements PaymentProcessor {
    private PayPalGateway payPalGateway;

    public PayPalAdapter(PayPalGateway payPalGateway) {
        this.payPalGateway = payPalGateway;
    }

    @Override
    public void processPayment(double amount) {
        // Translates target interface processPayment to adaptee-specific makePayment
        payPalGateway.makePayment(amount);
    }
}
