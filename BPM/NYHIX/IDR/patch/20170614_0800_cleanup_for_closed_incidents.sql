
update maxdat.F_IDR_BY_DATE
set BUCKET_START_DATE = to_date('25-MAY-17 00:00:00','DD-MON-RR HH24:MI:SS'),
    BUCKET_END_DATE = to_date('25-MAY-17 00:00:00','DD-MON-RR HH24:MI:SS')
where FIDRBD_ID =298193;
commit;
