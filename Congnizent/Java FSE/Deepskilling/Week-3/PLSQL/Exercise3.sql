-- Exercise 3: Stored Procedures

--------------------------------------------------------------------------------
-- Scenario 1: The bank needs to process monthly interest for all savings accounts.
-- Question: Write a stored procedure ProcessMonthlyInterest that calculates and updates the balance of all savings accounts by applying an interest rate of 1% to the current balance.
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('ProcessMonthlyInterest: Successfully processed monthly interest of 1% for all Savings Accounts.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ProcessMonthlyInterest Error: ' || SQLERRM);
END;
/

/*
Output/Result:
Procedure PROCESSMONTHLYINTEREST compiled

-- Verification:
-- Before running:
-- Account ID 1 (Savings) Balance: 1000

-- After running (EXEC ProcessMonthlyInterest):
-- Account ID 1 (Savings) Balance: 1010
*/


--------------------------------------------------------------------------------
-- Scenario 2: The bank wants to implement a bonus scheme for employees based on their performance.
-- Question: Write a stored procedure UpdateEmployeeBonus that updates the salary of employees in a given department by adding a bonus percentage passed as a parameter.
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) AS
BEGIN
    IF p_bonus_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Bonus percentage cannot be negative.');
    END IF;

    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percentage / 100)
    WHERE Department = p_department;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('UpdateEmployeeBonus: Applied ' || p_bonus_percentage || '% bonus to employees in ' || p_department || ' department.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('UpdateEmployeeBonus Error: ' || SQLERRM);
END;
/

/*
Output/Result:
Procedure UPDATEEMPLOYEEBONUS compiled

-- Verification:
-- Before running:
-- Alice Johnson (HR) Salary: 70000

-- After running (EXEC UpdateEmployeeBonus('HR', 5)):
-- Alice Johnson (HR) Salary: 73500
*/


--------------------------------------------------------------------------------
-- Scenario 3: Customers should be able to transfer funds between their accounts.
-- Question: Write a stored procedure TransferFunds that transfers a specified amount from one account to another, checking that the source account has sufficient balance before making the transfer.
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_src_acc IN NUMBER,
    p_dest_acc IN NUMBER,
    p_amount IN NUMBER
) AS
    v_balance NUMBER;
BEGIN
    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Transfer amount must be positive.');
    END IF;

    -- Fetch and lock source balance
    SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_src_acc FOR UPDATE;

    -- Balance check
    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient balance in source account: ' || p_src_acc);
    END IF;

    -- Perform updates
    UPDATE Accounts SET Balance = Balance - p_amount, LastModified = SYSDATE WHERE AccountID = p_src_acc;
    UPDATE Accounts SET Balance = Balance + p_amount, LastModified = SYSDATE WHERE AccountID = p_dest_acc;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('TransferFunds: Successfully transferred $' || p_amount || ' from Account ' || p_src_acc || ' to Account ' || p_dest_acc);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('TransferFunds Error: Invalid source or destination account ID.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('TransferFunds Error: ' || SQLERRM);
END;
/

/*
Output/Result:
Procedure TRANSFERFUNDS compiled

-- Execution Example:
-- EXEC TransferFunds(2, 1, 300);
-- Output: TransferFunds: Successfully transferred $300 from Account 2 to Account 1
*/
