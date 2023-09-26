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
  (60026
    ,'1768 Error Resend'
    ,'Task created call back response received as IEBE100 or IEBE200 task'
    ,'Mailroom'
    ,24 
    ,'H'
    ,12
    ,12
    ,'PA IEB Tasks');
    
commit;    