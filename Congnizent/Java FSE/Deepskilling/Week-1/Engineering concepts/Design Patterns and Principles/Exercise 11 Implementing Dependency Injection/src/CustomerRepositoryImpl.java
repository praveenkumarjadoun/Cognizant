package di;

public class CustomerRepositoryImpl implements CustomerRepository {
    @Override
    public String findCustomerById(int id) {
        // Simulating data access
        if (id == 1) {
            return "Customer: John Doe (email: john@example.com)";
        } else if (id == 2) {
            return "Customer: Jane Smith (email: jane@example.com)";
        }
        return "Customer not found.";
    }
}
