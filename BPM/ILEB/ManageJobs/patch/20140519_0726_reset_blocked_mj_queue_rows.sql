alter table F_MJ_BY_DATE enable row movement;
--31456
update F_MJ_BY_DATE
set
  D_DATE = to_date('04/01/1999 22:10:03','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('04/01/1999 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('04/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 32969;

update F_MJ_BY_DATE
set
  D_DATE = to_date('04/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('04/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('07/07/2077 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 32970;

update F_MJ_BY_DATE
set
 D_DATE = to_date('04/01/2014 22:10:03','MM/DD/YYYY HH24:MI:SS'),
 BUCKET_START_DATE = to_date('04/01/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 32969;

--34063
update F_MJ_BY_DATE
set
  D_DATE = to_date('05/01/1999 22:08:52','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('05/01/1999 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('05/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36439;

update F_MJ_BY_DATE
set
  D_DATE = to_date('05/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('05/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('07/07/2077 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36440;

update F_MJ_BY_DATE
set
  D_DATE = to_date('05/01/2014 22:08:52','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('05/01/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36439;

--33806
update F_MJ_BY_DATE
set
  D_DATE = to_date('04/29/1999 22:07:34','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('04/29/1999 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('04/30/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36162;

update F_MJ_BY_DATE
set
  D_DATE = to_date('04/30/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('04/30/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('07/07/2077 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36163;

update F_MJ_BY_DATE
set
  D_DATE = to_date('04/29/2014 22:07:34','MM/DD/YYYY HH24:MI:SS'),
  BUCKET_START_DATE = to_date('04/29/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36162;

--33905
update F_MJ_BY_DATE
set
  D_DATE = to_date('04/30/1999 22:08:13','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('04/30/1999 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('05/01/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36257;

update F_MJ_BY_DATE
set
  D_DATE = to_date('05/01/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('05/01/2014 00:00:00','MM/DD/YYYY HH24:MI:SS'),
BUCKET_END_DATE =  to_date('07/07/2077 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36258;

update F_MJ_BY_DATE
set
  D_DATE = to_date('04/30/2014 22:08:13','MM/DD/YYYY HH24:MI:SS'),
BUCKET_START_DATE = to_date('04/30/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where FIMJBD_ID = 36257;


commit;
alter table F_MJ_BY_DATE enable row movement;
