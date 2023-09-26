INSERT INTO MAXDAT_SUPPORT.D_TASK_TYPES
  ( TASK_TYPE_ID,
    TASK_NAME,
    TASK_DESCRIPTION,
    OPERATIONS_GROUP,
    SLA_DAYS,
    SLA_DAYS_TYPE,
    SLA_TARGET_DAYS,
    SLA_JEOPARDY_DAYS,
    UNIT_OF_WORK)
  VALUES
  (3001,
    'HSDE-QC',
    'APS - High Speed Data Entry Quality Control',
    'Quality Control',
    1,
    'B',
    1,
    0,
    NULL);
    
    COMMIT;
