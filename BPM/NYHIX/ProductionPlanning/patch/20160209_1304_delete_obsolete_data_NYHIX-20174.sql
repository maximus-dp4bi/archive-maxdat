alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = MAXDAT;

delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 4383 and supervisor_id = 1246 and effective_date = '27-JAN-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 4793 and supervisor_id = 1176 and effective_date = '16-FEB-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 6055 and supervisor_id = 6492 and effective_date = '16-FEB-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 6201 and supervisor_id = 4831 and effective_date = '16-FEB-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 6530 and supervisor_id = 5910 and effective_date = '01-DEC-15' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 6919 and supervisor_id = 7468 and effective_date = '01-FEB-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 7417 and supervisor_id = 1246 and effective_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 7469 and supervisor_id = 1246 and effective_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 7564 and supervisor_id = 4383 and effective_date = '16-FEB-16' and end_date is null ;


commit;


delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 2975 and staff_group_id = 1111 and start_date = '02-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 6055 and staff_group_id = 1117 and start_date = '16-FEB-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 6422 and staff_group_id = 1120 and start_date = '16-FEB-16' and end_date is null ;

commit;