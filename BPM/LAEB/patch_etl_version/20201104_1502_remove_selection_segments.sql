CREATE TABLE emrs_d_selection_segment_bak20201104
AS
SELECT SELECTION_SEGMENT_ID,CLIENT_ID,PROGRAM_TYPE_CD,PLAN_TYPE_CD,START_DATE,END_DATE,STATUS_CD,STATUS_DATE,PLAN_ID,PLAN_ID_EXT,NETWORK_ID,PROVIDER_ID_EXT,PROVIDER_FIRST_NAME,
       PROVIDER_MIDDLE_NAME,PROVIDER_LAST_NAME,CHOICE_REASON_CD,DISENROLL_REASON_CD_1,DISENROLL_REASON_CD_2,CLIENT_AID_CATEGORY_CD,COUNTY_CD,ZIPCODE,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS,CONTRACT_ID,START_ND,END_ND,
       SS_GENERIC_FIELD1_DATE,SS_GENERIC_FIELD2_DATE,SS_GENERIC_FIELD3_NUM,SS_GENERIC_FIELD4_NUM,SS_GENERIC_FIELD5_TXT,SS_GENERIC_FIELD6_TXT,SS_GENERIC_FIELD7_TXT,SS_GENERIC_FIELD8_TXT,SS_GENERIC_FIELD9_TXT,SS_GENERIC_FIELD10_TXT
FROM emrs_d_selection_segment ss
WHERE  EXISTS(SELECT 1 FROM emrs_d_elig_segment_details sd WHERE ss.client_id = sd.client_id AND sd.segment_type_cd = 'MI' AND sd.start_date = ss.start_date 
           AND trunc(sd.record_date) >= to_date('10/18/2020','mm/dd/yyyy') AND to_number(to_char(ss.create_ts,'yyyymmddhh24mi')) < to_number(to_char(sd.record_date,'yyyymmddhh24mi')) );

DELETE FROM emrs_d_selection_segment ss
WHERE  EXISTS(SELECT 1 FROM emrs_d_elig_segment_details sd WHERE ss.client_id = sd.client_id AND sd.segment_type_cd = 'MI' AND sd.start_date = ss.start_date 
           AND trunc(sd.record_date) >= to_date('10/18/2020','mm/dd/yyyy') AND to_number(to_char(ss.create_ts,'yyyymmddhh24mi')) < to_number(to_char(sd.record_date,'yyyymmddhh24mi')) );

COMMIT;