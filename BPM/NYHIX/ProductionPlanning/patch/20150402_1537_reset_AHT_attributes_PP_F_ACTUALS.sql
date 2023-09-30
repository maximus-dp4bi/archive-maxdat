update PP_F_ACTUALS
set actl_handle_time_avg = 0
 ,actl_handle_time_min = 0
 ,actl_handle_time_max = 0
 ,actl_handle_time_mean = 0
 ,actl_handle_time_median = 0
 ,actl_handle_time_sd = 0
 ,actl_staff_hours = 0
where d_date >= '11-AUG-14' ;

commit;