delete from corp_etl_mw_v2
where 1 = 1
;

delete from corp_etl_mw_v2_wip
where 1 = 1
;

delete from f_mw_by_date
where 1 = 1
;

delete from MAXDAT.D_MW_V2_HISTORY
where 1 = 1
;

delete from D_MW_V2_CURRENT
where 1 = 1
;

delete from D_MW_ESCALATED
where 1 = 1
;
delete from D_MW_FORWARDED
where 1 = 1
;
delete from D_MW_LAST_UPDATE_BY_NAME
where 1 = 1
;
delete from D_MW_OWNER
where 1 = 1
;
delete from D_MW_TASK_STATUS
where 1 = 1
;
delete from D_MW_TASK_TYPE
where 1 = 1
;
DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 2001 
;

commit;
