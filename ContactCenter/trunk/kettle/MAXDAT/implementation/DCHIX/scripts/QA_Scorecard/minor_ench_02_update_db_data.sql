UPDATE dp_scorecard_dchix.ts_audit ta
SET    
    AUDIT_CALL_HOUR_AM_PM = 0
WHERE
    AUDIT_CALL_HOUR < 12 AND
    AUDIT_CALL_HOUR_AM_PM IS NULL;
    
UPDATE dp_scorecard_dchix.ts_audit ta
SET    
    AUDIT_CALL_HOUR_AM_PM = 1
WHERE
    AUDIT_CALL_HOUR = 12 AND
    AUDIT_CALL_HOUR_AM_PM IS NULL;
    
UPDATE dp_scorecard_dchix.ts_audit ta
SET
    AUDIT_CALL_HOUR = AUDIT_CALL_HOUR - 12,
    AUDIT_CALL_HOUR_AM_PM = 1
WHERE
    AUDIT_CALL_HOUR > 12 AND
    AUDIT_CALL_HOUR_AM_PM IS NULL;

UPDATE dp_scorecard_dchix.ts_audit ta
SET    
    AUDIT_CALL_HOUR = 12
WHERE
    AUDIT_CALL_HOUR = 0;

commit;