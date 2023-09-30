SET DEFINE OFF;
    
INSERT
INTO MAXDAT_SUPPORT.D_TASK_TYPES
  (
    TASK_TYPE_ID,
    TASK_NAME,
    TASK_DESCRIPTION,
    OPERATIONS_GROUP,
    SLA_DAYS,
    SLA_DAYS_TYPE,
    SLA_TARGET_DAYS,
    SLA_JEOPARDY_DAYS,
    UNIT_OF_WORK
  )
  VALUES
  (40137534
    ,'Obtain New PA600 Form'
    ,'With the IVA visit moved to beginning of the app process, any PA600 forms received can expire by the time app reaches to ''App Review in Process''. This task allows a worker to proactively reach out to EB unit to get a new signed PA600 from the applicant.'
    ,'Assessors Unit'
    ,168 
    ,'H'
    ,84
    ,84
    ,'Application Review');

COMMIT;

