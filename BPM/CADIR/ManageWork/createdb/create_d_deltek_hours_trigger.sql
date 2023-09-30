alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_D_DELTEK_HOURS 
before insert or update on D_DELTEK_HOURS 
for each row 

begin 
  
  if inserting then     
          if :new.DDH_ID is null then
             :new.DDH_ID := seq_ddh_id.nextval;
          end if; 
          :new.MAXDAT_AUDIT_CREATE_DT := SYSDATE;
          :new.MAXDAT_AUDIT_UPDATE_DT := SYSDATE;
    
        end if;
  
     if updating then 
          :new.MAXDAT_AUDIT_UPDATE_DT :=SYSDATE;
      end if;
end;
/

alter session set plsql_code_type = interpreted;