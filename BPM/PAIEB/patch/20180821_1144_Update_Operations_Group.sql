/* MAXDAT-7657-Fixing Ops Group Configuration - 'CHC Date Entry' typo */
UPDATE D_TASK_TYPES 
SET OPERATIONS_GROUP='CHC Data Entry'
WHERE OPERATIONS_GROUP='CHC Date Entry';
COMMIT;
