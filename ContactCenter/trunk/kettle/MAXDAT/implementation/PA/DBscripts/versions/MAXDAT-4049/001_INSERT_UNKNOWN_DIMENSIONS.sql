insert into cc_d_unit_of_work (uow_id, unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values
(0, 'Unknown','Unknown',0,'N','Seconds');

insert into cc_d_site values (0,'Unknown','Unknown',0,to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

insert into cc_d_group values (0,'Unknown','Unknown',0, to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'), 'Y');

commit;