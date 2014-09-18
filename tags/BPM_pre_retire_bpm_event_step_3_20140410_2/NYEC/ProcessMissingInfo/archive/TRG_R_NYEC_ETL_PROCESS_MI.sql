alter session set plsql_code_type = native;

create or replace trigger TRG_R_NYEC_ETL_PROCESS_MI
  before insert or update
  on NYEC_ETL_PROCESS_MI for each row
begin

  if INSERTING then

    if :new.NEPM_ID is null then
      select SEQ_NEPM.nextval
      into :new.NEPM_ID
      from dual;
    end if;
    
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE := sysdate;
    end if;
  end if;
  
  :new.STG_LAST_UPDATE_DATE := sysdate;

end;
/

alter session set plsql_code_type = interpreted;
