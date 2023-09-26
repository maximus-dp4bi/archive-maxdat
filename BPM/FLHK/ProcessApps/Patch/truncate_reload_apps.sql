truncate "FLCPD0_MAXDAT"."FLHK_ETL_PROCESS_APP" 


update corp_etl_control set value=3565993124 where name = 'PA_LAST_APP_ID';
commit;
