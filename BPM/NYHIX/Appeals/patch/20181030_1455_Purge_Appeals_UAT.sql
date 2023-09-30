

delete from MAXDAT.NYHBE_ETL_PROCESS_APPEALS_RSN;

delete from MAXDAT.NYHBE_PROCESS_APPEALS_OLTP;

delete from MAXDAT.NYHBE_PROCESS_APPEALS_WIP_BPM;

delete from MAXDAT.NYHBE_ETL_PROCESS_APPEALS;


delete from MAXDAT.F_APPEALS_BY_DATE
where APL_BI_ID in (select APL_BI_ID from D_APPEALS_CURRENT);

delete from MAXDAT.D_APPEALS_CURRENT;


DELETE FROM maxdat.BPM_UPDATE_EVENT_QUEUE where BSL_ID = 23;

delete from maxdat.BPM_LOGGING where BSL_ID = 23;
delete from maxdat.corp_etl_error_log  where process_name = 'APPEALS';
commit;

update maxdat.corp_etl_control set value = 26075869 where name ='LAST_APPEAL_ID';
update maxdat.corp_etl_control set value = 0 where name='APPEALS_TO_LOOK_BACK';
update maxdat.corp_etl_control set value = 26074580 where name ='LAST_IDR_INCIDENT_ID';
update maxdat.corp_etl_control set value = 100 where name ='IDRS_TO_LOOK_BACK';
Commit;

