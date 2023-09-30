alter session set current_schema = maxdat_cc;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('PA CHC IVR', 'IVR', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('PA CHC IVR', 'IVR', 1, 'N', 'Seconds');


delete cc_c_ivr_dnis where destination_dnis = 4082 and uow_id in (select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'PA CHC IVR');

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
4082,
(select d.uow_id from CC_D_UNIT_OF_WORK d where upper(d.unit_of_work_name) = 'PA CHC IVR' )
);


commit;