delete from corp_etl_manage_work where task_id in (19350,19405,19465,19528,19523,19545,19632,19625);

delete from f_mw_by_date where mw_bi_id in (select mw_bi_id  from d_mw_current where "Task ID" in (19350,19405,19465,19528,19523,19545,19632,19625) );

delete from d_mw_current where "Task ID" in (19350,19405,19465,19528,19523,19545,19632,19625);

commit; 