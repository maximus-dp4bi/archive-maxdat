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

