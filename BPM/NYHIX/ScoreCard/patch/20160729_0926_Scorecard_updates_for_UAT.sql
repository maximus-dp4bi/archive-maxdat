grant select, insert, delete, update, references on ENGAGE_FORM_TYPE to MAXDAT;  
grant select on ENGAGE_FORM_TYPE_SV to MAXDAT; 
 grant select, insert, delete, update, references on ENGAGE_ACTUALS to MAXDAT;  
grant select on ENGAGE_ACTUALS_SV to MAXDAT; 
grant select, insert, delete, update, references on ENGAGE_ACTUALS_STG to MAXDAT; 
GRANT select, insert, update, delete on SC_EXCLUSION to MAXDAT;
GRANT select, insert, update, delete ON SC_AGENT_STAT TO MAXDAT;
GRANT select, insert, update, delete ON SC_AGENT_STAT TO MAXDAT;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_ATTENDANCE to MAXDAT;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP to MAXDAT;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE to MAXDAT;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_CORRECTIVE_ACTION_LKUP to MAXDAT;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_CORRECTIVE_ACTION to MAXDAT;
   GRANT select, insert, update, delete on DP_SCORECARD.SC_DISCUSSION_LKUP to MAXDAT;
    GRANT select, insert, update, delete on DP_SCORECARD.SC_PERFORMANCE_TRACKER to MAXDAT;
GRANT select, insert, update, delete on DP_SCORECARD.SC_GOAL_TYPE_LKUP to MAXDAT;  
GRANT select, insert, update, delete on DP_SCORECARD.SC_GOAL to MAXDAT;  

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
