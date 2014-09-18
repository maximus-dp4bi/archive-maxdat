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
