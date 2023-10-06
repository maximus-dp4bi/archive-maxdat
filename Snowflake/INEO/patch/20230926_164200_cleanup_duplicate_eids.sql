CREATE TABLE ineo_all_staff_roster_hist_bak20230926
AS
select *
from ineo_all_staff_roster_history
where employee_id in(487680,494174);

delete from ineo_all_staff_roster_history
where employee_id = 494174
and cast(sf_create_ts as date) >= cast('08/09/2023' as date);

update ineo_all_staff_roster_history
set employee_id = 431892
where employee_id = 494174
and cast(sf_create_ts as date) < cast('08/09/2023' as date);

delete from ineo_all_staff_roster_history
where employee_id = 487680;

delete from ineo_all_staff_roster
where employee_id IN(494174,487680);

create table ineo_wfm_daily_staff_attend_roster_hist_20230926
as
select *
from ineo_wfm_daily_staff_attendance_roster_history
where employee_id = 494174
order by sf_create_ts desc;

create table ineo_wfm_daily_staff_attend_roster_20230926
as
select *
from ineo_wfm_daily_staff_attendance_roster
where employee_id = 494174;

delete from ineo_wfm_daily_staff_attendance_roster
where employee_id = 494174
and cast(sf_create_ts as date) >= cast('08/09/2023' as date)
;
delete from ineo_wfm_daily_staff_attendance_roster_history
where employee_id = 494174
and cast(sf_create_ts as date) >= cast('08/09/2023' as date)
;

update ineo_wfm_daily_staff_attendance_roster_history
set employee_id = 431892
where employee_id = 494174
and cast(sf_create_ts as date) < cast('08/09/2023' as date);

update ineo_wfm_daily_staff_attendance_roster
set employee_id = 431892
where employee_id = 494174
and cast(sf_create_ts as date) < cast('08/09/2023' as date);

update ineo_wfm_daily_staff_attendance_roster_history
set employee_status = 'Terminated'
where wfm_attendance_history_id = 260783;

update ineo_wfm_daily_staff_attendance_roster
set employee_status = 'Terminated'
where wfm_attendance_id = 20230915214013505320;

create table INEO_PROVISIONING_STAFF_ROSTER_HIST_BAK_20230926
as
select * from  INEO_PROVISIONING_STAFF_ROSTER_HISTORY
where employee_id in(505320,487680,494174);

delete from INEO_PROVISIONING_STAFF_ROSTER_HISTORY
where employee_id in(487680);

delete from INEO_PROVISIONING_STAFF_ROSTER_HISTORY
where employee_id in(494174)
and cast(sf_create_ts as date) >= cast('08/09/2023' as date);

update INEO_PROVISIONING_STAFF_ROSTER_HISTORY
set employee_id = 431892
where employee_id in(494174)
and cast(sf_create_ts as date) < cast('08/09/2023' as date);

delete from INEO_PROVISIONING_STAFF_ROSTER
where employee_id in(487680,494174);

create table INEO_QUALITY_STAFF_ROSTER_HIST_bak_20230926
select * from  INEO_QUALITY_STAFF_ROSTER_HISTORY
where employee_id in(494174);

delete from INEO_QUALITY_STAFF_ROSTER_HISTORY
where employee_id in(494174)
and cast(sf_create_ts as date) >= cast('08/09/2023' as date);

update INEO_QUALITY_STAFF_ROSTER_HISTORY
set employee_id = 431892
where employee_id in(494174)
and cast(sf_create_ts as date) < cast('08/09/2023' as date);

delete from INEO_QUALITY_STAFF_ROSTER
where employee_id in(494174);

create table INEO_ACTIVE_TRAINING_STAFF_ROSTER_HIST_bak_20230926
as
select * from INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY
where employee_id in(487680,494174);

update INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY
set employee_id = 431892
where employee_id = 494174;

delete from INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY
where employee_id = 487680;

update  INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY
set employee_status = 'Terminated'
where employee_id = 505320
and filename = 'TRAIN054_Training_Staff_Roster20230915020235';

update INEO_ACTIVE_TRAINING_STAFF_ROSTER
set employee_id = 431892
where employee_id = 494174;

delete from INEO_ACTIVE_TRAINING_STAFF_ROSTER 
where employee_id = 487680;

create table INEO_FAC_BADGE_ROSTER_HIST_bak_20230926
as
select * from  INEO_FAC_BADGE_ROSTER_HISTORY
where employee_id in(505320,487680,494174);

update  INEO_FAC_BADGE_ROSTER_HISTORY
set employee_status = 'Terminated'
where employee_id = 505320
and filename = 'FAC071_Badge_Roster20230915020259';

delete from INEO_FAC_BADGE_ROSTER_HISTORY
where employee_id = 487680;

delete from INEO_FAC_BADGE_ROSTER_HISTORY
where employee_id in(494174)
and cast(sf_create_ts as date) >= cast('08/09/2023' as date);

update INEO_FAC_BADGE_ROSTER_HISTORY
set employee_id = 431892
where employee_id in(494174)
and cast(sf_create_ts as date) < cast('08/09/2023' as date);

delete from INEO_FAC_BADGE_ROSTER
where employee_id in(494174,487680);


