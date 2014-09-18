insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('ES EN',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('ES SP',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('ES SEU EN',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('ES SEU SP',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('ES SEU  EN and ES SLAQ EN',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('ES SEU  SP and ES SLAQ SP',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','103','103_ADD_ES_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK');

commit;


					       









