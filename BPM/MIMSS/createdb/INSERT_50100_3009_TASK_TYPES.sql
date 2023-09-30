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
  (50100,
    'Initial Case Audit Vetting',
    'Initial Case Audit Vetting',
    'Application Processing',
    1,
    'C',
    1,
    0,
    NULL);
    
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
  (3009,
    'Application Problem Resolution',
    'APS - Application Research new',
    'Research',
    1,
    'B',
    1,
    0,
    NULL);
    

    COMMIT;
