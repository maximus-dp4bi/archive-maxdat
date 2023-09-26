insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category) values('COEEMAP Inbound','INBOUND_CALL');
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category) values('COEEMAP Outbound','OUTBOUND_CALL');

insert into cc_d_unit_of_work (unit_of_work_name,production_plan_id,Handle_time_unit, unit_of_work_category)
values('COEEMAP Inbound',0,'Seconds','INBOUND_CALL');
insert into cc_d_unit_of_work (unit_of_work_name,production_plan_id,Handle_time_unit, unit_of_work_category)
values('COEEMAP Outbound',0,'Seconds','OUTBOUND_CALL');

update cc_c_contact_queue set unit_of_work_name=(select unit_of_work_name from cc_c_unit_of_work where unit_of_work_category='INBOUND_CALL')
where queue_type='Inbound';
update cc_c_contact_queue set unit_of_work_name=(select unit_of_work_name from cc_c_unit_of_work where unit_of_work_category='OUTBOUND_CALL')
where queue_type='Outbound';

update cc_s_contact_queue set unit_of_work_id=(select unit_of_work_id from cc_c_unit_of_work where unit_of_work_category='INBOUND_CALL')
where queue_type='Inbound';
update cc_s_contact_queue set unit_of_work_id=(select unit_of_work_id from cc_c_unit_of_work where unit_of_work_category='OUTBOUND_CALL')
where queue_type='Outbound';

update cc_f_actuals_queue_interval set d_unit_of_work_id=(select uow_id from cc_d_unit_of_work where unit_of_work_name='COEEMAP Inbound')
where d_contact_queue_id in (select d_contact_queue_id from cc_d_contact_queue where queue_type='Inbound');
update cc_f_actuals_queue_interval set d_unit_of_work_id=(select uow_id from cc_d_unit_of_work where unit_of_work_name='COEEMAP Outbound')
where d_contact_queue_id in (select d_contact_queue_id from cc_d_contact_queue where queue_type='Outbound');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.1.0','101','101_UPDATE_UNIT_OF_WORK');

commit;