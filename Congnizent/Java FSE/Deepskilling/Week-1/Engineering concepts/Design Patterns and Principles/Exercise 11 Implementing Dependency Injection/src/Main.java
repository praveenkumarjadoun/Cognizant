package di;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Testing Dependency Injection ---");

        // 1. Create concrete dependency repository instance
        CustomerRepository repository = new CustomerRepositoryImpl();

        // 2. Inject dependency repository into CustomerService
        CustomerService service = new CustomerService(repository);

        // 3. Invoke methods on service
        String customer1 = service.getCustomerDetails(1);
        System.out.println("Querying Customer 1: " + customer1);

        String customer2 = service.getCustomerDetails(2);
        System.out.println("Querying Customer 2: " + customer2);

        String customerUnknown = service.getCustomerDetails(99);
        System.out.println("Querying Customer 99: " + customerUnknown);
    }
}
