-- Exercise 6: Cursors

--------------------------------------------------------------------------------
-- Scenario 1: Generate monthly statements for all customers.
-- Question: Write a PL/SQL block using an explicit cursor GenerateMonthlyStatements that retrieves all transactions for the current month and prints a statement for each customer.
--------------------------------------------------------------------------------

DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT c.Name, a.AccountID, t.TransactionID, t.TransactionDate, t.Amount, t.TransactionType
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE t.TransactionDate >= TRUNC(SYSDATE, 'MM') 
          AND t.TransactionDate < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1);

    r_statement GenerateMonthlyStatements%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- MONTHLY STATEMENTS FOR CURRENT MONTH ---');
    OPEN GenerateMonthlyStatements;
    LOOP
        FETCH GenerateMonthlyStatements INTO r_statement;
        EXIT WHEN GenerateMonthlyStatements%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Customer: ' || r_statement.Name || 
                             ' | Account: ' || r_statement.AccountID || 
                             ' | Txn ID: ' || r_statement.TransactionID || 
                             ' | Date: ' || TO_CHAR(r_statement.TransactionDate, 'YYYY-MM-DD') || 
                             ' | Type: ' || r_statement.TransactionType || 
                             ' | Amount: $' || r_statement.Amount);
    END LOOP;
    CLOSE GenerateMonthlyStatements;
END;
/

/*
Output/Result:
--- MONTHLY STATEMENTS FOR CURRENT MONTH ---
Customer: John Doe | Account: 1 | Txn ID: 1 | Date: 2026-07-09 | Type: Deposit | Amount: $200
Customer: Jane Smith | Account: 2 | Txn ID: 2 | Date: 2026-07-09 | Type: Withdrawal | Amount: $300
PL/SQL procedure successfully completed.
*/


--------------------------------------------------------------------------------
-- Scenario 2: Apply annual fee to all accounts.
-- Question: Write a PL/SQL block using an explicit cursor ApplyAnnualFee that deducts an annual maintenance fee from the balance of all accounts.
--------------------------------------------------------------------------------

DECLARE
    v_fee CONSTANT NUMBER := 25.00; -- Fee amount
    CURSOR ApplyAnnualFee IS
        SELECT AccountID, Balance FROM Accounts FOR UPDATE OF Balance;
        
    r_account ApplyAnnualFee%ROWTYPE;
BEGIN
    OPEN ApplyAnnualFee;
    LOOP
        FETCH ApplyAnnualFee INTO r_account;
        EXIT WHEN ApplyAnnualFee%NOTFOUND;
        
        UPDATE Accounts
        SET Balance = Balance - v_fee,
            LastModified = SYSDATE
        WHERE CURRENT OF ApplyAnnualFee;
    END LOOP;
    CLOSE ApplyAnnualFee;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Annual maintenance fee of $' || v_fee || ' applied to all accounts.');
END;
/

/*
Output/Result:
Annual maintenance fee of $25 applied to all accounts.
PL/SQL procedure successfully completed.

-- Verification:
-- Before running: Account 1 Balance = 1000
-- After running: Account 1 Balance = 975
*/


--------------------------------------------------------------------------------
-- Scenario 3: Update the interest rate for all loans based on a new policy.
-- Question: Write a PL/SQL block using an explicit cursor UpdateLoanInterestRates that fetches all loans and updates their interest rates based on the new policy.
--------------------------------------------------------------------------------

DECLARE
    -- Scenario: Under the new monetary policy, all loan interest rates are adjusted upwards by 0.25%
    v_rate_adjustment CONSTANT NUMBER := 0.25;
    
    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, InterestRate FROM Loans FOR UPDATE OF InterestRate;
        
    r_loan UpdateLoanInterestRates%ROWTYPE;
BEGIN
    OPEN UpdateLoanInterestRates;
    LOOP
        FETCH UpdateLoanInterestRates INTO r_loan;
        EXIT WHEN UpdateLoanInterestRates%NOTFOUND;
        
        UPDATE Loans
        SET InterestRate = InterestRate + v_rate_adjustment
        WHERE CURRENT OF UpdateLoanInterestRates;
    END LOOP;
    CLOSE UpdateLoanInterestRates;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Loan interest rates updated successfully by ' || v_rate_adjustment || '%');
END;
/

/*
Output/Result:
Loan interest rates updated successfully by 0.25%
PL/SQL procedure successfully completed.

-- Verification:
-- Before running: Loan ID 1 InterestRate = 5%
-- After running: Loan ID 1 InterestRate = 5.25%
*/
