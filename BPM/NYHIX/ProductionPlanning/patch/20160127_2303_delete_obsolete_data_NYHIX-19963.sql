alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

alter session set current_schema = MAXDAT;

delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 3393 and supervisor_id = 3181 and effective_date = '12-DEC-15' and end_date is null ;
delete from Pp_Bo_Supervisor_To_Staff Where Staff_Id = 7387 and supervisor_id = 1308 and effective_date = '07-JAN-16' and end_date is null ;

commit;


delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7387 and staff_group_id = 1088 and start_date = '07-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7409 and staff_group_id = 1119 and start_date = '05-JAN-16' and end_date is null ;

commit;