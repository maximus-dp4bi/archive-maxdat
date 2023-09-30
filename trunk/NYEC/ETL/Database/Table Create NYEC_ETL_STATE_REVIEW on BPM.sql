CREATE TABLE NYEC_ETL_STATE_REVIEW (
NESR_ID                    NUMBER PRIMARY KEY,
itm_INSERT                  VARCHAR(1),
itm_INSERT_TS               DATE,
itm_UPDATE                  VARCHAR(1),
itm_UPDATE_TS               DATE,
App_ID                       NUMBER,
CEPA_ID NUMBER NOT NULL,
STAGE_DONE_DATE DATE,
STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL,
STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
INSTANCE_COMPLETE_DT DATE,
INSTANCE_STATUS VARCHAR2(50) DEFAULT 'ACTIVE',
GWF_TASK_WORKED_BY VARCHAR(1),
GWF_STATE_RESULT VARCHAR(1),
GWF_RESEARCH VARCHAR(1),
GWF_MI_Required VARCHAR(1),
ASF_RECEIVE_STATE_REVIEW VARCHAR(1) DEFAULT 'N',
ASF_PROCESS_DC VARCHAR(1) DEFAULT 'N',
ASF_RESEARCH VARCHAR(1) DEFAULT 'N',
ASF_REQUEST_MI_NOTICE VARCHAR(1) DEFAULT 'N',
AGE_IN_BUSINESS_DAYS NUMBER  NOT NULL,
AGE_IN_CALENDAR_DAYS NUMBER  NOT NULL,
ALL_MI_SATISFIED VARCHAR(1) NOT NULL,
AUTO_CLOSE_FLAG VARCHAR(1) NOT NULL,
CALL_CAMPAIGN_ID NUMBER,
CALL_CAMPAIGN_FLAG VARCHAR(1) NOT NULL,
CANCEL_DT DATE,
CURRENT_TASK_ID NUMBER,
LETTER_REQ_ID NUMBER,
LETTER_STATUS VARCHAR2(20),
NEW_MI_FLAG VARCHAR(1),
NEW_STATE_REVIEW_TASK_ID NUMBER,
RFE_STATUS_FLAG VARCHAR(1) NOT NULL,
STATE_ACCEPT_IND VARCHAR(1) NOT NULL,
STATE_REVIEW_OUTCOME VARCHAR2(10),
STATE_REVIEW_TASK_ID NUMBER NOT NULL,
ASED_RECEIVE_STATE_REVIEW DATE,
ASPB_RECEIVE_STATE_REVIEW VARCHAR2(100),
ASSD_RECEIVE_STATE_REVIEW DATE,
ASED_PROCESS_DC DATE,
ASPB_PROCESS_DC VARCHAR2(100),
ASSD_PROCESS_DC DATE,
ASED_RESEARCH DATE,
ASPB_RESEARCH VARCHAR2(100),
ASSD_RESEARCH DATE,
ASED_REQUEST_MI_NOTICE DATE,
ASSD_REQUEST_MI_NOTICE DATE,
UNIQUE(App_ID, state_review_task_id)
)

CREATE SEQUENCE seq_nesr START WITH 1 CACHE 1000;

CREATE OR REPLACE TRIGGER MAXDAT."TRG_state_ETL_Data_PRIMARY_bpm" BEFORE
       INSERT OR
       UPDATE ON NYEC_ETL_STATE_REVIEW_BPM FOR EACH ROW
BEGIN
  IF Inserting THEN
      SELECT seq_nesr.Nextval INTO :NEW.NESR_ID FROM Dual;
      :NEW.itm_INSERT_TS := to_date(SYSDATE);
  END IF;
  
  :NEW.itm_UPDATE_TS := SYSDATE;
END;


-- For testing the table
insert into NYEC_ETL_STATE_REVIEW_BPM
values (3,
        'I',
        to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
        'U', 
        to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
        5, 
        1, 
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       'IS',
       'T', 
       'R', 
       'R', 
       'M',
       'R', 
       'P', 
       'R', 
       'M', 
       1,
       1, 
       'M', 
       'C', 
       1, 
       1, 
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       1, 
       1, 
       'LS',
       '2', 
       1, 
       'F', 
       'A',
       'O', 
       1, 
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       'SR',
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       'PDC', 
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       'ASPD_R', to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 
       to_date('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));

select * from NYEC_ETL_STATE_REVIEW_BPM
delete from NYEC_ETL_STATE_REVIEW_BPM
