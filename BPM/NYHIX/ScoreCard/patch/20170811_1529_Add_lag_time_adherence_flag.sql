ALTER TABLE SC_LAG_TIME ADD (ADHERENCE_FLAG NUMBER(1) DEFAULT NULL);

CREATE OR REPLACE VIEW DP_SCORECARD.SC_LAG_TIME_SV
AS
select
lag_date
,agent_id
--,supervisor_id
,Tot_Sched_Productive_Time
,Adherence_flag
from SC_LAG_TIME a
WHERE  create_date = (SELECT max(create_date) FROM SC_LAG_TIME b WHERE a.LAG_DATE =b.LAG_DATE AND a.AGENT_ID = b.AGENT_ID)
and not exists (select 1 from sc_exclusion_yes_sv b where a.agent_id = b.agent_id and TRUNC(a.lag_date) = TRUNC(b.exclusion_date))
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.SC_LAG_TIME_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_LAG_TIME_SV TO MAXDAT_READ_ONLY;

