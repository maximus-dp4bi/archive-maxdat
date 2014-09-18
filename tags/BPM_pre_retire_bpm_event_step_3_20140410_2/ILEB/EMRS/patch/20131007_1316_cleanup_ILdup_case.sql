UPDATE emrs_d_case
SET date_of_validity_end = TO_DATE('02/16/2013','mm/dd/yyyy')
WHERE case_id = 6673973;

UPDATE emrs_d_case
SET current_flag = 'Y'
WHERE case_id = 6695978;

COMMIT;