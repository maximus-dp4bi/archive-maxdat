CREATE OR REPLACE VIEW DP_SCORECARD.ENGAGE_ACTUALS_SV
AS
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
WHERE DELETED_FLAG != 'Y'
OR DELETED_FLAG IS NULL
WITH READ ONLY;

GRANT REFERENCES ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.ENGAGE_ACTUALS_SV TO MAXDAT_READ_ONLY;
