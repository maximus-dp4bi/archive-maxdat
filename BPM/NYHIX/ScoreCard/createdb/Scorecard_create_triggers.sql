ALTER SESSION SET CURRENT_SCHEMA = DP_SCORECARD;
show errors;


create or replace TRIGGER TRG_NYHX_AI_SC_EXCLUSION 
AFTER INSERT ON SC_EXCLUSION 
for each row
  
BEGIN
 if :new.agent_id is not null then
  update DP_SCORECARD.SC_AGENT_STAT
  set exclusion_flag = :new.exclusion_flag
  where agent_id = :new.agent_id
  and trunc(as_date) = trunc(:new.exclusion_date);
 end if;

 if :new.staff_id is not null then
  update MAXDAT.PP_WFM_ACTUALS
  set exclusion_flag = :new.exclusion_flag
  where staff_id = :new.staff_id
  and trunc(task_end) = trunc(:new.exclusion_date);
 end if; 
END;
/

