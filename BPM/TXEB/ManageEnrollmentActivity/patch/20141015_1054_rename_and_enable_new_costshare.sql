ALTER TABLE COST_SHARE_DETAILS_STG rename to COST_SHARE_DETAILS_STG_BACKUP;

ALTER TABLE COST_SHARE_DETAILS_NEW_STG rename to COST_SHARE_DETAILS_STG;

select to_char(LEAST(MAX(UPDATE_TS), MAX(CS_UPDATES_UPDATE_TS)),'yyyy/MM/dd HH24:mm:ss') as IN_max_UPDATE_TS_Sel,
       'MAX_UPDATE_TS_COST_SHARE_DTLS' as in_HistoryFieldName
from COST_SHARE_DETAILS_New_STG
;

update corp_etl_control
set value = '2014/10/09 23:10:00'
where name = 'MAX_UPDATE_TS_COST_SHARE_DTLS';

select * from corp_etl_control
where name = 'MAX_UPDATE_TS_COST_SHARE_DTLS';

select value run_flag
from CORP_ETL_CONTROL
where name = 'COST_SHARE_RUN_FLAG';

update corp_etl_control
set value = 'Y'
where name = 'COST_SHARE_RUN_FLAG';

commit;