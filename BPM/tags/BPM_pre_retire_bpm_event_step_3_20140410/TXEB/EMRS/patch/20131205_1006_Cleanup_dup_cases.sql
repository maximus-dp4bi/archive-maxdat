UPDATE emrs_d_case
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE case_id = 14271760;

UPDATE emrs_d_case
SET version = 3
WHERE case_id = 14359014;

UPDATE emrs_d_case
SET version = 5
WHERE case_id = 14500537;

UPDATE emrs_d_case
SET date_of_validity_end = date_of_validity_start, current_flag = 'N',version = 4
WHERE case_id = 14463480;

UPDATE emrs_d_case
SET current_case_id = 14500537
WHERE case_number = 7412890;

UPDATE emrs_d_case
SET date_of_validity_end = date_of_validity_start, current_flag = 'N'
WHERE case_id = 14625775;

UPDATE emrs_d_case
SET version = 3
WHERE case_id = 14631286;

UPDATE emrs_d_case
SET version = 4
WHERE case_id = 15003876;

UPDATE emrs_d_case
SET date_of_validity_end = TO_DATE('11/15/2013','mm/dd/yyyy'),
   date_of_validity_start = TO_DATE('11/15/2013','mm/dd/yyyy'),
   current_flag = 'N',
   version = 5
WHERE case_id =14937511;

UPDATE emrs_d_case
SET date_of_validity_end = date_of_validity_start, current_flag = 'N',version = 6
WHERE case_id =15237368;

UPDATE emrs_d_case
SET version = 7
WHERE case_id =15218051;

UPDATE emrs_d_case
SET current_case_id = 15218051
WHERE case_number = 7761313;

COMMIT;