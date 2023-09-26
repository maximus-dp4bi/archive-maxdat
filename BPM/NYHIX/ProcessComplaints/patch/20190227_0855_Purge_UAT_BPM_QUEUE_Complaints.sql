delete from corp_etl_complaints_incidents;

delete from corp_etl_compl_incidents_oltp;

delete from CORP_ETL_COMPL_INCIDN_WIP_BPM;

delete from F_COMPLAINT_BY_DATE;

delete from D_COMPLAINT_CURRENT;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 22 ;

update corp_etl_control set value = 26075889 where name = 'PC_LAST_COMPLAINT';
update corp_etl_control set value = 10 where name = 'COMPLAINTS_TO_LOOK_BACK';
commit;
