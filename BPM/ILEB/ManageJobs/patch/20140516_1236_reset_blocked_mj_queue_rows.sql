/*delete from F_MJ_BY_DATE
where fimjbd_id in (32970,36163,36258,36440);
commit;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('04/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 5319925;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('05/02/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 6121559;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('04/30/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 6060403;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('05/01/2014 00:00:00','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 6095335;
commit;
*/

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('04/02/2014 00:42:25','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 5319925;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('05/02/2014 03:01:58','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 6121559;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('04/30/2014 00:46:38','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 6060403;

update F_MJ_BY_DATE
set BUCKET_END_DATE = to_date('05/01/2014 02:33:35','MM/DD/YYYY HH24:MI:SS')
where MJ_BI_ID = 6095335;
commit;
