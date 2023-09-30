alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_D_SUPERVISOR 
before insert or update on D_SUPERVISOR 

for each row 
declare v_count number :=0;

begin 
  
	if inserting then     
      		:new.CREATE_TS := SYSDATE;
      		:new.LAST_UPDATE_TS := SYSDATE;
    
        end if;
  
   	if updating then 
      		:new.LAST_UPDATE_TS :=SYSDATE;
    	end if;

--if new.supervisor_person_id does not already exist in the teams table, create a new row in the d_teams table for this supervisor
select count(te.team_id) into v_count from d_teams te where te.team_supervisor_staff_id = :new.supervisor_person_id;
if v_count = 0 then
insert into d_teams 
select stf.staff_id as team_id, 
stf.first_name || ' ' ||case when stf.middle_name is not null then stf.middle_name || ' ' else '' end || stf.last_name as team_name,
stf.first_name || ' ' ||case when stf.middle_name is not null then stf.middle_name || ' ' else '' end || stf.last_name as team_description,
stf.staff_id as team_supervisor_staff_id
from d_staff stf
where stf.staff_id = :new.supervisor_person_id; 

end if;

end;
/


alter session set plsql_code_type = interpreted;
