CREATE OR REPLACE VIEW D_TASK_TYPES_SV
AS 
  SELECT TASK_TYPE_ID,
    TASK_NAME,
    TASK_DESCRIPTION,
    OPERATIONS_GROUP,
    SLA_DAYS,
    SLA_DAYS_TYPE,
    SLA_TARGET_DAYS,
    SLA_JEOPARDY_DAYS,
    UNIT_OF_WORK
  FROM MAXDAT_SUPPORT.D_TASK_TYPES ;
  
GRANT SELECT ON MAXDAT_SUPPORT.D_TASK_TYPES_SV TO EB_MAXDAT_REPORTS;
