set echo on

------------------------------------------------------------------
-- USE THE AGENT_STAFF_ID AND PAYROLL_AUDIT_DATE TO DETERMINE THE SUPERVISOR
------------------------------------------------------------------

UPDATE DP_SCORECARD.SC_AUDIT_PAYROLL  X
SET X.SUPERVISOR_STAFF_ID 
    = ( SELECT SUPERVISOR_ID 
        FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF Y
        WHERE Y.STAFF_ID = X.AGENT_STAFF_ID
        AND X.payroll_AUDIT_DATE BETWEEN Y.EFFECTIVE_DATE AND Y.ADJUSTED_END_DATE 
		group by supervisor_id
		having sum(1) = 1
        );


COMMIT;

------------------------------------------------------------------
-- For any that were not found use the current values from 
-- PAYROLL_AUDIT_CREATE_USER
------------------------------------------------------------------


UPDATE DP_SCORECARD.SC_AUDIT_PAYROLL
SET SUPERVISOR_STAFF_ID = payroll_AUDIT_CREATE_USER
WHERE SUPERVISOR_STAFF_ID IS NULL;

COMMIT;

------------------------------------------------------------------
-- CLEAN OUT THE BAD DATA ( THE DATES ARE GOOD ) BUT THE USER IS BAD
-- NOTE THAT THIS IS NOT BEING DONE FOR THE AUDIT TABLE
------------------------------------------------------------------

UPDATE DP_SCORECARD.SC_AUDIT_PAYROLL
SET payroll_AUDIT_CREATE_USER = 'UNKNOWN',
	payroll_AUDIT_UPDATE_USER = 'UNKNOWN'
	WHERE SUPERVISOR_STAFF_ID IS NOT NULL;
	
	
COMMIT;

--------------------------------------------------------------------- 
-- do the same updates for the audit table
--------------------------------------------------------------------- 

UPDATE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT  X
SET X.SUPERVISOR_STAFF_ID 
    = ( SELECT SUPERVISOR_ID 
        FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF Y
        WHERE Y.STAFF_ID = X.AGENT_STAFF_ID
        AND X.payroll_AUDIT_DATE BETWEEN Y.EFFECTIVE_DATE AND Y.ADJUSTED_END_DATE 
		group by supervisor_id
		having sum(1) = 1
        );


COMMIT;

------------------------------------------------------------------
-- For any that were not found use the current values from 
-- PAYROLL_AUDIT_CREATE_USER
------------------------------------------------------------------


UPDATE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT
SET SUPERVISOR_STAFF_ID = PAYROLL_AUDIT_CREATE_USER
WHERE SUPERVISOR_STAFF_ID IS NULL;

COMMIT;

------------------------------------------------------------------
-- CLEAN OUT THE BAD DATA ( THE DATES ARE GOOD ) BUT THE USER IS BAD
-- NOTE THAT THIS IS NOT BEING DONE FOR THE AUDIT TABLE
------------------------------------------------------------------

UPDATE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT
SET PAYROLL_AUDIT_CREATE_USER = 'UNKNOWN',
	PAYROLL_AUDIT_UPDATE_USER = 'UNKNOWN'
	WHERE SUPERVISOR_STAFF_ID IS NOT NULL;
	
	
COMMIT;

