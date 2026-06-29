package adapter;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Adapter Pattern ---");

        // Integrate third-party PayPal gateway through its adapter
        PayPalGateway payPalGateway = new PayPalGateway();
        PaymentProcessor payPalProcessor = new PayPalAdapter(payPalGateway);
        
        System.out.println("Using PayPal adapter:");
        payPalProcessor.processPayment(150.00);

        System.out.println();

        // Integrate third-party Stripe gateway through its adapter
        StripeGateway stripeGateway = new StripeGateway();
        PaymentProcessor stripeProcessor = new StripeAdapter(stripeGateway);

        System.out.println("Using Stripe adapter:");
        stripeProcessor.processPayment(275.50);
    }
}
