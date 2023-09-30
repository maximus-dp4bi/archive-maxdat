delete from corp_etl_mw_v2
where 1 = 1
;

delete from corp_etl_mw_v2_wip
where 1 = 1
;

delete from D_MW_V2_HISTORY
where 1 = 1
;

delete from D_MW_V2_CURRENT
where 1 = 1
;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 2001 
;
delete from STEP_INSTANCE_STG
;
delete from FLHK_ETL_MANAGE_WORK
where 1 = 1
;
delete from FLHK_ETL_MANAGE_WORK_OLTP_STG
where 1 = 1
;
delete from FLHK_ETL_MANAGE_WORK_WIP_BPM
where 1 = 1

;
Update corp_etl_control set value = 5587917 where name = 'MW_LAST_TASK_ID';

commit;