alter session set current_schema = cisco_enterprise_cc;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name='Outbound - English', interval_minutes ='15', queue_type='Outbound', project_name='PA CHC', program_name='Community HealthChoices', region_name='Eastern', state_name='Pennsylvania' where queue_number ='7058';
update cc_c_contact_queue set unit_of_work_name='Outbound - Spanish', interval_minutes ='15', queue_type='Outbound', project_name='PA CHC', program_name='Community HealthChoices', region_name='Eastern', state_name='Pennsylvania' where queue_number ='7059';

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7058');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7059');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC','5286');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC','5287');


/* AGENT ROUTING GROUPS */
UPDATE CC_C_AGENT_RTG_GRP SET INTERVAL_MINUTES='15', PROJECT_NAME='PA CHC', PROGRAM_NAME='Community HealthChoices', REGION_NAME='Eastern', STATE_NAME='Pennsylvania' WHERE AGENT_ROUTING_GROUP_NUMBER='5286';
UPDATE CC_C_AGENT_RTG_GRP SET INTERVAL_MINUTES='15', PROJECT_NAME='PA CHC', PROGRAM_NAME='Community HealthChoices', REGION_NAME='Eastern', STATE_NAME='Pennsylvania' WHERE AGENT_ROUTING_GROUP_NUMBER='5287';

/* UNIT OF WORK */
update cc_d_unit_of_work set production_plan_id='161' where unit_of_work_name='Outbound - English';
update cc_d_unit_of_work set production_plan_id='161' where unit_of_work_name='Outbound - Spanish';

commit;

