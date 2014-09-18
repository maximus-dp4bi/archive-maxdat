DECLARE 
 v_rec        corp_etl_list_lkup%ROWTYPE;
 --
     PROCEDURE ins_rec IS
        v_cnt INTEGER := 0;
        v_id INTEGER;
     BEGIN
     
           SELECT  COUNT(*) INTO v_cnt
             FROM corp_etl_list_lkup  a
            WHERE a.NAME = v_rec.NAME
              AND a.list_type = v_rec.list_type
              AND a.VALUE     = v_rec.value;
           IF v_cnt = 0 THEN
              SELECT seq_cell_id.nextval INTO v_id FROM dual;
              v_rec.CELL_ID:= v_id;
              INSERT INTO corp_etl_list_lkup VALUES v_rec;
           END IF;
     END;
BEGIN
    v_rec.START_DATE := Trunc(SYSDATE);
    v_rec.END_DATE := to_date('07/07/7777','mm/dd/yyyy');
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;
    v_rec.ref_type := 'STEP_DEFINITION_ID';

    
    -- *****************************************
    -- common values
    v_rec.NAME := 'TASK_MONITOR_TYPE';
    v_rec.COMMENTS := 'Monitor Type for Tasks';
      v_rec.LIST_TYPE := 'LIST';


    -- Create Registration task

v_rec.VALUE := 'State Data Entry App Registration Task- Upstate';   v_rec.OUT_VAR := 'SDE Registration';  v_rec.REF_ID := 1113007;    ins_rec;
v_rec.VALUE := 'State Data Entry App Registration Task- Downstate'; v_rec.OUT_VAR := 'SDE Registration';  v_rec.REF_ID := 1113008;    ins_rec;

    -- Create QC Registration task
    
v_rec.VALUE := 'MAXIMUS-QC Application Registration Upstate';   v_rec.OUT_VAR := 'QC Registration';  v_rec.REF_ID := 2223015;    ins_rec;
v_rec.VALUE := 'MAXIMUS-QC Application Registration Downstate'; v_rec.OUT_VAR := 'QC Registration';  v_rec.REF_ID := 2223016;    ins_rec;

    -- *****************************************

    -- Two applications were missing in production 

Insert into Process_app_stg ( APP_ID,	APP_STATUS, APP_STATUS_GROUP, APP_TYPE, CREATE_DT, LAST_MAIL_DT, APP_IN_PROCESS, APP_PRIORITY_IND, NUMBER_OF_APPLICANTS )
select 404717 APP_ID, 'Renewal Initiated' APP_STATUS, 'Renewal Initiated' APP_STATUS_GROUP, 'Renewal' APP_TYPE
     , to_date('03/05/2013 6:44:25 PM','mm/dd/yyyy hh:mi:ss am') CREATE_DT, to_date('03/23/2013','mm/dd/yyyy') LAST_MAIL_DT
     , 'Y' APP_IN_PROCESS,1 APP_PRIORITY_IND, 5 APPLICANT_CNT 
from dual
where not exists ( select 1 from process_App_Stg where app_id = 404717) ; 

Insert into Process_app_stg ( APP_ID,	APP_STATUS, APP_STATUS_GROUP, APP_TYPE, CREATE_DT, LAST_MAIL_DT, APP_IN_PROCESS, APP_PRIORITY_IND, NUMBER_OF_APPLICANTS )
select 447176 APP_ID, 'Renewal Initiated' APP_STATUS, 'Renewal Initiated' APP_STATUS_GROUP, 'Renewal' APP_TYPE
     , to_date('05/08/2013 4:09:34 PM','mm/dd/yyyy hh:mi:ss am') CREATE_DT, to_date('05/25/2013','mm/dd/yyyy') LAST_MAIL_DT
     , 'Y' APP_IN_PROCESS,1 APP_PRIORITY_IND, 1 APPLICANT_CNT 
from dual
where not exists ( select 1 from process_App_Stg where app_id = 447176) ;  


END;

/

COMMIT;