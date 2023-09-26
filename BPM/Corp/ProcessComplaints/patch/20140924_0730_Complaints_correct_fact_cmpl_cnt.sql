update F_COMPLAINT_BY_DATE set COMPLETION_COUNT = 1, bucket_end_date = TRUNC(complete_dt)
where  COMPLETE_DT is not null and COMPLETION_COUNT <> 1  ;

commit;