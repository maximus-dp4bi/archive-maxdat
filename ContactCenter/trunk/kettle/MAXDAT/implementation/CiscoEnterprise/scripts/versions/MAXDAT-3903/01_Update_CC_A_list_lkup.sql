/*
Created by Raj A on 08/11/2016.
Description: MAXDAT-3903
1.	Capture the string from the filename and load data. 
Eg: Capture MAXMIAFC from filename and replace the 'MAXMIAPS' in the file data with MAXMIAFC.
2.	Compare this substring with value in db. This is to check if a remapping is needed. If no value exists in db, NO remapping needed.
3.	Added a program name to the global control table because NO fact build is needed for this data file.
*/
-- If substring of Filename is 'MAXMIAFC', then replace with 'MAXMIAPS'.
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_REMAP_MAXMIAFC', --name
'IVR_APP_NAME_REMAP', --list_type
'MAXMIAFC',  --value
'MAXMIAPS',  --out_var
'MI Provider Support', --ref_type
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to remap the Application_name value in the data file to a substring of the filename.'
);

--Configuring for MI APCC project. Start using Ref_type to store program_name. out_var has project_name.
--Configured application_name = MAXMIAFC to MI APCC project.
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_DATA_FILE_NAMES',  --name
'IVR_APP_NAME', --list_type
'MAXMIAFC',  --value
'MI APCC',  --out_var
'MI Provider Support', --ref_type
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to fetch the Project name using the Application Name from data file.'
);

--Do NOT build facts for this project.
--MAXMIAFC is not actually a project. MAXMIAPS's project data is sent to MAXDAT team as MAXMIAFC data
INSERT INTO CC_A_LIST_LKUP
(NAME, list_type, VALUE, out_var, ref_type, start_date, end_date, comments)
VALUES (
'IVR_NO_FACT_MAXMIAFC',  --name
'IVR_NO_FACT_BUILD_TYPE', --list_type
'MAXMIAFC',  --value
NULL,  --out_var
NULL, --ref_type
trunc(SYSDATE),  to_date('7/7/7777','mm/dd/yyyy'),
'Global control to NOT build facts for this project.'
);
COMMIT;