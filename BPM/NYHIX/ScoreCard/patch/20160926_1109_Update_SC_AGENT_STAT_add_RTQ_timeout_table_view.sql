Alter table sc_Agent_stat add (tot_return_to_queue_timeout number(6,0));

CREATE OR REPLACE FORCE VIEW SC_AGENT_STAT_SV
(AS_Date 
,Agent_ID 
,Supervisor_ID 
,Calls_Answered 
,Short_Calls_Answered
,Average_Handle_time 
,Tot_Return_to_Queue 
,Tot_Return_to_Queue_Timeout
,Tot_Sched_Productive_Time 
,Actual_Productive_Time 
,Talk_Time
,Wrap_Up_Time 
,Logged_in_Time 
,Not_Ready_Time
,Break_Time 
,Lunch_Time 
,EXCLUSION_FLAG 
) 
as
select 
AS_Date 
,Agent_ID 
,Supervisor_ID 
,Calls_Answered 
,Short_Calls_Answered
,Average_Handle_time 
,Tot_Return_to_Queue 
,Tot_Return_to_Queue_Timeout
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
WITH READ ONLY;

