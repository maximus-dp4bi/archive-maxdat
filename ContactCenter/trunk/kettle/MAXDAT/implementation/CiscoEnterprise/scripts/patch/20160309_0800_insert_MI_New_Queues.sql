/* Adding Call tYpe filter, ignore filters and new DNIS as per MAXDAT-3296 */

alter session set current_schema = CISCO_ENTERPRISE_CC;

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '5482');

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5281');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5282');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5283');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5284');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5285');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5290');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5291');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5292');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5293');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5294');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5295');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_IGNORE', '5275');

commit;

Insert into CC_C_CONTACT_QUEUE (QUEUE_NUMBER,QUEUE_NAME,QUEUE_TYPE,SERVICE_PERCENT,SERVICE_SECONDS,UNIT_OF_WORK_NAME,PROJECT_NAME,PROGRAM_NAME,REGION_NAME,STATE_NAME,PROVINCE_NAME,DISTRICT_NAME,COUNTRY_NAME,RECORD_EFF_DT,RECORD_END_DT,INTERVAL_MINUTES) values (5482,'MIEL_MIEB_5610_SEACA','Inbound',80,30,'Enrolls','MIEB','MIEB','Central','Michigan','Unknown','Unknown','USA',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),30);

commit;

update cc_c_contact_queue
set queue_type = 'Transfer'
where queue_number in (5279, 5286, 5287, 5288);

update cc_s_contact_queue
set queue_type = 'Transfer'
where queue_number in (5279, 5286, 5287, 5288);

update cc_d_contact_queue
set queue_type = 'Transfer'
where queue_number in (5279, 5286, 5287, 5288);

commit;

--4241	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4241, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
);

--4242	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4242, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
 );
 
--4243	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4243, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
);

--4244	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4244, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
);

commit;