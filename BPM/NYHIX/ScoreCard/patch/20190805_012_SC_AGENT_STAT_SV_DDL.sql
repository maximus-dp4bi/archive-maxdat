
CREATE OR REPLACE FORCE EDITIONABLE VIEW DP_SCORECARD.SC_AGENT_STAT_SV 
(AS_DATE, AGENT_ID, CALLS_ANSWERED, SHORT_CALLS_ANSWERED, AVERAGE_HANDLE_TIME, 
TOT_RETURN_TO_QUEUE, TOT_RETURN_TO_QUEUE_TIMEOUT, TOT_RET_TO_QUEUE_TOTAL, TOT_SCHED_PRODUCTIVE_TIME, 
ACTUAL_PRODUCTIVE_TIME, TALK_TIME, WRAP_UP_TIME, LOGGED_IN_TIME, NOT_READY_TIME, BREAK_TIME, LUNCH_TIME, 
CALLS_OFFERED, EXCLUSION_FLAG, AGENT_DISCONNECTED_SHORT_CALLS, CONSUMER_DISCONNECTED_SHORT_CALLS
) AS 
  SELECT
AS_DATE
,AGENT_ID
--,SUPERVISOR_ID
,CALLS_ANSWERED
,SHORT_CALLS_ANSWERED
,AVERAGE_HANDLE_TIME
,(TOT_RETURN_TO_QUEUE + TOT_RETURN_TO_QUEUE_TIMEOUT) AS TOT_RETURN_TO_QUEUE
,TOT_RETURN_TO_QUEUE_TIMEOUT
,(TOT_RETURN_TO_QUEUE + TOT_RETURN_TO_QUEUE_TIMEOUT) AS TOT_RET_TO_QUEUE_TOTAL
,TOT_SCHED_PRODUCTIVE_TIME
,ACTUAL_PRODUCTIVE_TIME
,TALK_TIME
,WRAP_UP_TIME
,LOGGED_IN_TIME
,NOT_READY_TIME
,BREAK_TIME
,LUNCH_TIME
,CALLS_OFFERED  
,EXCLUSION_FLAG
,AGENT_DISCONNECTED_SHORT_CALLS
,CONSUMER_DISCONNECTED_SHORT_CALLS
FROM SC_AGENT_STAT A11
WHERE NOT EXISTS 
	(SELECT 1 FROM SC_EXCLUSION_YES_SV B 
	WHERE A11.AGENT_ID = B.AGENT_ID 
	AND TRUNC(A11.AS_DATE) = TRUNC(B.EXCLUSION_DATE)
	)
WITH READ ONLY;
