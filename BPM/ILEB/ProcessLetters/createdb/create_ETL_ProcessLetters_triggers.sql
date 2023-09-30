alter session set plsql_code_type = native;

create or replace trigger TRG_R_CORP_ETL_PROC_LETTER 
before insert or update on CORP_ETL_PROC_LETTERS 
for each row
begin
  if inserting then
    if :new.CEPN_ID is null then
      :new.CEPN_ID := SEQ_CEPN_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


create or replace trigger TRG_R_CORP_ETL_PROC_LTR_OLTP before
insert or update on CORP_ETL_PROC_LETTERS_OLTP 
for each row
begin
  if inserting then
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


create or replace trigger TRG_R_CORP_ETL_PROC_LTR_WIP 
before insert or update on CORP_ETL_PROC_LETTERS_WIP_BPM 
for each row
begin
  if inserting then
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/

alter session set plsql_code_type = interpreted;