create or replace trigger TRG_R_CORP_ETL_MFB_FORM_STG 
before insert or update on CORP_ETL_MFB_FORM_STG 
for each row
begin
  if inserting then
    if :new.CEMFBF_ID is null then
      :new.CEMFBF_ID := SEQ_CEMFBF_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/