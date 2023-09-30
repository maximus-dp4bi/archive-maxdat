insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('EBS_OUTBOUND',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('THS_OUTBOUND',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('CHIP_OUTBOUND',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('CHIP_OUTBOUND_ENRL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('CHIP_OUTBOUND_MI',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('CHIP_OUTBOUND_PMI',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('CHIP_OUTBOUND_XFR',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));




INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.3','106','106_ADD_OUTBOUND_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK');

commit;


					       









