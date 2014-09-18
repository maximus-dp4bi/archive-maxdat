update pp_cfg_unit_of_work set jeopardy_inv_age=3, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=1 and unit_of_work_name='COES_RENEWAL_APPS'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=2, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=2 and unit_of_work_name='COES_DISENROLLMENT'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=20, inv_avg_age=60, age_days_type='CAL' where cfg_uow_id=3 and unit_of_work_name='COES_APPEAL_COMPLAINT'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=3, inv_avg_age=20, age_days_type='BUS' where cfg_uow_id=4 and unit_of_work_name='COES_CASE_MAINT'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=15, inv_avg_age=30, age_days_type='CAL' where cfg_uow_id=5 and unit_of_work_name='COES_MISSING_INFO'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=3, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=6 and unit_of_work_name='COES_NEW_APPS'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=2, inv_avg_age=10 where cfg_uow_id=7 and unit_of_work_name='COES_NEW_BACKLOG';
update pp_cfg_unit_of_work set jeopardy_inv_age=1, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=8 and unit_of_work_name='COES_MANUAL_ENROLL'; 
update pp_cfg_unit_of_work set jeopardy_inv_age=1, inv_avg_age=10, age_days_type='CAL' where cfg_uow_id=9 and unit_of_work_name='COES_ENROL_FEE'; 


update pp_d_unit_of_work set jeopardy_inv_age=3 where uow_id=1 and unit_of_work_name='COES_RENEWAL_APPS';
update pp_d_unit_of_work set jeopardy_inv_age=2 where uow_id=2 and unit_of_work_name='COES_DISENROLLMENT';
update pp_d_unit_of_work set jeopardy_inv_age=20 where uow_id=3 and unit_of_work_name='COES_APPEAL_COMPLAINT';
update pp_d_unit_of_work set jeopardy_inv_age=3 where uow_id=4 and unit_of_work_name='COES_CASE_MAINT';
update pp_d_unit_of_work set jeopardy_inv_age=15 where uow_id=5 and unit_of_work_name='COES_MISSING_INFO';
update pp_d_unit_of_work set jeopardy_inv_age=3 where uow_id=6 and unit_of_work_name='COES_NEW_APPS';
update pp_d_unit_of_work set jeopardy_inv_age=2 where uow_id=7 and unit_of_work_name='COES_NEW_BACKLOG';
update pp_d_unit_of_work set jeopardy_inv_age=1 where uow_id=8 and unit_of_work_name='COES_MANUAL_ENROLL';
update pp_d_unit_of_work set jeopardy_inv_age=1 where uow_id=9 and unit_of_work_name='COES_ENROL_FEE';

commit;
/
