SELECT
c.case_id as CASE_ID 
,'MEDICAID' as MANAGED_CARE_PROGRAM
,c.case_id as CASE_NUMBER
,'0'  as CSDA_CODE
,c.case_head_fname as FIRST_NAME
,SUBSTR(c.case_head_mi,1,1) as MIDDLE_INITIAL
,c.case_head_lname as LAST_NAME
,c.case_head_fname||CASE WHEN SUBSTR(c.case_head_mi,1,1) IS NULL THEN ' ' ELSE ' '||SUBSTR(c.case_head_mi,1,1)||' ' END ||c.case_head_lname as FULL_NAME
,c.case_phone as PHONE
,null  as MAILING_ADDRESS1
,null as MAILING_ADDRESS2
,null as MAILING_CITY
,null as MAILING_STATE
,null as MAILING_ZIP
,null  as CASE_SEARCH_ELEMENT
,c.case_head_fname||CASE WHEN SUBSTR(c.case_head_mi,1,1) IS NULL THEN ' ' ELSE ' '||SUBSTR(c.case_head_mi,1,1)||' ' END ||c.case_head_lname as GUARDIAN_FULL_NAME
,c.creation_date as RECORD_DATE
,TO_CHAR(c.creation_date,'HH24MI') as RECORD_TIME
,c.created_by as RECORD_NAME
,c.last_update_date  as MODIFIED_DATE
,TO_CHAR(c.last_update_date,'HH24MI') as MODIFIED_TIME 
,c.last_updated_by as MODIFIED_NAME
,1 as VERSION
,c.creation_date as DATE_OF_VALIDITY_START
,TO_DATE('12/31/2050','mm/dd/yyyy') as DATE_OF_VALIDITY_END
,c.created_by as CREATED_BY
,c.creation_date as DATE_CREATED
,c.last_updated_by as UPDATED_BY
,c.last_update_date as DATE_UPDATED
,c.case_id as SOURCE_RECORD_ID
,c.case_id as CURRENT_CASE_ID
,'Y' as CURRENT_FLAG
,c.case_cin as CASE_CIN
,c.family_number as FAMILY_NUMBER
,c.case_status_date as CASE_STATUS_DATE
,c.case_educated_ind as CASE_EDUCATED_IND
,c.case_educated_date as CASE_EDUCATED_DATE
,c.case_need_translator_ind as CASE_NEED_TRANSLATOR_IND
,c.case_phone_reminder_use as CASE_PHONE_REMINDER_USE
,c.case_educated_by as CASE_EDUCATED_BY
,c.case_staff_id as CASE_STAFF_ID
,c.case_language_cd as CASE_LANGUAGE_CD
,c.case_how_educated_cd as CASE_HOW_EDUCATED_CD
,c.case_status as CASE_STATUS
,c.case_head_ssn as CASE_HEAD_SSN
,c.case_team as CASE_TEAM
,c.case_load as CASE_LOAD
,c.clnt_client_id as CLNT_CLIENT_ID
,c.fmnb_id as FMNB_ID
,c.load_type as LOAD_TYPE
,c.case_spoken_language_cd as CASE_SPOKEN_LANGUAGE_CD
,c.note_ref_id as NOTE_REF_ID
,c.anniversary_dt as ANNIVERSARY_DT
,c.state_staff_id_ext as STATE_STAFF_ID_EXT
,c.case_generic_field1_date as CASE_GENERIC_FIELD1_DATE
,c.case_generic_field2_date as CASE_GENERIC_FIELD2_DATE
,c.case_generic_field3_num as CASE_GENERIC_FIELD3_NUM
,c.case_generic_field4_num  as CASE_GENERIC_FIELD4_NUM
,c.case_generic_field5_txt  as CASE_GENERIC_FIELD5_TXT
,c.case_generic_field6_txt as CASE_GENERIC_FIELD6_TXT
,c.case_generic_field7_txt as CASE_GENERIC_FIELD7_TXT
,c.case_generic_field8_txt as CASE_GENERIC_FIELD8_TXT
,c.case_generic_field9_txt as CASE_GENERIC_FIELD9_TXT
,c.case_generic_field10_txt as CASE_GENERIC_FIELD10_TXT
,c.case_generic_ref11_id as CASE_GENERIC_REF11_ID
,c.case_generic_ref12_id as CASE_GENERIC_REF12_ID
,c.last_state_update_ts as LAST_STATE_UPDATE_TS
,c.last_state_updated_by as LAST_STATE_UPDATED_BY
FROM cases c 