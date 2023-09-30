insert into cc_c_unit_of_work(unit_of_work_id, unit_of_work_name, record_eff_dt, record_end_dt, unit_of_work_category) 
values(SEQ_CC_C_UNIT_OF_WORK.NEXTVAL,'Issuer',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'), 'INBOUND_CALL');

insert into cc_d_unit_of_work (uow_id, unit_of_work_name, production_plan_id, hourly_flag, handle_time_unit, unit_of_work_category)
values (SEQ_CC_D_UNIT_OF_WORK.NEXTVAL, 'Issuer', 0, 'N', 'Seconds', 'INBOUND_CALL');

update cc_s_contact_queue
set queue_type = 'Inbound',
unit_of_work_id = 82
where queue_name = 'MAXHIHIX_Issuer_vcall';

update cc_c_contact_queue
set queue_type = 'Inbound',
unit_of_work_name = 'Issuer'
where queue_name = 'MAXHIHIX_Issuer_vcall';

commit;