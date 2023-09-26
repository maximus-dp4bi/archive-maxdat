Alter table PP_WFM_ACTUALS add (work_subactivity varchar2(4000));
COMMENT ON COLUMN PP_WFM_ACTUALS.WORK_SUBACTIVITY IS 'A note of sub-work description or detail added to the data.';

--create view PP_WFM_ACTUALS_SV

CREATE OR REPLACE FORCE VIEW PP_WFM_ACTUALS_SV
(RT_ACTUALS_ID
,STAFF_ID
,EVENT_ID
,SOURCE_ID
,TASK_START
,TASK_CATEGORY_ID
,TASK_END
,WORK_ACTIVITY
,ANNOTATION
,CREATE_DATE
,CREATE_STAFF_ID
,MODIFY_DATE
,MODIFY_STAFF_ID
,QUEUE_ID
,EXCLUSION_FLAG	
,WORK_SUBACTIVITY 
) 
as
select 
RT_ACTUALS_ID
,STAFF_ID
,EVENT_ID
,SOURCE_ID
,TASK_START
,TASK_CATEGORY_ID
,TASK_END
,WORK_ACTIVITY
,ANNOTATION
,CREATE_DATE
,CREATE_STAFF_ID
,MODIFY_DATE
,MODIFY_STAFF_ID
,QUEUE_ID
,EXCLUSION_FLAG
,WORK_SUBACTIVITY
from PP_WFM_ACTUALS
WITH READ ONLY;

grant select on PP_WFM_ACTUALS_SV to MAXDAT_READ_ONLY; 
grant select on PP_WFM_ACTUALS_SV to DP_SCORECARD; 
grant select on PP_WFM_ACTUALS to MAXDAT_MSTR_TRX_RPT;
