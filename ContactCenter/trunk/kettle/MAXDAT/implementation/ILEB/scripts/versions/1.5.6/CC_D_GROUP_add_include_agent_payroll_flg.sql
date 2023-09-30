ALTER TABLE CC_D_GROUP ADD (INCLUDE_AGENT_PAYROLL_FLG VARCHAR2(2) DEFAULT 'Y' NOT NULL);

UPDATE CC_D_GROUP
SET INCLUDE_AGENT_PAYROLL_FLG = 'N'
WHERE GROUP_NAME IN ('CES Supervisors', 'OPS STAFF', 'Default Back Office', 'Unknown', 'CES Back Office', 'CES Leads', 'CES Managers', 'EEV Supervisors', 'EEV Managers');

COMMIT;