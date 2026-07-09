-- Exercise 4: Functions

--------------------------------------------------------------------------------
-- Scenario 1: Calculate the age of customers for eligibility checks.
-- Question: Write a function CalculateAge that takes a customer's date of birth as input and returns their age in years.
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob IN DATE
) RETURN NUMBER AS
    v_age NUMBER;
BEGIN
    IF p_dob IS NULL THEN
        RETURN NULL;
    END IF;
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END;
/

/*
Output/Result:
Function CALCULATEAGE compiled

-- Verification Execution:
-- SELECT CalculateAge(TO_DATE('1990-07-20', 'YYYY-MM-DD')) FROM DUAL;
-- Output: 36 (depending on the current year)
*/


--------------------------------------------------------------------------------
-- Scenario 2: The bank needs to compute the monthly installment for a loan.
-- Question: Write a function CalculateMonthlyInstallment that takes the loan amount, interest rate, and loan duration in years as input and returns the monthly installment amount.
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount IN NUMBER,
    p_interest_rate IN NUMBER,
    p_duration_years IN NUMBER
) RETURN NUMBER AS
    v_monthly_rate NUMBER;
    v_months NUMBER;
    v_installment NUMBER;
BEGIN
    IF p_loan_amount <= 0 OR p_duration_years <= 0 OR p_interest_rate < 0 THEN
        RETURN 0;
    END IF;

    -- Monthly rate (annual interest rate / 12 months / 100 percentage conversion)
    v_monthly_rate := p_interest_rate / 12 / 100;
    v_months := p_duration_years * 12;

    -- EMI formula: [P x r x (1+r)^N] / [(1+r)^N - 1]
    IF v_monthly_rate = 0 THEN
        v_installment := p_loan_amount / v_months;
    ELSE
        v_installment := (p_loan_amount * v_monthly_rate * POWER(1 + v_monthly_rate, v_months)) /
                         (POWER(1 + v_monthly_rate, v_months) - 1);
    END IF;

    RETURN ROUND(v_installment, 2);
END;
/

/*
Output/Result:
Function CALCULATEMONTHLYINSTALLMENT compiled

-- Verification Execution:
-- SELECT CalculateMonthlyInstallment(10000, 6, 2) FROM DUAL;
-- Output: 443.21 (Monthly EMI for $10k loan at 6% interest for 2 years)
*/


--------------------------------------------------------------------------------
-- Scenario 3: Check if a customer has sufficient balance before making a transaction.
-- Question: Write a function HasSufficientBalance that takes an account ID and an amount as input and returns a boolean indicating whether the account has at least the specified amount.
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,
    p_amount IN NUMBER
) RETURN BOOLEAN AS
    v_balance NUMBER;
BEGIN
    IF p_amount < 0 THEN
        RETURN FALSE;
    END IF;

    -- Retrieve current balance
    SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/

/*
Output/Result:
Function HASSUFFICIENTBALANCE compiled

-- Verification Block:
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := HasSufficientBalance(1, 500);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('HasSufficientBalance: True');
    ELSE
        DBMS_OUTPUT.PUT_LINE('HasSufficientBalance: False');
    END IF;
END;
/
-- Output: HasSufficientBalance: True
*/
