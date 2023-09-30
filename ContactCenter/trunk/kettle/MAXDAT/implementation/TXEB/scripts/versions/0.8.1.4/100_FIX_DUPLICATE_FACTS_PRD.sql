delete from cc_f_actuals_queue_interval
where d_date_id in (select d.d_date_id from cc_f_actuals_queue_interval f, cc_d_dates d
                    where f.d_date_id=d.d_date_id
                    and d.d_date ='22-may-14')
and d_agent_id=1 ;

commit;

insert into cc_a_adhoc_job (
START_DATETIME_PARAM,
END_DATETIME_PARAM,
ADHOC_JOB_TYPE
) values (
'2014-05-21 00:00:00',
'2014-05-29 00:00:00',
'load_production_planning'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.8.4','100','100_FIX_DUPLICATE_FACTS_PRD');

commit;