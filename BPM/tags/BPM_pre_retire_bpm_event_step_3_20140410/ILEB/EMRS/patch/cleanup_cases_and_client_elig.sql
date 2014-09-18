UPDATE emrs_d_case c1 
SET date_of_validity_end = to_date('12/31/2050','mm/dd/yyyy')
WHERE NOT EXISTS(SELECT 1 FROM emrs_d_case c2 WHERE c1.case_number = c2.case_number AND trunc(c2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy'));

UPDATE emrs_d_case
SET version = 2
WHERE case_id = 12428219;

UPDATE emrs_d_case
SET version = 2
WHERE case_id = 12741725;

DELETE FROM emrs_d_client_plan_eligibility
WHERE client_number = 0
AND client_plan_eligibility_id != 0;

COMMIT;