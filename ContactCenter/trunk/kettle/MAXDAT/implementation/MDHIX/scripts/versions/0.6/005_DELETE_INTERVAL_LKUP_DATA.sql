alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

delete from cc_s_interval
where interval_start_date >= '26-SEP-15 00:00:00';


delete from cc_d_interval
where interval_start_date >= '26-SEP-15 00:00:00';

commit;