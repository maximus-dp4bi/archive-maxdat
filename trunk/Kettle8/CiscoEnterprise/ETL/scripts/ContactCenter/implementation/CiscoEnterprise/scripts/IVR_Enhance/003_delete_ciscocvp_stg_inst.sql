truncate table cc_s_ivr_ciscocvp;

delete from cc_s_ivr_performance_instance_ext where f_ivr_performance_instance_id in (select f_ivr_performance_instance_id from cc_f_ivr_performance_instance where source_table_name = 'CC_S_IVR_CISCOCVP');
commit;

delete from cc_f_ivr_performance_instance where source_table_name = 'CC_S_IVR_CISCOCVP';
commit;
