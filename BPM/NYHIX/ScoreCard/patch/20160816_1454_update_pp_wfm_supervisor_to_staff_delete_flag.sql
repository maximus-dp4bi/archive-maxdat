update maxdat.pp_wfm_supervisor_to_staff
set delete_flag = 'N'
where delete_flag is null;

commit;
