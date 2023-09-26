CREATE OR REPLACE TRIGGER BIU_CC_A_ADHOC_JOB 
    BEFORE INSERT OR UPDATE ON CC_A_ADHOC_JOB 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ADHOC_JOB_ID IS NULL THEN 
          SELECT SEQ_CC_A_ADHOC_JOB.NEXTVAL INTO :NEW.ADHOC_JOB_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATION_DATE := SYSDATE;
END IF;
END;  
/

ALTER TRIGGER BIU_CC_A_ADHOC_JOB ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_A_SCHEDULE 
    BEFORE INSERT ON CC_A_SCHEDULE 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.SCHEDULE_ID IS NULL THEN 
          SELECT SEQ_CC_A_SCHEDULE.NEXTVAL INTO :NEW.SCHEDULE_ID FROM DUAL;
END IF;
END;  
/


CREATE OR REPLACE TRIGGER BIU_CC_A_SCHEDULED_JOB 
    BEFORE INSERT OR UPDATE ON CC_A_SCHEDULED_JOB 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.SCHEDULED_JOB_ID IS NULL THEN 
          SELECT SEQ_CC_A_SCHEDULED_JOB.NEXTVAL INTO :NEW.SCHEDULED_JOB_ID FROM DUAL;
END IF;
IF INSERTING THEN
  	:NEW.JOB_START_DATE := SYSDATE;
END IF;
END; 
 
/

ALTER TRIGGER BIU_CC_A_SCHEDULED_JOB ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_C_ACTIVITY_TYPE 
    BEFORE INSERT OR UPDATE ON CC_C_ACTIVITY_TYPE 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.ACTIVITY_TYPE_ID IS NULL THEN 
          SELECT SEQ_CC_C_ACTIVITY_TYPE.NEXTVAL INTO :NEW.ACTIVITY_TYPE_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_C_ACTIVITY_TYPE ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_C_CONTACT_QUEUE 
    BEFORE INSERT OR UPDATE ON CC_C_CONTACT_QUEUE 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.C_CONTACT_QUEUE_ID IS NULL THEN 
  SELECT SEQ_CC_C_CONTACT_QUEUE.NEXTVAL INTO :NEW.C_CONTACT_QUEUE_ID FROM DUAL;
END IF;
IF INSERTING AND :NEW.QUEUE_NUMBER IS NULL THEN 
  :NEW.QUEUE_NUMBER := :NEW.C_CONTACT_QUEUE_ID;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_C_CONTACT_QUEUE ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_C_FILTER 
    BEFORE INSERT OR UPDATE ON CC_C_FILTER 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.FILTER_ID IS NULL THEN 
          SELECT SEQ_CC_C_FILTER.NEXTVAL INTO :NEW.FILTER_ID FROM DUAL;
END IF;
END;  
/


CREATE OR REPLACE TRIGGER BIU_CC_C_LOOKUP 
    BEFORE INSERT OR UPDATE ON CC_C_LOOKUP 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.LOOKUP_ID IS NULL THEN 
          SELECT SEQ_CC_C_LOOKUP.NEXTVAL INTO :NEW.LOOKUP_ID FROM DUAL;
END IF;
END;  
/


CREATE OR REPLACE TRIGGER BIU_CC_C_PROJECT_CONFIG 
    BEFORE INSERT OR UPDATE ON CC_C_PROJECT_CONFIG 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.PROJECT_CONFIG_ID IS NULL THEN 
          SELECT SEQ_CC_C_PROJECT_CONFIG.NEXTVAL INTO :NEW.PROJECT_CONFIG_ID FROM DUAL;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_C_PROJECT_CONFIG ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_C_UNIT_OF_WORK 
    BEFORE INSERT OR UPDATE ON CC_C_UNIT_OF_WORK 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.UNIT_OF_WORK_ID IS NULL THEN 
          SELECT SEQ_CC_C_UNIT_OF_WORK.NEXTVAL INTO :NEW.UNIT_OF_WORK_ID FROM DUAL;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_C_UNIT_OF_WORK ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_L_PATCH_LOG 
    BEFORE INSERT OR UPDATE ON CC_L_PATCH_LOG 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.PATCH_LOG_ID IS NULL THEN 
  SELECT SEQ_CC_L_PATCH_LOG.NEXTVAL INTO :NEW.PATCH_LOG_ID FROM DUAL;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_L_PATCH_LOG ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_AGENT_ACTIVITY 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_AGENT_ACTIVITY 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.ACD_AGENT_ACTIVITY_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_AGENT_ACTIVITY.NEXTVAL INTO :NEW.ACD_AGENT_ACTIVITY_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_ACD_AGENT_ACTIVITY ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ACD_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_INTERVAL.NEXTVAL INTO :NEW.ACD_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
IF :NEW.LAST_UPDATE_BY IS NULL THEN 
          :NEW.LAST_UPDATE_BY := USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
END; 
/

ALTER TRIGGER BIU_CC_S_ACD_INTERVAL ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_INTERVAL_PERIOD 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_INTERVAL_PERIOD 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ACD_INTERVAL_PERIOD_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_INTERVAL_PERIOD.NEXTVAL INTO :NEW.ACD_INTERVAL_PERIOD_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_S_ACD_INTERVAL_PERIOD ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_AGENT 
    BEFORE INSERT OR UPDATE ON CC_S_AGENT 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.AGENT_ID IS NULL THEN 
          SELECT SEQ_CC_S_AGENT.NEXTVAL INTO :NEW.AGENT_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_AGENT ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_AGENT_ABSENCE 
    BEFORE INSERT OR UPDATE ON CC_S_AGENT_ABSENCE 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.AGENT_ABSENCE_ID IS NULL THEN 
          SELECT SEQ_CC_S_AGENT_ABSENCE.NEXTVAL INTO :NEW.AGENT_ABSENCE_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_AGENT_ABSENCE ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_AGENT_SUPERVISOR 
    BEFORE INSERT OR UPDATE ON CC_S_AGENT_SUPERVISOR 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.AGENT_SUPERVISOR_ID IS NULL THEN 
          SELECT SEQ_CC_S_AGENT_SUPERVISOR.NEXTVAL INTO :NEW.AGENT_SUPERVISOR_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_S_AGENT_SUPERVISOR ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_AGENT_WORK_DAY 
    BEFORE INSERT OR UPDATE ON CC_S_AGENT_WORK_DAY 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.AGENT_WORK_DAY_ID IS NULL THEN 
          SELECT SEQ_CC_S_AGENT_WORK_DAY.NEXTVAL INTO :NEW.AGENT_WORK_DAY_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_AGENT_WORK_DAY ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_CALL_DETAIL 
    BEFORE INSERT OR UPDATE ON CC_S_CALL_DETAIL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.CALL_DETAIL_ID IS NULL THEN 
          SELECT SEQ_CC_S_CALL_DETAIL.NEXTVAL INTO :NEW.CALL_DETAIL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_CALL_DETAIL ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_CONTACT_QUEUE 
    BEFORE INSERT OR UPDATE ON CC_S_CONTACT_QUEUE 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.CONTACT_QUEUE_ID IS NULL THEN 
          SELECT SEQ_CC_S_CONTACT_QUEUE.NEXTVAL INTO :NEW.CONTACT_QUEUE_ID FROM DUAL;
END IF;
END; 
/

ALTER TRIGGER BIU_CC_S_CONTACT_QUEUE ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_FCST_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_FCST_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.FCST_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_FCST_INTERVAL.NEXTVAL INTO :NEW.FCST_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_FCST_INTERVAL ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_INTERVAL.NEXTVAL INTO :NEW.INTERVAL_ID FROM DUAL;
END IF;
END;  
/

ALTER TRIGGER BIU_CC_S_INTERVAL ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_IVR_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_IVR_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.IVR_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_IVR_INTERVAL.NEXTVAL INTO :NEW.IVR_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
IF :NEW.LAST_UPDATE_BY IS NULL THEN 
	:NEW.LAST_UPDATE_BY := USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
END; 
/

ALTER TRIGGER BIU_CC_S_IVR_INTERVAL ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_PP_HORIZON 
    BEFORE INSERT OR UPDATE ON CC_S_PRODUCTION_PLAN_HORIZON 
    FOR EACH ROW 
BEGIN IF INSERTING
  AND :NEW.PRODUCTION_PLAN_HORIZON_ID IS NULL THEN
  SELECT SEQ_CC_S_PP_HORIZON.NEXTVAL INTO :NEW.PRODUCTION_PLAN_HORIZON_ID FROM DUAL;
END IF;
IF INSERTING THEN
  :NEW.CREATE_DATE := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DATE := SYSDATE;
END;
/ 


CREATE OR REPLACE TRIGGER BIU_CC_S_PRODUCTION_PLAN 
    BEFORE INSERT OR UPDATE ON CC_S_PRODUCTION_PLAN 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.PRODUCTION_PLAN_ID IS NULL THEN 
          SELECT SEQ_CC_S_PRODUCTION_PLAN.NEXTVAL INTO :NEW.PRODUCTION_PLAN_ID FROM DUAL;
END IF;
IF INSERTING THEN
  :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DATE := SYSDATE;
END; 
/

ALTER TRIGGER BIU_CC_S_PRODUCTION_PLAN ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_VM_IN_QUEUE 
    BEFORE INSERT OR UPDATE ON CC_S_VM_IN_QUEUE 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.CCVMQ_ID IS NULL THEN 
          SELECT SEQ_CC_S_VM_IN_QUEUE.NEXTVAL INTO :NEW.CCVMQ_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_VM_IN_QUEUE ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_WFM_AGENT_ACTIVITY 
    BEFORE INSERT OR UPDATE ON CC_S_WFM_AGENT_ACTIVITY 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.WFM_AGENT_ACTIVITY_ID IS NULL THEN 
          SELECT SEQ_CC_S_WFM_AGENT_ACTIVITY.NEXTVAL INTO :NEW.WFM_AGENT_ACTIVITY_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

ALTER TRIGGER BIU_CC_S_WFM_AGENT_ACTIVITY ENABLE; 


CREATE OR REPLACE TRIGGER BIU_CC_S_WFM_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_WFM_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.WFM_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_WFM_INTERVAL.NEXTVAL INTO :NEW.WFM_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END;  
/

ALTER TRIGGER BIU_CC_S_WFM_INTERVAL ENABLE; 


CREATE OR REPLACE TRIGGER BI_CC_L_ERROR 
    BEFORE INSERT ON CC_L_ERROR 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ID IS NULL THEN 
          SELECT SEQ_CC_L_ERROR.NEXTVAL INTO :NEW.ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.ERROR_DATE := SYSDATE;
END IF;
END; 
/

ALTER TRIGGER BI_CC_L_ERROR ENABLE; 

CREATE OR REPLACE TRIGGER TRG_BIU_CC_A_LIST_LKUP
BEFORE INSERT OR UPDATE ON CC_A_LIST_LKUP
FOR EACH ROW
BEGIN
  if inserting then
    if :new.CC_CELL_ID is null then
      :new.CC_CELL_ID := SEQ_CC_CELL_ID.nextval;
    end if;
    if :new.CREATED_TS is null then
      :new.CREATED_TS := sysdate;
    end if;
  end if;
  :new.UPDATED_TS := sysdate;
end;
/


CREATE OR REPLACE TRIGGER TRG_ADIU_CC_A_LIST_LKUP
AFTER INSERT OR UPDATE OR DELETE ON CC_A_LIST_LKUP
FOR EACH ROW
BEGIN

  if inserting then
    insert into CC_A_LIST_LKUP_HIST
      (CC_CELL_HISTORY_ID,
       HIST_TYPE,
       CC_CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CC_CELL_HISTORY_SEQ.nextval,
       'INSERT',
       :new.CC_CELL_ID,
       :new.NAME,
       :new.LIST_TYPE,
       :new.VALUE,
       :new.OUT_VAR,
       :new.REF_TYPE,
       :new.REF_ID,
       :new.START_DATE, 
       :new.END_DATE,
       :new.COMMENTS,
       :new.CREATED_TS,
       :new.UPDATED_TS,
       sysdate,
       user,
       sysdate);
  end if;
  
  if updating then
    insert into CC_A_LIST_LKUP_HIST 
      (CC_CELL_HISTORY_ID,
       HIST_TYPE,
       CC_CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CC_CELL_HISTORY_SEQ.nextval,
       'UPDATE',
       :old.CC_CELL_ID,
       :old.name,
       :old.LIST_TYPE,
       :old.value,
       :old.OUT_VAR,
       :old.REF_TYPE,
       :old.REF_ID,
       :old.START_DATE,
       :old.END_DATE,
       :old.COMMENTS,
       :old.CREATED_TS,
       :old.UPDATED_TS,
       sysdate,
       user,
       sysdate);
       
  end if;
  
  if deleting then
    insert into CC_A_LIST_LKUP_HIST
      (CC_CELL_HISTORY_ID,
       HIST_TYPE,
       CC_CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CC_CELL_HISTORY_SEQ.nextval,
       'DELETE',
       :old.CC_CELL_ID,
       :old.name,
       :old.LIST_TYPE,
       :old.value,
       :old.OUT_VAR,
       :old.REF_TYPE,
       :old.REF_ID,
       :old.START_DATE,
       :old.END_DATE,
       :old.COMMENTS,
       :old.CREATED_TS,
       :old.UPDATED_TS,
       sysdate,
       user,
       sysdate);
  end if;
  
end;
/

CREATE OR REPLACE TRIGGER BI_CC_D_COUNTRY 
    BEFORE INSERT ON CC_D_COUNTRY 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.COUNTRY_ID IS NULL THEN 
          SELECT SEQ_CC_D_COUNTRY.NEXTVAL INTO :NEW.COUNTRY_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BI_CC_D_REGION 
    BEFORE INSERT ON CC_D_REGION 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.REGION_ID IS NULL THEN 
          SELECT SEQ_CC_D_REGION.NEXTVAL INTO :NEW.REGION_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BI_CC_D_DISTRICT 
    BEFORE INSERT ON CC_D_DISTRICT
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DISTRICT_ID IS NULL THEN 
          SELECT SEQ_CC_D_DISTRICT.NEXTVAL INTO :NEW.DISTRICT_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BI_CC_D_PROVINCE 
    BEFORE INSERT ON CC_D_PROVINCE 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.PROVINCE_ID IS NULL THEN 
          SELECT SEQ_CC_D_PROVINCE.NEXTVAL INTO :NEW.PROVINCE_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BI_CC_D_STATE
    BEFORE INSERT ON CC_D_STATE 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.STATE_ID IS NULL THEN 
          SELECT SEQ_CC_D_STATE.NEXTVAL INTO :NEW.STATE_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BI_CC_D_GEO_MASTER
    BEFORE INSERT ON CC_D_GEOGRAPHY_MASTER 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.GEOGRAPHY_MASTER_ID IS NULL THEN 
          SELECT SEQ_CC_D_GEOGRAPHY_MASTER.NEXTVAL INTO :NEW.GEOGRAPHY_MASTER_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_Q_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_QUEUE_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ACD_QUEUE_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_Q_INTERVAL.NEXTVAL INTO :NEW.ACD_QUEUE_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
IF :NEW.LAST_UPDATE_BY IS NULL THEN 
          :NEW.LAST_UPDATE_BY := USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
END; 
/    

CREATE OR REPLACE VIEW CC_F_ACD_QUEUE_INTERVAL_SV  AS
SELECT CC_F_ACD_QUEUE_INTERVAL.* FROM CC_F_ACD_QUEUE_INTERVAL ;

CREATE OR REPLACE TRIGGER BI_CC_F_ACD_Q_INTERVAL 
    BEFORE INSERT ON CC_F_ACD_QUEUE_INTERVAL 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.F_CC_ACD_QUEUE_INTRVL_ID IS NULL THEN 
          SELECT SEQ_CC_F_ACD_Q_INTERVAL.NEXTVAL INTO :NEW.F_CC_ACD_QUEUE_INTRVL_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_A_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_AGENT_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ACD_AGENT_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_A_INTERVAL.NEXTVAL INTO :NEW.ACD_AGENT_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
IF :NEW.LAST_UPDATE_BY IS NULL THEN 
          :NEW.LAST_UPDATE_BY := USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
END; 
/    

CREATE OR REPLACE VIEW CC_F_ACD_AGENT_INTERVAL_SV  AS
SELECT CC_F_ACD_AGENT_INTERVAL.* FROM CC_F_ACD_AGENT_INTERVAL ;

CREATE OR REPLACE TRIGGER BI_CC_F_ACD_A_INTERVAL 
    BEFORE INSERT ON CC_F_ACD_AGENT_INTERVAL 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.F_CC_ACD_AGENT_INTRVL_ID IS NULL THEN 
          SELECT SEQ_CC_F_ACD_A_INTERVAL.NEXTVAL INTO :NEW.F_CC_ACD_AGENT_INTRVL_ID FROM DUAL;      
END IF;
END;  
/