----------------------------------------------------------------------	
----------------------------------------------------------------------	

update maxdat.pp_wfm_supervisor_to_staff t1
set end_date = ( select end_date from RESTORE.pp_wfm_supervisor_to_staff t2
where t2.staff_id = t1.staff_id
  and t2.effective_date = t1.effective_date
  and t2.supervisor_id = t1.supervisor_id
)
where exists ( select 'x' from RESTORE.pp_wfm_supervisor_to_staff t3
where t3.staff_id = t1.staff_id
  and t3.effective_date = t1.effective_date
  and t3.supervisor_id = t1.supervisor_id
)
AND NOT exists ( select 'x' from RESTORE.pp_wfm_supervisor_to_staff t4
where t4.staff_id = t1.staff_id
  and t4.effective_date = t1.effective_date
  and t4.supervisor_id = t1.supervisor_id
  and trunc(nvl(t4.end_date,sysdate)) = trunc(nvl(t1.end_date,sysdate))  
);

commit;

