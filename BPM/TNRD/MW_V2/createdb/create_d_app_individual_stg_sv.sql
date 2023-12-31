alter session set current_schema=MAXDAT;

CREATE VIEW D_APP_INDIVIDUAL_STG_SV
AS SELECT 
APP_INDIVIDUAL_ID, 
REF_VALUE_3, 
HOH_IND, 
UPDATED_BY, 
APPLICANT_IND, 
UPDATE_TS, 
REMOVED_FROM_APP_IND, 
CREATED_BY, 
CLIENT_FNAME, 
REF_TYPE_1, 
REF_TYPE_3, 
REF_TYPE_2, 
ROLE_CD, 
CLIENT_LNAME, 
LOAD_CONFLICT_IND, 
REF_VALUE_2, 
SUFFIX, 
CLIENT_LAST_UPDATE_DATE, 
CLIENT_CIN, 
CLIENT_SELECTION_DATE, 
CUT_OFF_DATE, 
APPLICATION_ID, 
REF_VALUE_1, 
CLIENT_ID, 
CLIENT_MI, 
MI_IND, 
CREATE_TS
FROM APP_INDIVIDUAL_STG;

GRANT SELECT ON D_APP_INDIVIDUAL_STG_SV to MAXDAT_READ_ONLY;

