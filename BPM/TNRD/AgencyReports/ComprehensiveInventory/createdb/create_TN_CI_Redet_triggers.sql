alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_TN_CI_REDET
before insert or update on TN_CI_REDETERMINATION
for each row
begin

  if inserting then
   
    if
	   :new.CREATE_DATE is null then :new.CREATE_DATE  := sysdate;
    end if;

  end if;

  :new.UPDATE_DATE := sysdate;
end; 
/

alter session set plsql_code_type = interpreted;