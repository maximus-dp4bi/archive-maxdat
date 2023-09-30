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
  (40137475
    ,'Resend HSCIS or SAMS Plan'
    ,'A manual task created by CSR role and assigned to State Data Entry Business unit for re-sending the HSCIS or SAMS plan.'
    ,'Eligibility / Data Entry'
    ,2
    ,'H'
    ,1
    ,1
    ,'Data Entry');

COMMIT;