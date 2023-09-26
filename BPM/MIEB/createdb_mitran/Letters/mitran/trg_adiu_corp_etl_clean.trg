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

