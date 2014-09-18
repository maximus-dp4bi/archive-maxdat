update corp_etl_control
set value=0
where name='LAST_INCIDENT_ID';

update CORP_ETL_CONTROL
set value=30
where name='INC_LOOK_BACK_DAYS';


commit;