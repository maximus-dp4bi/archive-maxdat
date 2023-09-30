/*
Created by Raj A on 09/21/2016.
Description: MSSS-224 Populating the config tables per the document (MIMSS and MIMSSOCM)
out_var stores project_name. Ref_type stores program_name. 
*/
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES', 'IVR_APP_NAME','MAXMIMSS', 'MI MSS', 'MI MSS',
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
)
;

INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES', 'IVR_APP_NAME','MAXMIMSSOCM', 'MI MSS', 'MI MSS',
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
)
;
commit;