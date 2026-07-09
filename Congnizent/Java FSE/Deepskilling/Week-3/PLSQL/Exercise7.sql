-- Exercise 7: Packages

--------------------------------------------------------------------------------
-- Scenario 1: Group all customer-related procedures and functions into a package.
-- Question: Create a package CustomerManagement with procedures for adding a new customer, updating customer details, and a function to get customer balance.
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddNewCustomer(
        p_cust_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_dob IN DATE, 
        p_balance IN NUMBER
    );
    
    PROCEDURE UpdateCustomerDetails(
        p_cust_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_balance IN NUMBER
    );
    
    FUNCTION GetCustomerBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS
    PROCEDURE AddNewCustomer(
        p_cust_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_dob IN DATE, 
        p_balance IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
        VALUES (p_cust_id, p_name, p_dob, p_balance, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('CustomerManagement: Customer added successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error: Customer ID already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error: ' || SQLERRM);
    END AddNewCustomer;

    PROCEDURE UpdateCustomerDetails(
        p_cust_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_balance IN NUMBER
    ) IS
    BEGIN
        UPDATE Customers
        SET Name = p_name,
            Balance = p_balance,
            LastModified = SYSDATE
        WHERE CustomerID = p_cust_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Warning: Customer ID not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement: Customer details updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error: ' || SQLERRM);
    END UpdateCustomerDetails;

    FUNCTION GetCustomerBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER IS
        v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance FROM Customers WHERE CustomerID = p_cust_id;
        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetCustomerBalance;
END CustomerManagement;
/

/*
Output/Result:
Package CUSTOMERMANAGEMENT compiled
Package Body CUSTOMERMANAGEMENT compiled

-- Verification:
-- EXEC CustomerManagement.AddNewCustomer(4, 'David Beckham', TO_DATE('1975-05-02', 'YYYY-MM-DD'), 8500);
-- SELECT CustomerManagement.GetCustomerBalance(4) FROM DUAL;
-- Output: 8500
*/


--------------------------------------------------------------------------------
-- Scenario 2: Create a package to manage employee data.
-- Question: Write a package EmployeeManagement with procedures to hire new employees, update employee details, and a function to calculate annual salary.
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(
        p_emp_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_position IN VARCHAR2, 
        p_salary IN NUMBER, 
        p_department IN VARCHAR2, 
        p_hire_date IN DATE
    );
    
    PROCEDURE UpdateEmployeeDetails(
        p_emp_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_position IN VARCHAR2, 
        p_salary IN NUMBER, 
        p_department IN VARCHAR2
    );
    
    FUNCTION CalculateAnnualSalary(
        p_emp_id IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS
    PROCEDURE HireEmployee(
        p_emp_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_position IN VARCHAR2, 
        p_salary IN NUMBER, 
        p_department IN VARCHAR2, 
        p_hire_date IN DATE
    ) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_emp_id, p_name, p_position, p_salary, p_department, p_hire_date);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('EmployeeManagement: Employee hired successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error: Employee ID already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error: ' || SQLERRM);
    END HireEmployee;

    PROCEDURE UpdateEmployeeDetails(
        p_emp_id IN NUMBER, 
        p_name IN VARCHAR2, 
        p_position IN VARCHAR2, 
        p_salary IN NUMBER, 
        p_department IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Employees
        SET Name = p_name,
            Position = p_position,
            Salary = p_salary,
            Department = p_department
        WHERE EmployeeID = p_emp_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Warning: Employee ID not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement: Employee details updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error: ' || SQLERRM);
    END UpdateEmployeeDetails;

    FUNCTION CalculateAnnualSalary(
        p_emp_id IN NUMBER
    ) RETURN NUMBER IS
        v_salary NUMBER;
    BEGIN
        SELECT Salary INTO v_salary FROM Employees WHERE EmployeeID = p_emp_id;
        RETURN v_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END CalculateAnnualSalary;
END EmployeeManagement;
/

/*
Output/Result:
Package EMPLOYEEMANAGEMENT compiled
Package Body EMPLOYEEMANAGEMENT compiled

-- Verification:
-- SELECT EmployeeManagement.CalculateAnnualSalary(1) FROM DUAL;
-- Output: 8400000 (Monthly Salary * 12)
*/


--------------------------------------------------------------------------------
-- Scenario 3: Group all account-related operations into a package.
-- Question: Create a package AccountOperations with procedures for opening a new account, closing an account, and a function to get the total balance of a customer across all accounts.
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount(
        p_acc_id IN NUMBER, 
        p_cust_id IN NUMBER, 
        p_type IN VARCHAR2, 
        p_balance IN NUMBER
    );
    
    PROCEDURE CloseAccount(
        p_acc_id IN NUMBER
    );
    
    FUNCTION GetTotalBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS
    PROCEDURE OpenAccount(
        p_acc_id IN NUMBER, 
        p_cust_id IN NUMBER, 
        p_type IN VARCHAR2, 
        p_balance IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_acc_id, p_cust_id, p_type, p_balance, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('AccountOperations: Account opened successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: Account ID already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: ' || SQLERRM);
    END OpenAccount;

    PROCEDURE CloseAccount(
        p_acc_id IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Accounts WHERE AccountID = p_acc_id;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('AccountOperations Warning: Account ID not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('AccountOperations: Account closed successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: ' || SQLERRM);
    END CloseAccount;

    FUNCTION GetTotalBalance(
        p_cust_id IN NUMBER
    ) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT SUM(Balance) INTO v_total FROM Accounts WHERE CustomerID = p_cust_id;
        RETURN NVL(v_total, 0);
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END GetTotalBalance;
END AccountOperations;
/

/*
Output/Result:
Package ACCOUNTOPERATIONS compiled
Package Body ACCOUNTOPERATIONS compiled

-- Verification:
-- EXEC AccountOperations.OpenAccount(3, 1, 'Savings', 500);
-- SELECT AccountOperations.GetTotalBalance(1) FROM DUAL;
-- Output: 1500 (1000 + 500)
*/
