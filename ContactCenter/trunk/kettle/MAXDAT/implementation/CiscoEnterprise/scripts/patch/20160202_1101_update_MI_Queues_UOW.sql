update cc_c_contact_queue
set unit_of_work_name = 'Enrolls'
where queue_number in (5268, 5296, 5298, 5299, 5300, 5302, 5303);

update cc_c_contact_queue
set unit_of_work_name = 'Healthcare Helpline'
where queue_number in (5269, 5271, 5273);

update cc_c_contact_queue
set unit_of_work_name = 'Phone App'
where queue_number in (5270, 5272, 5274);

update cc_c_contact_queue
set unit_of_work_name = 'MIChild'
where queue_number in (5276, 5277, 5278, 5279, 5280);

update cc_c_contact_queue
set unit_of_work_name = 'Beneficiary Helpline'
where queue_number in (5297, 5301);

commit;

update cc_c_unit_of_work
set unit_of_work_name = 'Phone App', UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL'
where unit_of_work_name = 'PHONE APP';

update cc_d_unit_of_work
set unit_of_work_name = 'Phone App', UNIT_OF_WORK_CATEGORY = 'INBOUND_CALL'
where unit_of_work_name = 'PHONE APP';

commit;

Insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,RECORD_EFF_DT,RECORD_END_DT,UNIT_OF_WORK_CATEGORY) values ('Healthcare Helpline',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),'INBOUND_CALL');
Insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,RECORD_EFF_DT,RECORD_END_DT,UNIT_OF_WORK_CATEGORY) values ('Beneficiary Helpline',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),'INBOUND_CALL');
Insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,RECORD_EFF_DT,RECORD_END_DT,UNIT_OF_WORK_CATEGORY) values ('Enrolls',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),'INBOUND_CALL');
Insert into CC_C_UNIT_OF_WORK (UNIT_OF_WORK_NAME,RECORD_EFF_DT,RECORD_END_DT,UNIT_OF_WORK_CATEGORY) values ('MIChild',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),'INBOUND_CALL');

commit;

Insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY) values ('Healthcare Helpline',0,'N','Seconds','INBOUND_CALL');
Insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY) values ('Beneficiary Helpline',0,'N','Seconds','INBOUND_CALL');
Insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY) values ('Enrolls',0,'N','Seconds','INBOUND_CALL');
Insert into CC_D_UNIT_OF_WORK (UNIT_OF_WORK_NAME,PRODUCTION_PLAN_ID,HOURLY_FLAG,HANDLE_TIME_UNIT,UNIT_OF_WORK_CATEGORY) values ('MIChild',0,'N','Seconds','INBOUND_CALL');

commit;

