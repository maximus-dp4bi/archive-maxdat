alter session set nls_date_format = 'DD-MON-RR HH24:MI:SS';

delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =1495  and staff_group_id =1111  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =3015  and staff_group_id =1111  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =4206  and staff_group_id =1088  and start_date = '13-FEB-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =4440  and staff_group_id =1089  and start_date = '28-APR-14' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =4669  and staff_group_id =1087  and start_date = '15-SEP-14' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5248  and staff_group_id =1031  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5254  and staff_group_id =1031  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5283  and staff_group_id =1031  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5499  and staff_group_id =1031  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5499  and staff_group_id =1034  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5640  and staff_group_id =1034  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5640  and staff_group_id =1112  and start_date = '20-MAR-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5926  and staff_group_id =1088  and start_date = '13-JUL-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =6932  and staff_group_id =1076  and start_date = '23-NOV-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id =5926  and staff_group_id =1088  and start_date = '13-JUL-15' and end_date is null ;

delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7388 and staff_group_id = 1117 and start_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7402 and staff_group_id = 1095 and start_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7427 and staff_group_id = 1095 and start_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7431 and staff_group_id = 1115 and start_date = '04-JAN-16' and end_date is null ;

-- NYHIX-19724

delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 4096 and staff_group_id = 1117 and start_date = '16-DEC-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 6492 and staff_group_id = 1121 and start_date = '01-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7280 and staff_group_id = 1119 and start_date = '14-DEC-15' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7401 and staff_group_id = 1115 and start_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7429 and staff_group_id = 1034 and start_date = '04-JAN-16' and end_date is null ;
delete from Pp_Bo_Staff_Group_To_Staff Where Staff_Id = 7452 and staff_group_id = 1117 and start_date = '04-JAN-16' and end_date is null ;



commit;

