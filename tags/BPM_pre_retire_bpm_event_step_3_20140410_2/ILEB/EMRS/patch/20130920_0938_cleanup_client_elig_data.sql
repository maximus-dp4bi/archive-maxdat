DELETE FROM emrs_d_provider p
WHERE EXISTS(SELECT 1 FROM emrs_d_provider p1
             WHERE p.provider_number = p1.provider_number
             AND p.version = p1.version
             AND p.provider_id < p1.provider_id);

UPDATE emrs_d_client
SET date_of_validity_start = TRUNC(record_date)
WHERE date_of_validity_start IS NULL;

UPDATE emrs_d_client
SET date_of_validity_start = TO_DATE('01/01/1995','mm/dd/yyyy')
    ,date_of_validity_end =  TO_DATE('12/31/2050','mm/dd/yyyy')
WHERE client_id = 0;

truncate table emrs_d_client_plan_eligibility;

COMMIT;