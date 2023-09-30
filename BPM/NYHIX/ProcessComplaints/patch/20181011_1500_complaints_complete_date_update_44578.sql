-- NYHIX-44578
-- Complaints
SELECT *
FROM   maxdat.CORP_ETL_COMPLAINTS_INCIDENTS
WHERE  incident_id IN (select distinct IDENTIFIER  -- 1737 records
                       from   maxdat.BPM_LOGGING
                       WHERE  bsl_id =22
                       and    MESSAGE like 'ORA-20063%'
                       and    LOG_DATE >= (sysdate - 30));


UPDATE maxdat.CORP_ETL_COMPLAINTS_INCIDENTS
SET    COMPLETE_DT = SYSDATE, 
       STAGE_DONE_DT = SYSDATE,
       STG_LAST_UPDATE_DATE = SYSDATE,
       UPDATED_BY = 'NYHIX-44578'
WHERE  incident_id IN (select distinct IDENTIFIER  -- 1737 records
                       from   maxdat.BPM_LOGGING
                       WHERE  bsl_id =22
                       and    MESSAGE like 'ORA-20063%'
                       and    LOG_DATE >= (sysdate - 30));

COMMIT;
