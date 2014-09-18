/* 

-- Find invalid Mail Fax Batch fact rows.

select * from F_MFB_BY_HOUR
where 
  D_DATE < BUCKET_START_DATE
  or to_date(to_char(D_DATE,'YYYY-MM-DD'),'YYYY-MM-DD') > BUCKET_END_DATE
  or BUCKET_START_DATE > BUCKET_END_DATE
  or BUCKET_END_DATE < BUCKET_START_DATE;

select * 
from F_MFB_BY_HOUR
where MFB_BI_ID in (1161337,)
order by 
  MFB_BI_ID asc,
  D_DATE asc;
  
  
select distinct(BI_ID) from BPM_LOGGING where BSL_ID = 16 and LOG_DATE > sysdate - 0.1 order by BI_ID asc;

select * from BPM_LOGGING where BSL_ID = 16 and BI_ID = 1160901 and LOG_DATE > sysdate - 0.5 order by BL_ID desc;

select * from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 16 and IDENTIFIER = '{a5080a2b-bee7-4638-8a7b-0dec3200696f}';
  
*/

--- Fix invalid Mail Fax Batch fact rows.

delete from F_MFB_BY_HOUR
where
  FMFBBH_ID = 421431
  and MFB_BI_ID = 1145884;

delete from F_MFB_BY_HOUR
where
  FMFBBH_ID = 421496
  and MFB_BI_ID = 1145884;
  
update F_MFB_BY_HOUR
set D_DATE = to_date('2014-01-18 18:04:59','YYYY-MM_DD HH24:MI:SS')
where 
  FMFBBH_ID = 506014
  and MFB_BI_ID = 1145884;


delete from F_MFB_BY_HOUR
where
  FMFBBH_ID = 1525859
  and MFB_BI_ID = 1156622;
  
update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2014-01-20 11:00:00','YYYY-MM_DD HH24:MI:SS')
where 
  FMFBBH_ID = 523594
  and MFB_BI_ID = 1156622;
  
  
delete from F_MFB_BY_HOUR
where
  FMFBBH_ID = 701854
  and MFB_BI_ID = 1161337;
  
update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2014-01-23 14:00:00','YYYY-MM_DD HH24:MI:SS')
where 
  FMFBBH_ID = 701853
  and MFB_BI_ID = 1161337;
  
  
delete from F_MFB_BY_HOUR
where
  FMFBBH_ID = 651631
  and MFB_BI_ID = 1207064;
  
update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2014-01-22 19:00:00','YYYY-MM_DD HH24:MI:SS')
where 
  FMFBBH_ID = 648710
  and MFB_BI_ID = 1207064;


delete from F_MFB_BY_HOUR
where
  FMFBBH_ID = 651633
  and MFB_BI_ID = 1207066;
  
update F_MFB_BY_HOUR
set BUCKET_END_DATE = to_date('2014-01-22 19:00:00','YYYY-MM_DD HH24:MI:SS')
where 
  FMFBBH_ID = 648712
  and MFB_BI_ID = 1207066;
  
commit;

execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(16);