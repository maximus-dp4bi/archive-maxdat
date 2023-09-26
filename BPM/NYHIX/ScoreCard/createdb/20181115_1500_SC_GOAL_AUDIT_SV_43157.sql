CREATE OR REPLACE VIEW DP_SCORECARD.SC_GOAL_AUDIT_SV AS
SELECT
    RECORD_TYPE
    , RECORD_ACTION
    , GOAL_ID
    , STAFF_ID
    , GOAL_ENTRY_DATE
    , GTL_ID
    , GOAL_DESCRIPTION
    , GOAL_DATE
    , PROGRESS_NOTE
    , CREATE_BY
    , CREATE_DATETIME
    , LAST_UPDATED_BY
    , LAST_UPDATED_DATETIME
    , TRANSACTION_DATE
FROM DP_SCORECARD.SC_GOAL_AUDIT
WITH read only;
