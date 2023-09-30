truncate table CC_S_IVR_CISCOCVP;
delete /*+ parallel(10) */ from CC_S_IVR_PERFORMANCE_INSTANCE_EXT where F_IVR_PERFORMANCE_INSTANCE_ID in (select F_IVR_PERFORMANCE_INSTANCE_ID from CC_F_IVR_PERFORMANCE_INSTANCE where SOURCE_TABLE_NAME = 'CC_S_IVR_CISCOCVP');
delete from CC_F_IVR_PERFORMANCE_INSTANCE where SOURCE_TABLE_NAME = 'CC_S_IVR_CISCOCVP';

insert into cc_a_ivr_job_ctrl (job_name, app_name_param, start_date_param_num, end_date_param_num)
values ('LOAD_CCVP_STG', 'CALL_LLIVR_v1', 20200601, 20200727);

insert into cc_a_ivr_job_ctrl (job_name, app_name_param, start_date_param_num, end_date_param_num)
values ('LOAD_CCVP_INST', 'CALL_LLIVR_v1', 20200601, 20200727);

insert into cc_a_ivr_job_ctrl (job_name, app_name_param, job_param_1) values ('RECALC_CLASS','CALL_LLIVR_v1','ALL');

commit;
