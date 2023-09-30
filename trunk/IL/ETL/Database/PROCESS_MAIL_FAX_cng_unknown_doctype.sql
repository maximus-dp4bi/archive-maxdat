update  corp_etl_list_lkup set
out_var =  'Enrollment Data Entry Task',
ref_type = 'STEP_DEFINITION_ID',
ref_id = (select step_definition_id from step_definition_stg where name = 'Enrollment Data Entry Task' and step_type_cd in ('HUMAN_TASK', 'VIRTUAL_HUMAN_TASK') )  
where name = 'ProcessMail_work_expected'
and list_type = 'DOC_TYPE'
and value = 'UNKNOWN';

commit;				