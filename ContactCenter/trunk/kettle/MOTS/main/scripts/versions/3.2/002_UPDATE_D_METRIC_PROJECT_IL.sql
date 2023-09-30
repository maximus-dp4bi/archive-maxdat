update d_metric_project
set actual_value_provided_by = 'AUTO_LOAD'
where d_metric_project_id in (
  select d_metric_project_id
  from d_project p 
  inner join d_metric_project mp on p.d_project_id = mp.d_project_id
  inner join d_metric_definition md on mp.d_metric_definition_id = md.d_metric_definition_id
  where project_name like 'IL%'
  and md.name in (
      'AB Rate'
     ,'AHT'
     ,'ASA'
     ,'AT_WORK_NOT_HANDLING_CONTACTS_PERCENTAGE'
     ,'AVERAGE_ABANDON_WAIT_TIME'
     ,'CALLS_HANDLED'
     ,'Calls Offered'
     ,'DAYS_OF_OPERATION'
     ,'MAX_NUMBER_OF_AGENTS_AVAILABLE_TO_HANDLE_CONTACTS'
     ,'MAX_SPEED_TO_ANSWER'
     ,'OUTBOUND_CALLS_ATTEMPTED'
     ,'Occupancy'
     ,'PEAK_DAY_PERCENTAGE'
     ,'PEAK_WEEK_PERCENTAGE'
     ,'Utilization'
     ,'VOICE_MAILS_CREATED'
     ,'VOICE_MAILS_HANDLED'
     ,'WEB_CHATS_CREATED'
     ,'WEB_CHATS_HANDLED'
  )
)
;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('3.2.0','002','002_UPDATE_D_METRIC_PROJECT_IL');

commit;