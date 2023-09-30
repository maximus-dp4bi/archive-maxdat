
update   cc_d_activity_type
set IS_READY_FLAG = 0,IS_ABSENCE_FLAG = 0
where ACTIVITY_TYPE_NAME = 'Unknown';

update cc_d_activity_type 
set ACTIVITY_TYPE_CATEGORY = 'Unscheduled PTO'
where ACTIVITY_TYPE_CATEGORY = 'Unknown'
and ACTIVITY_TYPE_NAME = 'Tardy';

update cc_d_activity_type 
set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready'
where ACTIVITY_TYPE_CATEGORY = 'Unknown'
and ACTIVITY_TYPE_NAME = 'zPending Logout';

update cc_d_activity_type 
set ACTIVITY_TYPE_CATEGORY = 'Working Contact',
IS_PAID_FLAG = 1, IS_AVAILABLE_FLAG = 1, IS_READY_FLAG = 1 
where ACTIVITY_TYPE_CATEGORY = 'Unknown'
and ACTIVITY_TYPE_NAME = 'ACW';

update cc_d_activity_type 
set ACTIVITY_TYPE_CATEGORY = 'Other Not Ready'
where ACTIVITY_TYPE_CATEGORY = 'Unknown'
and ACTIVITY_TYPE_NAME = 'Technical-Problems (IT) (Cisco Code 11)';

update cc_d_activity_type 
set ACTIVITY_TYPE_CATEGORY = 'Working Contact'
where ACTIVITY_TYPE_CATEGORY = 'Unknown'
and ACTIVITY_TYPE_NAME = 'Hold';

UPDATE cc_d_activity_type 
set IS_AVAILABLE_FLAG = 0, IS_READY_FLAG = 0 
where ACTIVITY_TYPE_NAME in 
(  'Blended'
  ,'CHIP Outbound Project'
  ,'Deferred'
  ,'Deleted Timeline'
  ,'EB Tech On Call'
  ,'EB Tech Ready'
  ,'EB Tech Sup Queue'
  ,'EB VM Special Projects (Cisco Code 6)'
  ,'EB WFM Ready'
  ,'ES CHIP Outbound'
  ,'Generic Non-Work Activity'
  ,'Generic Work Activity'
  ,'Learning Break'
  ,'Learning End'
  ,'Password Reset'
  ,'Pending Logout'
  ,'QC Escalation'
  ,'S.M.E./Manager Relief (Cisco Code 7)'
  ,'Shift/Overtime Gap'
  ,'THS VM Special Projects (Cisco Code 6)'  );
   
UPDATE cc_d_activity_type 
set IS_PAID_FLAG = 1
where ACTIVITY_TYPE_NAME = 'Scheduled One on One';

UPDATE cc_d_activity_type 
set IS_AVAILABLE_FLAG = 0
where ACTIVITY_TYPE_NAME = 'General Absence';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','121','121_UPDATE_ACTIVITY_TYPES_FOR_ES');

commit;