update pp_wfm_supervisor_to_staff
set end_date = sysdate
where Delete_flag = 'Y'
;
commit;
