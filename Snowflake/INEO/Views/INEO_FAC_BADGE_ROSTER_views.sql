create or replace view INEO.INEO_D_FAC_BADGE_ROSTER_HISTORY_SV(
FAC_BADGE_ROSTER_ID	,
AUTONUMBER	,
TODAY	,
SUPERVISOR	,
MANAGER	,
REGION	,
FILENAME	,
SUPERVISOR_NAME	,
MANAGER_NAME	,
FACILITIES_SPECIALIST_NAME	,
GENERATE_PDF	,
RECORD_ID	,
EMPLOYEE_ID	,
EMPLOYEE_NAME	,
MAXIMUS_EMAIL	,
POSITION_TITLE	,
EMPLOYEE_TYPE	,
EMPLOYEE_STATUS	,
TERM_DATE	,
TRAINING_STATUS	,
TRAINING_CLASS_ID	,
TRAINING_START_DATE	,
TRAINING_END_DATE	,
NESTING_START_DATE	,
NESTING_END_DATE	,
FACILITIES_SPECIALIST	,
OFFICE_ADDRESS	,
REQUEST_TYPE	,
BADGE_STATUS	,
ACCESS_HOURS	,
ADDITIONAL_DETAILS	,
DATE_ADDED	,
DATE_SUBMITTED_TO_STATE	,
DATE_BADGE_RECEIVED_FROM_STATE	,
DATE_BADGE_PROVIDED_TO_EMPLOYEE	,
DATE_DEACTIVATION_SENT	,
DATE_BADGE_RETURNED_TO_STATE	,
SF_CREATE_TS	,
SF_UPDATE_TS) COPY GRANTS
AS SELECT * FROM  INEO_FAC_BADGE_ROSTER_HISTORY;



create or replace view INEO.INEO_D_FAC_BADGE_ROSTER_SV(
AUTONUMBER	,
TODAY	,
SUPERVISOR	,
MANAGER	,
REGION	,
FILENAME	,
SUPERVISOR_NAME	,
MANAGER_NAME	,
FACILITIES_SPECIALIST_NAME	,
GENERATE_PDF	,
RECORD_ID	,
EMPLOYEE_ID	,
EMPLOYEE_NAME	,
MAXIMUS_EMAIL	,
POSITION_TITLE	,
EMPLOYEE_TYPE	,
EMPLOYEE_STATUS	,
TERM_DATE	,
TRAINING_STATUS	,
TRAINING_CLASS_ID	,
TRAINING_START_DATE	,
TRAINING_END_DATE	,
NESTING_START_DATE	,
NESTING_END_DATE	,
FACILITIES_SPECIALIST	,
OFFICE_ADDRESS	,
REQUEST_TYPE	,
BADGE_STATUS	,
ACCESS_HOURS	,
ADDITIONAL_DETAILS	,
DATE_ADDED	,
DATE_SUBMITTED_TO_STATE	,
DATE_BADGE_RECEIVED_FROM_STATE	,
DATE_BADGE_PROVIDED_TO_EMPLOYEE	,
DATE_DEACTIVATION_SENT	,
DATE_BADGE_RETURNED_TO_STATE	,
SF_CREATE_TS	,
SF_UPDATE_TS) COPY GRANTS	
AS SELECT * FROM  INEO_FAC_BADGE_ROSTER;
