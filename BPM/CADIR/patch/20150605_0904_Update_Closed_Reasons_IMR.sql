update s_crs_imr
set closed_reason_id = 0
where closed_reason_id is null;

commit;

update s_crs_imr
set closed_reason_id = 53269598
where imr_closed_date is not null
and closed_reason_id = 0;

commit;