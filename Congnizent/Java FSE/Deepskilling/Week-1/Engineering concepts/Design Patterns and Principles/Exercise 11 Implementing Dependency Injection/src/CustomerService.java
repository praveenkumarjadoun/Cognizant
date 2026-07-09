package di;

public class CustomerService {
    private final CustomerRepository customerRepository;

    // Constructor injection: Repository instance is injected at creation
    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public String getCustomerDetails(int id) {
        return customerRepository.findCustomerById(id);
    }
}
