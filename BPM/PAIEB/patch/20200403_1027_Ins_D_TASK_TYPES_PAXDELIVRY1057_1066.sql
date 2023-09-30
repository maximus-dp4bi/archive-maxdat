
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
  (40137574
    ,'CHC_DELAYED_PLAN_TRANSFER'
    ,'State has asked MAXIMUS to put a temporary hold on CHC Plan Transfer process. This task will allow call center workers to create this manual task instead of completing the plan transfer request received from the consumer'
    ,'CHC Delayed Plan Transfer'
    ,24 
    ,'D'
    ,180
    ,180
    ,'PA CHC Manual Tasks');

UPDATE d_task_types
SET task_description = 'This task is to have a Harmony 1768 resent. This can be due to the CAO calling in and requesting one or if certain information is changed that requres this to occur.'
,sla_target_days = 12
,sla_jeopardy_days = 12
WHERE task_type_id = 40137227;

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
  (60025
    ,'Waiver Received - Restart Application'
    ,'Task created when the waiver code is received to restart application task'
    ,'Mailroom'
    ,24 
    ,'H'
    ,12
    ,12
    ,'PA IEB Tasks');

COMMIT;

