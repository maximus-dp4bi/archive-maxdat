alter session set plsql_code_type = native;

-- Trigger for creating a record in the history table
-- Trigger previously named TR_CORP_ETL_CLEAN_TABLE_HS.
create or replace trigger TRG_ADIU_CORP_ETL_CLEAN
after delete or insert or update on CORP_ETL_CLEAN_TABLE 
for each row
declare
  v_change_type CORP_ETL_CLEAN_TABLE_HS.HS_ACTION%type;
begin

  if inserting then
    v_change_type :='INSERT';
  elsif updating then
    v_change_type :='UPDATE';
  elsif deleting then
    v_change_type :='DELETE';
  end if;
  
  if inserting or updating then

    insert into CORP_ETL_CLEAN_TABLE_HS
      (CECT_HS_ID,
       CECT_ID,
       TABLE_NAME,
       COLUMN_NAME,
       DELETE_WHERE_CLAUSE,
       DAYS_TILL_DELETE,
       START_DATE,
       END_DATE,
       CREATED_TS,
       LAST_UPDATE_TS,
       ARC_FLAG,
       ARC_TABLE,
       HS_CREATED_TS,
       HS_LAST_UPDATE_TS,
       HS_ACTION)
    values
      (SEQ_CECT_HS_ID.nextval,
       :new.CECT_ID,
       :new.TABLE_NAME,
       :new.COLUMN_NAME,
       :new.DELETE_WHERE_CLAUSE,
       :new.DAYS_TILL_DELETE,
       :new.START_DATE,
       :new.END_DATE,
       :new.CREATED_TS,
       :new.LAST_UPDATE_TS,
       :new.ARC_FLAG,
       :new.ARC_TABLE,
       sysdate,
       sysdate,
       v_change_type);
       
  elsif deleting then

    insert into CORP_ETL_CLEAN_TABLE_HS
      (CECT_HS_ID, 
       CECT_ID,
       TABLE_NAME,
       COLUMN_NAME,
       DELETE_WHERE_CLAUSE,
       DAYS_TILL_DELETE,
       START_DATE,
       END_DATE,
       CREATED_TS,
       LAST_UPDATE_TS,
       ARC_FLAG,
       ARC_TABLE,
       HS_CREATED_TS,
       HS_LAST_UPDATE_TS,
       HS_ACTION)
    values 
      (SEQ_CECT_HS_ID.nextval,
       :old.CECT_ID,
       :old.TABLE_NAME,
       :old.COLUMN_NAME,
       :old.DELETE_WHERE_CLAUSE,
       :old.DAYS_TILL_DELETE,
       :old.START_DATE,
       :old.END_DATE,
       :old.CREATED_TS,
       :old.LAST_UPDATE_TS,
       :old.ARC_FLAG,
       :old.ARC_TABLE,    
       sysdate, 
       sysdate,
       v_change_type);
       
  end if;

exception
  when OTHERS then
  raise;
   
end; 
/

/* Not finished testing.
create or replace trigger TRG_AIU_CORP_ETL_JOB_STAT
after insert or update on CORP_ETL_JOB_STATISTICS
for each row
declare
  v_procedure_name varchar2(61) := 'TRG_AIU_CORP_ETL_JOB_STAT';
  v_sql_code number := null;
  v_log_message clob := null;
  v_bsl_id number := null;
begin

  if inserting then
      
    begin
    
      select bsl.BSL_ID
      into v_bsl_id
      from CORP_ETL_LIST_LKUP cell
      inner join BPM_EVENT_MASTER bem on bem.BPROL_ID = cell.REF_ID and cell.VALUE = :new.JOB_NAME
      inner join BPM_SOURCE_LKUP bsl on bsl.BSL_ID = bem.BEM_ID;
      
    exception
    
      -- Not an ETL job that BPM queue processing needs to sync to.
      when NO_DATA_FOUND then
        return;
      
    end;
    
    update MAXDAT_PROCESSING_STATE
    set ETL_CEJS_JOB_ID_STARTED = :new.JOB_ID
    where BSL_ID = v_bsl_id;
    
    commit;
    
    v_log_message := 'Insert trigger CEJS.JOB_ID=' || :new.JOB_ID ||' JOB_STATUS_CD=' || :new.JOB_STATUS_CD;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,v_bsl_id,null,null,null,v_log_message,null);

  elsif updating and :new.JOB_STATUS_CD = 'COMPLETED' then
      
    begin
    
      select bsl.BSL_ID
      into v_bsl_id
      from CORP_ETL_LIST_LKUP cell
      inner join BPM_EVENT_MASTER bem on bem.BPROL_ID = cell.REF_ID and cell.VALUE = :new.JOB_NAME
      inner join BPM_SOURCE_LKUP bsl on bsl.BSL_ID = bem.BEM_ID;
      
    exception
    
      -- Not an ETL job that BPM queue processing needs to sync to.
      when NO_DATA_FOUND then
        return;
      
    end;
    
    update MAXDAT_PROCESSING_STATE
    set ETL_CEJS_JOB_ID_COMPLETED = :new.JOB_ID
    where BSL_ID = v_bsl_id;
    
    commit;

  end if;
  
exception

  when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,null,null,v_log_message,v_sql_code);   

end;
/
*/

-- Trigger previously named TRG_R_AIUD_ETL_LIST_LKUP_HIST.
create or replace trigger TRG_ADIU_CORP_ETL_LIST_LKUP
after insert or update or delete on CORP_ETL_LIST_LKUP
for each row
begin

  if inserting then
    insert into CORP_ETL_LIST_LKUP_HIST
      (CELL_HISTORY_ID,
       HIST_TYPE,
       CELL_ID,
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
      (CELL_HISTORY_SEQ.nextval,
       'INSERT',
       :new.CELL_ID,
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
    insert into CORP_ETL_LIST_LKUP_HIST 
      (CELL_HISTORY_ID,
       HIST_TYPE,
       CELL_ID,
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
      (CELL_HISTORY_SEQ.nextval,
       'UPDATE',
       :old.CELL_ID,
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
    insert into CORP_ETL_LIST_LKUP_HIST
      (CELL_HISTORY_ID,
       HIST_TYPE,
       CELL_ID,
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
      (CELL_HISTORY_SEQ.nextval,
       'DELETE',
       :old.CELL_ID,
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


-- Trigger previously named "cect_biur_trg".
create or replace trigger TRG_BIU_CORP_ETL_CLEAN
before insert or update on CORP_ETL_CLEAN_TABLE
for each row
begin
  if INSERTING then
    if :new.CECT_ID is null then
      :new.CECT_ID := SEQ_CECT_ID.nextval;
    end if;
    :new.CREATED_TS := sysdate;
  end if;
  :new.LAST_UPDATE_TS := sysdate;
end;
/


-- Trigger previously named "TRG_cec".
create or replace trigger TRG_BIU_CORP_ETL_CONTROL 
before insert or update on CORP_ETL_CONTROL 
for each row
begin
  if inserting then
    :new.CREATED_TS := sysdate;
  end if;
  :new.UPDATED_TS := sysdate;
end;
/

-- Trigger previously named TRG_BIUR_CORP_ETL_ERROR_LOG.
create or replace trigger TRG_BIU_CORP_ETL_ERROR_LOG
before insert or update on CORP_ETL_ERROR_LOG
for each row
begin
  if inserting then
    if :new.CEEL_ID is null then
      :new.CEEL_ID := SEQ_CEEL_ID.nextval;
    end if;
    if :new.CREATE_TS is null then
      :new.CREATE_TS := sysdate;
    end if;
  end if;
  :new.UPDATE_TS := sysdate;
end;
/


-- Trigger previously named TRG_R_ETL_LIST_LKUP.
create or replace trigger TRG_BIU_CORP_ETL_LIST_LKUP
before insert or update on CORP_ETL_LIST_LKUP
for each row
begin
  if inserting then
    if :new.CELL_ID is null then
      :new.CELL_ID := SEQ_CELL_ID.nextval;
    end if;
    if :new.CREATED_TS is null then
      :new.CREATED_TS := sysdate;
    end if;
  end if;
  :new.UPDATED_TS := sysdate;
end;
/


-- Trigger previously named CORP_INSTANCE_CLEANUP_TABLE.
create or replace trigger TRG_BIU_CORP_INSTANCE_CLEANUP
before insert or update on CORP_INSTANCE_CLEANUP_TABLE
for each row
begin
  if inserting then
    if :new.CICT_ID is null then
      :new.CICT_ID := SEQ_CICT_ID.nextval;
    end if;
    :new.CREATED_TS := sysdate;
  end if;
  :new.LAST_UPDATE_TS := sysdate;
end;
/

alter session set plsql_code_type = interpreted;