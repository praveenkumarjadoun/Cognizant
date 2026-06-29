package strategy;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Strategy Pattern ---");

        PaymentContext context = new PaymentContext();

        // 1. Pay using Credit Card
        System.out.println("Selecting Credit Card Strategy:");
        PaymentStrategy creditCard = new CreditCardPayment("John Doe", "1234567890123456", "123", "12/28");
        context.setPaymentStrategy(creditCard);
        context.executePayment(500.00);

        System.out.println();

        // 2. Pay using PayPal
        System.out.println("Selecting PayPal Strategy:");
        PaymentStrategy payPal = new PayPalPayment("john.doe@example.com", "mysecretpassword");
        context.setPaymentStrategy(payPal);
        context.executePayment(250.75);
    }
}
