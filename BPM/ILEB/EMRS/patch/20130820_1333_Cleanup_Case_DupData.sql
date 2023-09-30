UPDATE emrs_d_case
SET mailing_address1 = '1104 WINDBROOKE DR APT 201', mailing_city = 'BUFFALO GROVE', mailing_state = 'IL',mailing_zip = '60089'
    ,case_search_element = 'MAN600',csda_code = 0,version = 2
    ,date_of_validity_start = TO_DATE('02/25/2013','mm/dd/yyyy'), current_flag = 'Y'
WHERE case_id = 11157750;


UPDATE emrs_d_case
SET mailing_address1 = '1425 GREENFIELD AVE', mailing_city = 'NORTH CHICAGO', mailing_state = 'IL',mailing_zip = '60064'
    ,case_search_element = 'FEI600',csda_code = 0,version = 2
    ,date_of_validity_start = TO_DATE('02/24/2013','mm/dd/yyyy'), current_flag = 'Y'
WHERE case_id = 11595307;


UPDATE emrs_d_case
SET mailing_address1 = '301 DEWEY AVE', mailing_city = 'NORMAL', mailing_state = 'IL',mailing_zip = '61761'
    ,case_search_element = 'MAY617',csda_code = 0,version = 2
    ,date_of_validity_start = TO_DATE('02/16/2013','mm/dd/yyyy'), current_flag = 'Y'
WHERE case_id = 11945090;

DELETE FROM emrs_d_case
WHERE case_id IN(11946773,11947195);

UPDATE emrs_d_case
SET mailing_address1 = '2831 N. MERRIMAC', mailing_city = 'CHICAGO', mailing_state = 'IL',mailing_zip = '60634'
    ,case_search_element = 'MAY617',csda_code = 0
    ,date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy'), current_flag = 'Y'
WHERE case_id = 10744986;

DELETE FROM corp_etl_job_statistics
WHERE job_name = 'ETL_Enrollment'
and job_status_cd = 'STARTED';

COMMIT;