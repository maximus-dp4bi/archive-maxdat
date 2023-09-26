ALTER SESSION SET CURRENT_SCHEMA=CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set queue_type = 'Callback'
, service_seconds = 30
, interval_minutes = 15
, Unit_of_work_name = 'MEC CSR - Callback'
, project_name = 'Mass Health'
, program_name = 'Customer Service Center'
, region_name = 'Eastern'
, state_name = 'Massachusetts'
where queue_number = 7176;

/* UNIT OF WORK */
INSERT INTO CC_C_UNIT_OF_WORK 
    (UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, RECORD_EFF_DT, RECORD_END_DT, ACD, IVR) VALUES
    ('MEC CSR - Callback','CALLBACK',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


INSERT INTO CC_D_UNIT_OF_WORK 
(UNIT_OF_WORK_NAME, UNIT_OF_WORK_CATEGORY, PRODUCTION_PLAN_ID, HOURLY_FLAG, HANDLE_TIME_UNIT, ACD, IVR) VALUES
    ('MEC CSR - Callback','CALLBACK', 1, 'N', 'Seconds', 1, 0);
    
commit;    


/* CALLS OFFERED */

update cc_a_list_lkup
set out_var = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
where list_type = 'CC_S_ACD_INTERVAL-CALLS_OFFERED'
and name = 'Mass Health CS_CALLS_OFFERED_FORMULA';

update cc_a_list_lkup
set out_var = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
where list_type = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
and name = 'Mass Health CS_CALLS_OFFERED_FORMULA';

commit;