-- Exercise 2: Error Handling

--------------------------------------------------------------------------------
-- Scenario 1: Handle exceptions during fund transfers between accounts.
-- Question: Write a stored procedure SafeTransferFunds that transfers funds between two accounts. Ensure that if any error occurs (e.g., insufficient funds), an appropriate error message is logged and the transaction is rolled back.
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_src_acc_id IN NUMBER,
    p_dest_acc_id IN NUMBER,
    p_amount IN NUMBER
) AS
    v_src_bal NUMBER;
    v_dest_exists NUMBER;
    v_txn_id NUMBER;
    insufficient_funds EXCEPTION;
    invalid_amount EXCEPTION;
    account_not_found EXCEPTION;
BEGIN
    -- Validate amount
    IF p_amount <= 0 THEN
        RAISE invalid_amount;
    END IF;

    -- Check source account existence and balance
    BEGIN
        SELECT Balance INTO v_src_bal FROM Accounts WHERE AccountID = p_src_acc_id FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE account_not_found;
    END;

    -- Check destination account existence
    SELECT COUNT(*) INTO v_dest_exists FROM Accounts WHERE AccountID = p_dest_acc_id;
    IF v_dest_exists = 0 THEN
        RAISE account_not_found;
    END IF;

    -- Check for sufficient funds
    IF v_src_bal < p_amount THEN
        RAISE insufficient_funds;
    END IF;

    -- Perform transfer
    UPDATE Accounts SET Balance = Balance - p_amount, LastModified = SYSDATE WHERE AccountID = p_src_acc_id;
    UPDATE Accounts SET Balance = Balance + p_amount, LastModified = SYSDATE WHERE AccountID = p_dest_acc_id;

    -- Generate transaction ID
    SELECT NVL(MAX(TransactionID), 0) + 1 INTO v_txn_id FROM Transactions;

    -- Log transaction
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (v_txn_id, p_src_acc_id, SYSDATE, p_amount, 'Transfer');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SafeTransferFunds: Success. Transferred $' || p_amount || ' from Account ' || p_src_acc_id || ' to Account ' || p_dest_acc_id);

EXCEPTION
    WHEN insufficient_funds THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('SafeTransferFunds Error: Insufficient funds in Account ' || p_src_acc_id);
    WHEN invalid_amount THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('SafeTransferFunds Error: Transfer amount must be positive.');
    WHEN account_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('SafeTransferFunds Error: One or both Account IDs do not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('SafeTransferFunds Error: Unexpected system error: ' || SQLERRM);
END;
/

/*
Output/Result:
Procedure SAFETRANSFERFUNDS compiled

-- Execution Example 1 (Success):
-- EXEC SafeTransferFunds(1, 2, 200);
-- Output: SafeTransferFunds: Success. Transferred $200 from Account 1 to Account 2

-- Execution Example 2 (Insufficient Funds Exception):
-- EXEC SafeTransferFunds(1, 2, 5000);
-- Output: SafeTransferFunds Error: Insufficient funds in Account 1

-- Execution Example 3 (Account Not Found Exception):
-- EXEC SafeTransferFunds(99, 2, 100);
-- Output: SafeTransferFunds Error: One or both Account IDs do not exist.
*/


--------------------------------------------------------------------------------
-- Scenario 2: Manage errors when updating employee salaries.
-- Question: Write a stored procedure UpdateSalary that increases the salary of an employee by a given percentage. If the employee ID does not exist, handle the exception and log an error message.
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_emp_id IN NUMBER,
    p_percentage IN NUMBER
) AS
    v_emp_exists NUMBER;
    emp_not_found EXCEPTION;
BEGIN
    -- Check if employee exists
    SELECT COUNT(*) INTO v_emp_exists FROM Employees WHERE EmployeeID = p_emp_id;
    IF v_emp_exists = 0 THEN
        RAISE emp_not_found;
    END IF;

    -- Update salary
    UPDATE Employees
    SET Salary = Salary * (1 + p_percentage / 100)
    WHERE EmployeeID = p_emp_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('UpdateSalary: Salary successfully updated for Employee ID ' || p_emp_id);

EXCEPTION
    WHEN emp_not_found THEN
        DBMS_OUTPUT.PUT_LINE('UpdateSalary Error: Employee ID ' || p_emp_id || ' does not exist in the database.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('UpdateSalary Error: Unexpected system error: ' || SQLERRM);
END;
/

/*
Output/Result:
Procedure UPDATESALARY compiled

-- Execution Example 1 (Success):
-- EXEC UpdateSalary(1, 10);
-- Output: UpdateSalary: Salary successfully updated for Employee ID 1

-- Execution Example 2 (Employee Not Found):
-- EXEC UpdateSalary(999, 10);
-- Output: UpdateSalary Error: Employee ID 999 does not exist in the database.
*/


--------------------------------------------------------------------------------
-- Scenario 3: Ensure data integrity when adding a new customer.
-- Question: Write a stored procedure AddNewCustomer that inserts a new customer into the Customers table. If a customer with the same ID already exists, handle the exception by logging an error and preventing the insertion.
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_cust_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER
) AS
BEGIN
    -- Attempt Insertion
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_cust_id, p_name, p_dob, p_balance, SYSDATE);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('AddNewCustomer: Customer ID ' || p_cust_id || ' added successfully.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('AddNewCustomer Error: Customer with ID ' || p_cust_id || ' already exists. Insertion aborted.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('AddNewCustomer Error: Unexpected system error: ' || SQLERRM);
END;
/

/*
Output/Result:
Procedure ADDNEWCUSTOMER compiled

-- Execution Example 1 (Success):
-- EXEC AddNewCustomer(3, 'Charlie Green', TO_DATE('1995-10-10', 'YYYY-MM-DD'), 2500);
-- Output: AddNewCustomer: Customer ID 3 added successfully.

-- Execution Example 2 (Duplicate ID Exception):
-- EXEC AddNewCustomer(1, 'Duplicate John', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000);
-- Output: AddNewCustomer Error: Customer with ID 1 already exists. Insertion aborted.
*/
