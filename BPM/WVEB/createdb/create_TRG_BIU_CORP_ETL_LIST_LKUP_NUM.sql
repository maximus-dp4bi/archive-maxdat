create or replace TRIGGER "TRG_BIU_CORP_ETL_LIST_LKUP_NUM" 
before insert or update on CORP_ETL_LIST_LKUP_NUM
for each row
begin
  if inserting then
    if :new.CELLN_ID is null then
      :new.CELLN_ID := SEQ_CELLN_ID.nextval;
    end if;
    if :new.CREATED_TS is null then
      :new.CREATED_TS := sysdate;
    end if;
  end if;
  :new.UPDATED_TS := sysdate;
end;