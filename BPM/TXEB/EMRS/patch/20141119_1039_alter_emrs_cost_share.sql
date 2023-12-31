ALTER TABLE EMRS_S_COST_SHARE_STG
ADD (CAP_MET_AMOUNT	NUMBER,
fee_status_date         DATE,
fee_status              VARCHAR2(10),
last_payment_date       DATE,
PLAN_NOTIFIED_DATE	DATE,
TOTAL_EXPENSE_AMOUNT	NUMBER);

ALTER TABLE EMRS_F_ENROLLMENT
ADD (CAP_MET_AMOUNT	NUMBER,
fee_status_date         DATE,
fee_status              VARCHAR2(10),
last_payment_date       DATE,
PLAN_NOTIFIED_DATE	DATE,
TOTAL_EXPENSE_AMOUNT	NUMBER);

ALTER TABLE EMRS_S_ENROLLMENT_STG
ADD (CAP_MET_AMOUNT	NUMBER,
fee_status_date         DATE,
fee_status              VARCHAR2(10),
last_payment_date       DATE,
PLAN_NOTIFIED_DATE	DATE,
TOTAL_EXPENSE_AMOUNT	NUMBER);