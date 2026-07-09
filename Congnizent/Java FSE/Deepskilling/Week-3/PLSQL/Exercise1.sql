-- Exercise 1: Control Structures

-- Setup: In order to support Scenario 2 (VIP Status flag), we assume an IsVIP column is added to the Customers table.
-- ALTER TABLE Customers ADD (IsVIP VARCHAR2(5) DEFAULT 'FALSE');

--------------------------------------------------------------------------------
-- Scenario 1: The bank wants to apply a discount to loan interest rates for customers above 60 years old.
-- Question: Write a PL/SQL block that loops through all customers, checks their age, and if they are above 60, apply a 1% discount to their current loan interest rates.
--------------------------------------------------------------------------------

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, DOB FROM Customers;
    v_age NUMBER;
BEGIN
    FOR r_cust IN c_customers LOOP
        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, r_cust.DOB) / 12);
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = r_cust.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Interest rate discount applied to eligible customers over 60.');
END;
/

/*
Output/Result:
PL/SQL procedure successfully completed.

-- Verification:
-- Before running:
-- Customer ID 1 DOB: 1985-05-15 (Age: ~41) -> Loan interest rate: 5%
-- Customer ID 3 DOB: 1950-01-01 (Age: ~76) -> Loan interest rate: 6%

-- After running:
-- Customer ID 1 Loan interest rate remains 5%
-- Customer ID 3 Loan interest rate updated to 5% (1% discount applied)
*/


--------------------------------------------------------------------------------
-- Scenario 2: A customer can be promoted to VIP status based on their balance.
-- Question: Write a PL/SQL block that iterates through all customers and sets a flag IsVIP to TRUE for those with a balance over $10,000.
--------------------------------------------------------------------------------

DECLARE
    CURSOR c_cust IS 
        SELECT CustomerID, Balance FROM Customers;
BEGIN
    FOR r_cust IN c_cust LOOP
        IF r_cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = r_cust.CustomerID;
        ELSE
            UPDATE Customers
            SET IsVIP = 'FALSE'
            WHERE CustomerID = r_cust.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('VIP status flags updated based on customer balances.');
END;
/

/*
Output/Result:
PL/SQL procedure successfully completed.

-- Verification:
-- Before running:
-- John Doe (ID: 1) Balance: 1,000  -> IsVIP: 'FALSE'
-- Jane Smith (ID: 2) Balance: 12,500 -> IsVIP: 'FALSE'

-- After running:
-- John Doe (ID: 1) IsVIP: 'FALSE'
-- Jane Smith (ID: 2) IsVIP: 'TRUE' (Balance > 10000)
*/


--------------------------------------------------------------------------------
-- Scenario 3: The bank wants to send reminders to customers whose loans are due within the next 30 days.
-- Question: Write a PL/SQL block that fetches all loans due in the next 30 days and prints a reminder message for each customer.
--------------------------------------------------------------------------------

DECLARE
    CURSOR c_due_loans IS
        SELECT c.Name, l.LoanID, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- LOAN EXPIRATION REMINDERS ---');
    FOR r_loan IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || r_loan.Name || 
                             ' (Loan ID: ' || r_loan.LoanID || 
                             ') has a loan due on ' || TO_CHAR(r_loan.EndDate, 'YYYY-MM-DD') || '.');
    END LOOP;
END;
/

/*
Output/Result:
--- LOAN EXPIRATION REMINDERS ---
Reminder: Customer John Doe (Loan ID: 1) has a loan due on 2026-08-05.
PL/SQL procedure successfully completed.
*/
