-- FLHK MailFaxBatch specific triggers.
-- Originally generated (incorrect action) by exporting DDL from database after manual install of triggers.
-- Some of these may have already been installed by other scripts and some or all of these triggers should be removed from the file.
-- This script should be deployed after installing svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/MailFaxBatch/createdb/create_ETL_MailFaxBatch_triggers.sql

alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_CORP_ETL_MFB_BATCH
before insert or update on CORP_ETL_MFB_BATCH
for each row 
begin 
  if inserting then 
    if :new.CEMFBB_ID is null then
      :new.CEMFBB_ID := SEQ_CEMFBB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


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
  when others then
  raise;
   
end; 
/


create or replace trigger TRG_BIU_CORP_ETL_CLEAN  
before insert or update on CORP_ETL_CLEAN_TABLE
for each row
begin
  if inserting then
    if :new.CECT_ID is null then
      :new.CECT_ID := SEQ_CECT_ID.nextval;
    end if;
    :new.CREATED_TS := sysdate;
  end if;
  :new.LAST_UPDATE_TS := sysdate;
end;
/


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


create or replace trigger TRG_CEEL_ID 
before insert on CORP_ETL_ERROR_LOG 
for each row
begin
   if inserting then
     if :new.CEEL_ID is null then
        select CEEL_ID_SEQ.nextval into :new.CEEL_ID from dual;
     end if;
   end if;
 end;
/


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


create or replace trigger HOLIDAYS_TRG 
before insert on HOLIDAYS 
for each row 
begin
  if inserting then
    if :new.HOLIDAY_ID is null then          
      select HOLIDAYS_SEQ.nextval into :new.HOLIDAY_ID from dual;
    end if; 
  end if;
end;
/


create or replace trigger TRG_BIU_CORP_ETL_MFB_BATCH
before insert or update on CORP_ETL_MFB_BATCH
for each row 
begin
  if inserting then
    if :new.CEMFBB_ID is null then
      :new.CEMFBB_ID := SEQ_CEMFBB_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


create or replace trigger TRG_BIU_ETL_MFB_BATCH_EVENT
before insert or update on CORP_ETL_MFB_BATCH_EVENTS
for each row 
begin
  if inserting then 
    if :new.CEMFBBE_ID is null then
      :new.CEMFBBE_ID := SEQ_CEMFBBE_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/

alter session set plsql_code_type = interpreted;   