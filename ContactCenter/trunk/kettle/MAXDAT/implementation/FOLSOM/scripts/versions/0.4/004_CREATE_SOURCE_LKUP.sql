ALTER SESSION SET CURRENT_SCHEMA = FOLSOM_SHARED_CC;

create sequence SEQ_CC_SRLKUP_ID;
grant select on SEQ_CC_SRLKUP_ID to MAXDAT_READ_ONLY; 

create table CC_A_SOURCE_LKUP
  (CC_SRLKUP_ID    number not null,
   PROJECT_NAME       varchar2(30) not null,
   ACD_SOURCE  varchar2(30) not null,
   WFM_SOURCE      varchar2(30) not null,
   START_DATE date,
   END_DATE   date,
   ROW_INSERTED_DT date not null,
   ROW_UPDATED_DT date not null,
   ROW_INSERTED_BY varchar2(30) not null,
   ROW_UPDATED_BY varchar2(30) not null)
tablespace MAXDAT_DATA;

grant select on CC_A_SOURCE_LKUP to MAXDAT_READ_ONLY; 


CREATE OR REPLACE TRIGGER "BIU_CC_A_SOURCE_LKUP" 
  BEFORE INSERT OR UPDATE ON CC_A_SOURCE_LKUP 
  FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.CC_SRLKUP_ID IS NULL THEN 
  SELECT SEQ_CC_SRLKUP_ID.NEXTVAL INTO :NEW.CC_SRLKUP_ID FROM DUAL;
    :NEW.ROW_INSERTED_DT := SYSDATE;
    :NEW.ROW_INSERTED_BY := USER; 
    :NEW.ROW_UPDATED_DT := SYSDATE;
    :NEW.ROW_UPDATED_BY := USER; 
END IF;
    :NEW.ROW_UPDATED_DT := SYSDATE;
    :NEW.ROW_UPDATED_BY := USER; 
END;  
/
ALTER TRIGGER "BIU_CC_A_SOURCE_LKUP" ENABLE;


insert into CC_A_SOURCE_LKUP (project_name, acd_source, wfm_source, start_date, end_date) values ('FOLSOM', 'AVAYA', 'NA', sysdate, null);

commit;
