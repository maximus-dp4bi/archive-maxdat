/*
Created by Raj A on 12/07/2016.
Description: Per MAXDAT-5052 and PAIEB-541, configuring to load PA IEB data.
Raj A. 04/12/2017  Updated Program_Name = 'Independent Enrollment Broker'
*/
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES', 'IVR_APP_NAME','MAXPAIEB', 'PA IEB', 'Independent Enrollment Broker',
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
)
;

INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES', 'IVR_APP_NAME','MAXPAIEBOCM', 'PA IEB', 'Independent Enrollment Broker',
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
)
;

COMMIT;