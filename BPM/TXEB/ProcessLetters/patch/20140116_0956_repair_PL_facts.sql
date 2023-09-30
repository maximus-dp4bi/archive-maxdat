/* 

-- Find invalid Process Letters fact rows.

select * from F_PL_BY_DATE
where 
  D_DATE < BUCKET_START_DATE
  or to_date(to_char(D_DATE,'YYYY-MM-DD'),'YYYY-MM-DD') > BUCKET_END_DATE
  or BUCKET_START_DATE > BUCKET_END_DATE
  or BUCKET_END_DATE < BUCKET_START_DATE;

select f.* 
from F_PL_BY_DATE f
where f.PL_BI_ID in 
(12111935,
11811255,
12100291,
12141467,
11793116,
12116369,
12122477)
order by 
  f.PL_BI_ID asc,
  D_DATE asc;
  
*/

--- Fix invalid Process Letters fact rows.

alter table F_PL_BY_DATE enable row movement;

update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 11793116
  and FPLBD_ID = 17222384;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:48:15','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 11793116
  and FPLBD_ID = 20955223;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 17:53:10','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 11793116
  and FPLBD_ID = 22540086;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:48:15','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 11793116
  and FPLBD_ID = 20955223;
  
  
update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 11811255
  and FPLBD_ID = 17221002;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:46:36','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 11811255
  and FPLBD_ID = 20955226;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 17:53:58','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 11811255
  and FPLBD_ID = 22540089;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:46:36','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 11811255
  and FPLBD_ID = 20955226;
  

update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12100291
  and FPLBD_ID = 15236069;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:51:01','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12100291
  and FPLBD_ID = 20955228;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 18:03:13','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12100291
  and FPLBD_ID = 22540020;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:51:01','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12100291
  and FPLBD_ID = 20955228;
  

update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12111935
  and FPLBD_ID = 15703967;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:50:40','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12111935
  and FPLBD_ID = 20955221;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 18:02:37','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12111935
  and FPLBD_ID = 22540040;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:50:40','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12111935
  and FPLBD_ID = 20955221;
  
  
update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12116369
  and FPLBD_ID = 17495685;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:50:33','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12116369
  and FPLBD_ID = 20955224;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 18:03:03','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12116369
  and FPLBD_ID = 22540111;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:50:33','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12116369
  and FPLBD_ID = 20955224;
  
  
update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12122477
  and FPLBD_ID = 17501473;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:50:17','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12122477
  and FPLBD_ID = 20955222;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 17:56:58','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12122477
  and FPLBD_ID = 22540118;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:50:17','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12122477
  and FPLBD_ID = 20955222;
  

update F_PL_BY_DATE
set BUCKET_END_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12141467
  and FPLBD_ID = 17499465;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-01 23:50:11','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-01','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12141467
  and FPLBD_ID = 20955220;
  
update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-06 18:02:42','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-06','YYYY-MM-DD')
where 
  PL_BI_ID = 12141467
  and FPLBD_ID = 22540119;

update F_PL_BY_DATE
set
  D_DATE = to_date('2014-01-05 23:50:11','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2014-01-05','YYYY-MM-DD')
where 
  PL_BI_ID = 12141467
  and FPLBD_ID = 20955220;
  
commit;

alter table F_PL_BY_DATE disable row movement;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID = 12 
  and IDENTIFIER in ('2231510','3462714','3904622','3447622')
  and BUEQ_ID in (39966786,41574106,41895697,41898097,42747374);
  
commit;