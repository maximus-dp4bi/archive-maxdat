CREATE TABLE etl_l_dialer_response_stg(
JOB_ID	NUMBER,
ROW_NUM	NUMBER,
CPP_ID	NUMBER,
CCCR_ID	NUMBER,
PD_REQUEST_ID	NUMBER,
APPLICANT_NAME	VARCHAR2(50),
PHONE1	VARCHAR2(10),
PHONE2	VARCHAR2(10),
PHONE3	VARCHAR2(10),
PHONE4	VARCHAR2(10),
PHONE5	VARCHAR2(10),
PHONE6	VARCHAR2(10),
APPLICANT_GENDER	VARCHAR2(7),
AUTH_REP_NAME	VARCHAR2(75),
AUTH_REP_GENDER	VARCHAR2(7),
SPOKEN_LANGUAGE	VARCHAR2(40),
CALL_TYPE	VARCHAR2(15),
EXT_AC	VARCHAR2(3),
EXT_TZ	VARCHAR2(2),
EXT_DIAL_CNT	NUMBER,
EXT_CALL1_PHONE	VARCHAR2(32),
EXT_CALL1_DATE	DATE,
EXT_CALL1_DISP_ID	VARCHAR2(8),
EXT_CALL1_DISP_CD	VARCHAR2(8),
EXT_CALL1_DISPOSITION	VARCHAR2(80),
EXT_CALL1_AGENT	VARCHAR2(16),
EXT_CALL2_PHONE	VARCHAR2(32),
EXT_CALL2_DATE	DATE,
EXT_CALL2_DISP_ID	VARCHAR2(8),
EXT_CALL2_DISP_CD	VARCHAR2(8),
EXT_CALL2_DISPOSITION	VARCHAR2(80),
EXT_CALL2_AGENT	VARCHAR2(16),
EXT_CALL3_PHONE	VARCHAR2(32),
EXT_CALL3_DATE	DATE,
EXT_CALL3_DISP_ID	VARCHAR2(8),
EXT_CALL3_DISP_CD	VARCHAR2(8),
EXT_CALL3_DISPOSITION	VARCHAR2(80),
EXT_CALL3_AGENT	VARCHAR2(16),
EXT_CALL4_PHONE	VARCHAR2(32),
EXT_CALL4_DATE	DATE,
EXT_CALL4_DISP_ID	VARCHAR2(8),
EXT_CALL4_DISP_CD	VARCHAR2(8),
EXT_CALL4_DISPOSITION	VARCHAR2(80),
EXT_CALL4_AGENT	VARCHAR2(16),
EXT_CALL5_PHONE	VARCHAR2(32),
EXT_CALL5_DATE	DATE,
EXT_CALL5_DISP_ID	VARCHAR2(8),
EXT_CALL5_DISP_CD	VARCHAR2(8),
EXT_CALL5_DISPOSITION	VARCHAR2(80),
EXT_CALL5_AGENT	VARCHAR2(16),
EXT_CALL6_PHONE	VARCHAR2(32),
EXT_CALL6_DATE	DATE,
EXT_CALL6_DISP_ID	VARCHAR2(8),
EXT_CALL6_DISP_CD	VARCHAR2(8),
EXT_CALL6_DISPOSITION	VARCHAR2(80),
EXT_CALL6_AGENT	VARCHAR2(16),
PROCESS_IND	NUMBER,
PROCESS_TS	DATE,
ERROR_COUNT	NUMBER,
ERROR_TEXT	VARCHAR2(1000),
RECORD_CONTENT	VARCHAR2(2000),
CREATE_TS DATE) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX ETL_L_DIALERRESP_UK ON etl_l_dialer_response_stg(job_id,row_num) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx01_dialerrsp_cccr_id ON etl_l_dialer_response_stg(cccr_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx02_dialerrsp_disp_id ON etl_l_dialer_response_stg(ext_call1_disp_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx03_dialerrsp_disp_id ON etl_l_dialer_response_stg(ext_call2_disp_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx04_dialerrsp_disp_id ON etl_l_dialer_response_stg(ext_call3_disp_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx05_dialerrsp_disp_id ON etl_l_dialer_response_stg(ext_call4_disp_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx06_dialerrsp_disp_id ON etl_l_dialer_response_stg(ext_call5_disp_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx07_dialerrsp_disp_id ON etl_l_dialer_response_stg(ext_call6_disp_id) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON ETL_L_DIALER_RESPONSE_STG TO MAXDAT_READ_ONLY;