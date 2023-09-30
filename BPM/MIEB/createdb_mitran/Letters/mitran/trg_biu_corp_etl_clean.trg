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

