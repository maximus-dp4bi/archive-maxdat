ALTER TABLE engage_actuals
ADD (deleted_flag VARCHAR2(1));

CREATE INDEX ENGAGEACTUALS_EVALDT ON ENGAGE_ACTUALS(EVALUATION_DATE_TIME) TABLESPACE MAXDAT_INDX;
CREATE INDEX ENGAGEACTUALS_EVALREF ON ENGAGE_ACTUALS(EVALUATION_REFERENCE) TABLESPACE MAXDAT_INDX;

CREATE OR REPLACE FORCE VIEW ENGAGE_ACTUALS_SV
(evaluation_reference_id
 ,evaluation_reference
 ,agent_id
 ,evaluator_id
 ,score_total
 ,evaluation_date_time 
 ,evaluation_form
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
 ,create_by
 ,create_datetime
 ,last_update_date 
 ,last_updated_by
 ,deleted_flag
from ENGAGE_ACTUALS
WITH READ ONLY;

grant select on ENGAGE_ACTUALS_SV to MAXDAT_READ_ONLY; 
grant select on ENGAGE_ACTUALS_SV to DP_SCORECARD;