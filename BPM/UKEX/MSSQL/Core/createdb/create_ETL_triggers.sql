use MAXDAT;
go
/*
-- Trigger for creating a record in the history table
create trigger TRG_ADIU_CORP_ETL_CLEAN
on CORP_ETL_CLEAN_TABLE 
after delete, insert, update 
as declare
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
go

-- Trigger previously named TRG_R_AIUD_ETL_LIST_LKUP_HIST.
create trigger TRG_ADIU_CORP_ETL_LIST_LKUP
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
go

-- Trigger previously named "cect_biur_trg".
create trigger TRG_BIU_CORP_ETL_CLEAN
on CORP_ETL_CLEAN_TABLE
for insert, update as
begin
set nocount on
  if INSERTING then
    :new.CREATED_TS := sysdate;
  end if;
  :new.LAST_UPDATE_TS := sysdate;
end;
go
-- Trigger previously named "TRG_cec".
create trigger TRG_BIU_CORP_ETL_CONTROL 
before insert or update on CORP_ETL_CONTROL 
for each row
begin
  if inserting then
    :new.CREATED_TS := sysdate;
  end if;
  :new.UPDATED_TS := sysdate;
end;
go
-- Trigger previously named TRG_BIUR_CORP_ETL_ERROR_LOG.
create trigger TRG_BIU_CORP_ETL_ERROR_LOG
before insert or update on CORP_ETL_ERROR_LOG
for each row
begin
  if inserting then
    if :new.CREATE_TS is null then
      :new.CREATE_TS := sysdate;
    end if;
  end if;
  :new.UPDATE_TS := sysdate;
end;
go

-- Trigger previously named TRG_R_ETL_LIST_LKUP.
create trigger TRG_BIU_CORP_ETL_LIST_LKUP
before insert or update on CORP_ETL_LIST_LKUP
for each row
begin
  if inserting then
    if :new.CREATED_TS is null then
      :new.CREATED_TS := sysdate;
    end if;
  end if;
  :new.UPDATED_TS := sysdate;
end;
go

*/
-- Trigger previously named CORP_INSTANCE_CLEANUP_TABLE.
create trigger TRG_BIU_CORP_INSTANCE_CLEANUP
on Corp_Instance_Cleanup_Table
for insert, update 
as
begin
DECLARE @action CHAR(1)

IF EXISTS (SELECT * FROM DELETED)
BEGIN
SET @action = 'D'
END
IF EXISTS (SELECT * FROM INSERTED)
BEGIN
IF (@action = 'D')
 BEGIN
  SET @action = 'U'
 END
ELSE
 BEGIN
  SET @action = 'I'
 END
END

if @action='I'
insert into Corp_Instance_Cleanup_Table(
System_name,cleanup_name,run,start_date,start_time,end_date,end_time,statement,created_ts,last_update_ts)
select System_name,cleanup_name,run,start_date,start_time,end_date,end_time,statement,getdate(),getdate() from inserted;

end;
go
