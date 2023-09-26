update s_crs_imr_issues_in_dispute
set delete_dt = null
where delete_dt is not null;

commit;
