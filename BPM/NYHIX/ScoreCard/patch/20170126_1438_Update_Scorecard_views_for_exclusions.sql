CREATE OR REPLACE VIEW DP_SCORECARD.PP_WFM_TASK_BO_SV
AS
SELECT  STAFF_ID     
,TASK_START  
,TASK_END    
,TASK_CATEGORY_ID
,DURATION    
,EVENT_ID    
,SUPERVISOR  
,TASK_MODIFICATION_REQUEST_REF
,TASK_ID
,SCENARIO_GROUP_ID
,SCHEDULE_INSTANCE_ID 
,TASK_EDIT_ID
,EDIT_STATE 
,ALT_TASK_EDIT_ID 
,NATIONAL_ID
,MAKE_DATE_TIME 
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_TASK_BO
WHERE DELETE_FLAG = 'N'
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_TASK_BO_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.PP_WFM_TASK_BO_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_EXCLUSION_YES_SV
AS
select 
exclusion_ID
,supervisor_id
,agent_id
,staff_id
,exclusion_date
,exclusion_flag
,exclusion_comment
,create_date
,Create_by
from SC_EXCLUSION s1
WHERE exclusion_flag = 'Y'
AND EXCLUSION_ID = (SELECT max(exclusion_id) 
                    FROM SC_EXCLUSION s2 
                    WHERE s2.agent_id = s1.AGENT_ID 
                    AND s2.EXCLUSION_DATE = s1.EXCLUSION_DATE)
WITH READ ONLY;

grant select on dp_scorecard.SC_EXCLUSION_YES_SV to maxdat with grant option;
GRANT SELECT ON DP_SCORECARD.SC_EXCLUSION_YES_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_AGENT_STAT_SV
AS
select
AS_Date
,Agent_ID
--,Supervisor_ID
,Calls_Answered
,Short_Calls_Answered
,Average_Handle_time
,(Tot_Return_to_Queue + Tot_Return_to_Queue_Timeout) as Tot_Return_to_Queue
,Tot_Return_to_Queue_Timeout
,(Tot_Return_to_Queue + Tot_Return_to_Queue_Timeout) as Tot_Ret_to_Queue_Total
,Tot_Sched_Productive_Time
,Actual_Productive_Time
,Talk_Time
,Wrap_Up_Time
,Logged_in_Time
,Not_Ready_Time
,Break_Time
,Lunch_Time
,EXCLUSION_FLAG
from SC_AGENT_STAT a11
where not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and TRUNC(a11.as_date) = TRUNC(b.exclusion_date))
WITH READ ONLY;

GRANT REFERENCES ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT_MSTR_TRX_RPT;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_LAG_TIME_SV
AS
select
lag_date
,agent_id
--,supervisor_id
,Tot_Sched_Productive_Time
from SC_LAG_TIME a
WHERE  create_date = (SELECT max(create_date) FROM SC_LAG_TIME b WHERE a.LAG_DATE =b.LAG_DATE AND a.AGENT_ID = b.AGENT_ID)
and not exists (select 1 from sc_exclusion_yes_sv b where a.agent_id = b.agent_id and TRUNC(a.lag_date) = TRUNC(b.exclusion_date))
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.SC_LAG_TIME_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_LAG_TIME_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_NON_STD_USE_SV
AS
select 
Call_Record_ID 
,Customer_count  
,Call_Wrap_up_count 
,Call_Date  
,Call_Time  
,Employee_ID    
,CALL_DT
from SC_NON_STD_USE a
where not exists (select 1 from sc_exclusion_yes_sv b where a.Employee_id = b.agent_id and TRUNC(a.CALL_dt) = TRUNC(b.exclusion_date))
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.SC_NON_STD_USE_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_NON_STD_USE_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW DP_SCORECARD.SC_WRAP_UP_ERROR_SV
AS
select 
WUE_Date        
,Agent_ID       
,Wrap_up_error  
from SC_WRAP_UP_ERROR a
where not exists (select 1 from sc_exclusion_yes_sv b where a.agent_id = b.agent_id and TRUNC(a.wue_date) = TRUNC(b.exclusion_date))
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.SC_WRAP_UP_ERROR_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_WRAP_UP_ERROR_SV TO MAXDAT_READ_ONLY;

