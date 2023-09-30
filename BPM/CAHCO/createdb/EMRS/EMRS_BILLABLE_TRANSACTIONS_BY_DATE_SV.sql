CREATE OR REPLACE VIEW EMRS_BILLABLE_TRANSACTIONS_BY_DATE_SV
AS
SELECT TRUNC(transaction_date) transaction_date
       ,TRUNC(meds_accept_date) meds_acceptance_date
       ,SUM(disenrollment_count) disenrollment_count
       ,SUM(eder_count) emergency_disenrollment_count
       ,SUM(enrollment_count) enrollment_count
       ,SUM(over_count) overcount_count
       ,SUM(transfer_count) transfer_count
FROM emrs_f_billable_transaction       
GROUP BY  TRUNC(transaction_date),TRUNC(meds_accept_date)
;

GRANT SELECT ON "EMRS_BILLABLE_TRANSACTIONS_BY_DATE_SV" TO "MAXDAT_READ_ONLY"; 
