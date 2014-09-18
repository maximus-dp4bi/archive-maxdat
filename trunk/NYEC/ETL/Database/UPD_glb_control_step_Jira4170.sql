-- Step_Instance_Stg control for identifying records to pick up for initial
-- processing of reason codes since Jan 2013. Originally for UAT-only
-- Need to subtract identified value by 1. Kettle uses history ID greater than value.

UPDATE  corp_etl_control SET VALUE = '10879814'
 WHERE name = 'REASON_CD_LAST_STEP_HIST_ID';
COMMIT;
