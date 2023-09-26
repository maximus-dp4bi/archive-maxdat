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
  (3040,
    'Alternate Document VHT',
    'APS - Alternate Document Virtual Human Task',
    'Application Processing',
    10,
    'C',
    10,
    7,
    NULL);
    
    COMMIT;

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
  (31050,
    'Application Document Relink',
    'Document/Application Relink Task',
    'Research',
    3,
    'B',
    3,
    2,
    NULL);
    
    COMMIT;    

