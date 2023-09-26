Alter table DP_SCORECARD.ENGAGE_ACTUALS_STG add (CALL_DATE DATE);

Alter table DP_SCORECARD.ENGAGE_ACTUALS add (CALL_DATE DATE);

CREATE OR REPLACE FORCE VIEW ENGAGE_ACTUALS_SV
(evaluation_reference_id
 ,evaluation_reference
 ,agent_id
 ,evaluator_id
 ,score_total
 ,evaluation_date_time 
 ,evaluation_form
 ,call_date
 ,create_by
 ,create_datetime
 ,last_update_date 
 ,last_updated_by	
 ,deleted_flag
) 
as
select 
evaluation_reference_id
 ,evaluation_reference
 ,agent_id
 ,evaluator_id
 ,score_total
 ,evaluation_date_time 
 ,evaluation_form
 ,call_date
 ,create_by
 ,create_datetime
 ,last_update_date 
 ,last_updated_by
 ,deleted_flag
from ENGAGE_ACTUALS
WITH READ ONLY;

