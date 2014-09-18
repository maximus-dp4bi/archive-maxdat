alter table CC_F_ACTUALS_QUEUE_INTERVAL
disable constraint F_ACTLS_Q_INTRVL_D_AGENT_FK;

update CC_F_ACTUALS_QUEUE_INTERVAL
set d_agent_id=4029
where d_agent_id=5193;

delete from cc_f_actuals_queue_interval
where d_date_id in (select d.d_date_id from cc_f_actuals_queue_interval f, cc_d_dates d
                    where f.d_date_id=d.d_date_id
                    and d.d_date between '01-mar-14' and '02-may-14')
and d_agent_id=1 ;

delete from cc_d_agent
where d_agent_id=5193;

update cc_d_agent
set record_eff_dt=to_date('2014/05/01', 'yyyy/mm/dd')
where d_agent_id=4029;


alter table CC_F_ACTUALS_QUEUE_INTERVAL
enable constraint F_ACTLS_Q_INTRVL_D_AGENT_FK;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.8.1.4','103','103_FIX_DUPLICATE_FACTS_UAT');

commit;