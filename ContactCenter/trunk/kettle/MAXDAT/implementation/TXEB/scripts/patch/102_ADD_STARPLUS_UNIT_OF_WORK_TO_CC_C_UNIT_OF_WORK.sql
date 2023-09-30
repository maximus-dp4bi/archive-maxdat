insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('STAR Plus NonFrew EN',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,record_eff_dt,record_end_dt)values('STAR Plus NonFrew SP',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.0','102','102_ADD_STARPLUS_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK');

commit;


					       









