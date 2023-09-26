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

