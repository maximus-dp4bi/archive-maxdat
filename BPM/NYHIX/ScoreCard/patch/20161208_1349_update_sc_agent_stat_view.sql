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
from SC_AGENT_STAT 
WITH READ ONLY
;

GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT_MSTR_TRX_RPT;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_SV TO MAXDAT_READ_ONLY;

