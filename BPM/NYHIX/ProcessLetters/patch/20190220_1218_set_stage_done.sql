----  NYHIX-47500 adjust 40 or so rows which have been closed but stage_done_date is not set.
----
Update maxdat.corp_etl_proc_letters
set stage_done_date = complete_dt
where stage_done_date is null and complete_dt is not null;



select count(*), instance_status, trunc(complete_dt), trunc(stage_done_date) from maxdat.corp_etl_proc_letters
where stage_done_date is null
group by  instance_status, trunc(complete_dt), trunc(stage_done_date)
order by instance_status, trunc(complete_dt), trunc(stage_done_date);
