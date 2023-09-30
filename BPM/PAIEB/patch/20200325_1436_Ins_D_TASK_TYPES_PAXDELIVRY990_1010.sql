
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
  (40137554
    ,'MAIL_IVA_DOCS'
    ,'This task is being created to allow Ops mail the IVA forms to the consumer after an IVA appointment has been completed over the phone. This is a temporary process that is being built in wake of the current health pandemic happening in the country.'
    ,'Mailroom'
    ,24 
    ,'H'
    ,12
    ,12
    ,'PA IEB Tasks');

  
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
  (40138055
    ,'Life Opt In Form Review Task'
    ,'A manual task created by any business unit and assigned to Research and Support unit to review the LIFE Opt In form that has been attached to the case/application.'
    ,'Research Unit'
    ,24 
    ,'H'
    ,12
    ,12
    ,'PA IEB Tasks');


COMMIT;

