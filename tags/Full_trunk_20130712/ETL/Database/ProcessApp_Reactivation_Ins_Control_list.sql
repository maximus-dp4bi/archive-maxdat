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
    v_rec.START_DATE := Trunc(SYSDATE-1);
    v_rec.END_DATE := to_date('07/07/7777','mm/dd/yyyy');
    v_rec.CREATED_TS := SYSDATE;
    v_rec.UPDATED_TS := SYSDATE;
    v_rec.ref_type := 'STEP_DEFINITION_ID';

    
    --*****************************************
    -- common values
    v_rec.NAME := 'TASK_MONITOR_TYPE';
    v_rec.COMMENTS := 'Monitor Type for Tasks';
      v_rec.LIST_TYPE := 'LIST';

    -- Created State Data Entry  monitor Types
    v_rec.VALUE := 'State Data Entry - MI Reactivation';   v_rec.OUT_VAR := 'State Data Entry';  v_rec.REF_ID := 1113018;    ins_rec;


--*** set reactivation_nbr to 0 ***

Update process_app_stg set Reactivation_nbr = 0 where nvl(Reactivation_nbr,1) <> 0 ; 
Update nyec_etl_process_app set Reactivation_nbr = 0 where nvl(Reactivation_nbr,1) <> 0 ; 


--*** Data correction for existing reactivated app ***

update nyec_etl_process_app 
   set Reactivation_ind = 0, reactivation_dt = null , reactivation_reason = null , reactivated_by = null
 where reactivation_ind = 1 ;


Update Process_app_stg 
   set Reactivation_ind = 0, reactivation_dt = null , reactivation_reason = null , reactivated_by = null
 where reactivation_ind = 1;


COMMIT;

END;
/


ALTER TABLE NYEC_ETL_PROCESS_APP MODIFY GWF_OUTCM_NOTIFY_RQRD DEFAULT NULL;
Alter Table NYEC_ETL_PROCESS_APP Modify STOP_APP_REASON VARCHAR2(100);
Alter Table NYEC_ETL_PROCESS_APP Modify REACTIVATION_REASON VARCHAR2(64);
Alter Table NYEC_ETL_PROCESS_APP Modify REACTIVATION_NBR default 0 ;
      
Alter Table PROCESS_APP_STG Modify STOP_APP_REASON VARCHAR2(100);
Alter Table PROCESS_APP_STG Modify REACTIVATION_REASON   VARCHAR2(64);
Alter Table PROCESS_APP_STG Modify REACTIVATION_NBR default 0 ;

Alter table Process_app_stg modify reactivation_nbr not null; 
Alter table NYEC_ETL_PROCESS_APP modify reactivation_nbr not null;


Alter Table PROCESS_APP_STG DROP PRIMARY KEY;

Alter table PROCESS_APP_STG
  add primary key (APP_ID, REACTIVATION_NBR)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10 
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


DROP INDEX NYEC_ETL_PROCESS_APP_UK2;
  
Create Unique Index NYEC_ETL_PROCESS_APP_UK2 on NYEC_ETL_PROCESS_APP (APP_ID, REACTIVATION_NBR)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  



