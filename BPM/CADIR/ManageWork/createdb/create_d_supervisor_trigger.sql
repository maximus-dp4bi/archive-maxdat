alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_D_SUPERVISOR 
before insert or update on D_SUPERVISOR 
for each row 

begin 
  
	if inserting then     
      		:new.CREATE_TS := SYSDATE;
      		:new.LAST_UPDATE_TS := SYSDATE;
    
        end if;
  
   	if updating then 
      		:new.LAST_UPDATE_TS :=SYSDATE;
    	end if;
end;
/


alter session set plsql_code_type = interpreted;
