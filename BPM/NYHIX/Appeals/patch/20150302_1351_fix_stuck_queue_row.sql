
delete from F_APPEALS_BY_DATE
where faplbd_id = 18274;

update F_APPEALS_BY_DATE
set bucket_end_date = to_date('07/07/2077','mm/dd/yyyy')
where faplbd_id = 18271;

execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(23);

commit;