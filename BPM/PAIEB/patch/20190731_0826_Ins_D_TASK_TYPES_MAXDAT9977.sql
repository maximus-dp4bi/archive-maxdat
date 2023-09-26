
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
  (60019
    ,'No IVA Close Application'
    ,'Task created when the client does not call to schedule an IVA after the Letter to Schedule IVA is triggered task'
    ,'Mailroom'
    ,24
    ,'H'
    ,12    ,12    ,'PA IEB Tasks');


COMMIT;
