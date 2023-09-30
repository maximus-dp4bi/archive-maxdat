CREATE TABLE dataentry_screen_stg
(de_header_id NUMBER
 ,application_id NUMBER
 ,form_type VARCHAR2(20)
 ,create_ts  DATE
 ,update_ts DATE
 ,mam_group_id NUMBER
 ,dataentry_source VARCHAR2(10)
 ,app_dataentry_ans_id NUMBER
) TABLESPACE MAXDAT_DATA;
 
CREATE INDEX IDX01_DESCREEN_STG ON  dataentry_screen_stg(application_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_DESCREEN_STG ON  dataentry_screen_stg(dataentry_source) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX03_DESCREEN_STG ON  dataentry_screen_stg(app_dataentry_ans_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX04_DESCREEN_STG ON  dataentry_screen_stg(de_header_id,application_id) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON DATAENTRY_SCREEN_STG TO MAXDAT_READ_ONLY;