update pp_cfg_unit_of_work set jeopardy_inv_age=3, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=1 and unit_of_work_name='COES_RENEWAL_APPS'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=2, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=2 and unit_of_work_name='COES_DISENROLLMENT'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=20, inv_avg_age=60, age_days_type='CAL' where cfg_uow_id=3 and unit_of_work_name='COES_APPEAL_COMPLAINT'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=3, inv_avg_age=20, age_days_type='BUS' where cfg_uow_id=4 and unit_of_work_name='COES_CASE_MAINT'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=15, inv_avg_age=30, age_days_type='CAL' where cfg_uow_id=5 and unit_of_work_name='COES_MISSING_INFO'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=3, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=6 and unit_of_work_name='COES_NEW_APPS'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=2, inv_avg_age=10 where cfg_uow_id=7 and unit_of_work_name='COES_NEW_BACKLOG';
update pp_cfg_unit_of_work set jeopardy_inv_age=1, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=8 and unit_of_work_name='COES_MANUAL_ENROLL'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=1, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=9 and unit_of_work_name='COES_ENROL_FEE'; 
insert into maxdat.pp_cfg_unit_of_work
  (cfg_uow_id, unit_of_work_name, hourly_flag, handle_time_unit, jeopardy_inv_age, age_days_type, inv_avg_age, label)
values
  (10, 'COES_ADD_A_MEMBER', 'N', 'Minutes', 3, 'CAL', 10, 'Add A Member');
insert into maxdat.pp_cfg_unit_of_work
  (cfg_uow_id, unit_of_work_name, hourly_flag, handle_time_unit, jeopardy_inv_age, age_days_type, inv_avg_age, label)
values
  (11, 'COES_EXPEDITE_P1', 'N', 'Minutes', 1, 'BUS', 10, 'Expedites');
insert into maxdat.pp_cfg_unit_of_work
  (cfg_uow_id, unit_of_work_name, hourly_flag, handle_time_unit, jeopardy_inv_age, age_days_type, inv_avg_age, label)
values
  (12, 'COES_RESEARCH', 'N', 'Minutes', 10, 'CAL', 30, 'Research');  

update pp_d_unit_of_work set jeopardy_inv_age=3 where uow_id=1 and unit_of_work_name='COES_RENEWAL_APPS';
update pp_d_unit_of_work set jeopardy_inv_age=2 where uow_id=2 and unit_of_work_name='COES_DISENROLLMENT';
update pp_d_unit_of_work set jeopardy_inv_age=20 where uow_id=3 and unit_of_work_name='COES_APPEAL_COMPLAINT';
update pp_d_unit_of_work set jeopardy_inv_age=3 where uow_id=4 and unit_of_work_name='COES_CASE_MAINT';
update pp_d_unit_of_work set jeopardy_inv_age=15 where uow_id=5 and unit_of_work_name='COES_MISSING_INFO';
update pp_d_unit_of_work set jeopardy_inv_age=3 where uow_id=6 and unit_of_work_name='COES_NEW_APPS';
update pp_d_unit_of_work set jeopardy_inv_age=2 where uow_id=7 and unit_of_work_name='COES_NEW_BACKLOG';
update pp_d_unit_of_work set jeopardy_inv_age=1 where uow_id=8 and unit_of_work_name='COES_MANUAL_ENROLL';
update pp_d_unit_of_work set jeopardy_inv_age=1 where uow_id=9 and unit_of_work_name='COES_ENROL_FEE';
insert into maxdat.pp_d_unit_of_work
  (uow_id, unit_of_work_name, handle_time_unit, jeopardy_inv_age, label)
values
  (10, 'COES_ADD_A_MEMBER', 'Minutes', 3, 'Add A Member');
insert into maxdat.pp_d_unit_of_work
  (uow_id, unit_of_work_name, handle_time_unit, jeopardy_inv_age, label)
values
  (11, 'COES_EXPEDITE_P1', 'Minutes', 1, 'Expedites');  
insert into maxdat.pp_d_unit_of_work
  (uow_id, unit_of_work_name, handle_time_unit, jeopardy_inv_age, label)
values
  (12, 'COES_RESEARCH', 'Minutes', 10, 'Research');    

delete from PP_D_UOW_SOURCE_REF where source_ref_value='Appeals Coordinator ReminderTask';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Fair Hearing Notice List Data Entry Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Fair Hearing Notice email to prn scn Dt Entry Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Discontinuation of Benefits Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Continuation of Benefits Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='PEAK Change Report';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Cost Share Manual Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Initiate RRR - CHP+ 1 year old ';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='MI Received - Transition Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Expedite P3 Request Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Good Faith Effort'; 
delete from PP_D_UOW_SOURCE_REF where source_ref_value='MI Received - Non MAXIMUS Case '; 
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Initiate RRR - CHP+ Prenatal';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Initiate RRR - Medicaid 1 year o'; 
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Expedite P2 Request Task';
delete from PP_D_UOW_SOURCE_REF where source_ref_value='Patient Registration Form Task';

update PP_D_UOW_SOURCE_REF set end_date = trunc(sysdate - 1) where usr_id in (18,19,22,32,39);

INSERT INTO PP_D_UOW_SOURCE_REF SELECT 61, 10, 1, 'Add a Member Data Entry', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 62, 10, 1, 'Add a Member Task', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 63, 11, 1, 'Expedite P1 Request Task', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 64, 12, 1, 'Fee - Research', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 65, 12, 1, 'Research Task - General', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;

commit;
/
