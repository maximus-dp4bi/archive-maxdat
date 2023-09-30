alter session set current_schema = cisco_enterprise_cc;

/* CONTACT QUEUE */
update cc_c_contact_queue set unit_of_work_name='ILEB Hampton English', service_seconds='30', interval_minutes ='15', queue_type='Inbound', project_name='IL EB', program_name='Multiple', region_name='Central', state_name='Illinois' where queue_number ='7083';
update cc_c_contact_queue set unit_of_work_name='ILEB Hampton Spanish', service_seconds='30', interval_minutes ='15', queue_type='Inbound', project_name='IL EB', program_name='Multiple', region_name='Central', state_name='Illinois' where queue_number ='7084';

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7083');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC','7084');

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC','5294');
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC','5295');


/* AGENT ROUTING GROUPS */
UPDATE CC_C_AGENT_RTG_GRP SET INTERVAL_MINUTES='15', PROJECT_NAME='IL EB', PROGRAM_NAME='Multiple', REGION_NAME='Central', STATE_NAME='Illinois' WHERE AGENT_ROUTING_GROUP_NUMBER='5294';
UPDATE CC_C_AGENT_RTG_GRP SET PROJECT_NAME='IL EB', PROGRAM_NAME='Multiple', REGION_NAME='Central', STATE_NAME='Illinois' WHERE AGENT_ROUTING_GROUP_NUMBER='5295';

commit;
