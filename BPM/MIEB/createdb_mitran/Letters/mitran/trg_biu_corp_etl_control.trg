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

