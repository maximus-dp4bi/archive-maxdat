-- CC_D_CONTACT_QUEUE & CC_D_UNIT_OF_WORK

update cc_d_contact_queue
set queue_type='Outbound'
where queue_number in (
5040
,5734
,5735
);


insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES Outbound',0,'N','Seconds');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','107','107_ADD_ES_OUTBOUND_DATA_TO_DIMENSIONAL_TABLES');

commit;