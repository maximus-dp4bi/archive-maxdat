Alter table maxdat.pp_wfm_actuals add (exclusion_flag varchar2(1) default 'N');
COMMENT ON COLUMN PP_WFM_ACTUALS.EXCLUSION_FLAG IS 'Has this record been excluded.';
grant select, insert, update, delete on PP_WFM_ACTUALS to MAXDAT_MSTR_TRX_RPT;

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
from PP_WFM_ACTUALS
WITH READ ONLY;

grant select on PP_WFM_ACTUALS_SV to MAXDAT_READ_ONLY; 
grant select on PP_WFM_ACTUALS_SV to DP_SCORECARD; 
grant select on PP_WFM_ACTUALS to MAXDAT_MSTR_TRX_RPT;

-- Grant for PP_WFM_STAFF to allow DP_SCORECARD to reference table in views that reference views
grant select on PP_WFM_STAFF to DP_SCORECARD with grant option;