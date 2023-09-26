
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."SC_AGENT_STAT_SV" ("AS_DATE", "AGENT_ID", "CALLS_ANSWERED", "SHORT_CALLS_ANSWERED", "AVERAGE_HANDLE_TIME", "TOT_RETURN_TO_QUEUE", "TOT_RETURN_TO_QUEUE_TIMEOUT", "TOT_RET_TO_QUEUE_TOTAL", "TOT_SCHED_PRODUCTIVE_TIME", "ACTUAL_PRODUCTIVE_TIME", "TALK_TIME", "WRAP_UP_TIME", "LOGGED_IN_TIME", "NOT_READY_TIME", "BREAK_TIME", "LUNCH_TIME", "CALLS_OFFERED", "EXCLUSION_FLAG") AS 
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
,Calls_Offered
,EXCLUSION_FLAG
from SC_AGENT_STAT a11
where not exists (select 1 from sc_exclusion_yes_sv b where a11.agent_id = b.agent_id and TRUNC(a11.as_date) = TRUNC(b.exclusion_date))
WITH READ ONLY;
