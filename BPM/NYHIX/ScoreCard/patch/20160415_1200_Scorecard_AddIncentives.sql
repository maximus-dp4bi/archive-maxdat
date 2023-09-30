 
ALTER TABLE pp_bo_scorecard
  ADD incentive_balance number
  ADD total_balance number
  ADD incentive_flag VARCHAR2(1);  
  
ALTER TABLE PP_BO_ABSENCE_DESCRIPTION_LKUP
  ADD incentive_flag        VARCHAR2(1);


 ---Scorecard View
CREATE or REPLACE VIEW PP_BO_SCORECARD_SV AS
with managers as
(
select LTRIM(a13.NAME, 'Manager - ') as manager_name, a12.STAFF_ID
  from PP_BO_STAFF_GROUP_TO_STAFF_SV a12
  join PP_BO_STAFF_GROUP_SV a13
    on (a12.STAFF_GROUP_ID = a13.STAFF_GROUP_ID)
   and a12.END_DATE is null
   and a13.DESCRIPTION = 'NYSOH-EE'
),
staff as
(select  distinct 
pa12.manager_name,
a15.LAST_NAME || ' , ' || a15.FIRST_NAME as supervisor_name,
pa12.STAFF_ID,
a14.LAST_NAME || ' , ' || a14.FIRST_NAME as staff_name,
a14.HIRE_DATE,
a14.TERMINATION_DATE,
0 as sc_id,
a14.HIRE_DATE as create_datetime
from  managers  pa12
  join  PP_BO_SUPERVISOR_TO_STAFF_SV  a13
    on   (pa12.STAFF_ID = a13.STAFF_ID)
  join  PP_BO_STAFF_SV  a14
    on   (a13.STAFF_ID = a14.STAFF_ID and pa12.STAFF_ID = a14.STAFF_ID)
  join  PP_BO_STAFF_SV  a15
    on   (a13.SUPERVISOR_ID = a15.STAFF_ID)
where (a14.TERMINATION_DATE is null or trunc(a14.TERMINATION_DATE) > trunc(sysdate-14))
order by pa12.manager_name,supervisor_name,staff_name
),
sc_starting_balance as
(
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       HIRE_DATE as dates,
       'Starting Balance' as absence_type,
       40 as point_value,
       40 as balance,
       0 as incentive_balance,
       40 as total_balance,
       NULL as incentive_flag,
       NULL as comments,
       sc_id,
       create_datetime
  from staff
),
sc_entries as
(
select s.manager_name,
       s.supervisor_name,
       s.STAFF_ID,
       s.staff_name,
       sc.sc_entry_date as dates,
       sc.absence_type,
       sc.point_value,
       sc.balance,
       sc.incentive_balance,
       sc.total_balance,
       sc.incentive_flag,
       sc.comments,
       sc.sc_id,
       sc.create_datetime
  from staff s
inner join pp_bo_scorecard sc
    on s.STAFF_ID = sc.staff_id
), 
all_sc_entries as
(
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       comments,
       sc_id,
       create_datetime
  from sc_starting_balance
union all
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       comments,
       sc_id,
       create_datetime
  from sc_entries
)
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       comments,
       sc_id,
       create_datetime
  from all_sc_entries
order by manager_name, supervisor_name,STAFF_ID,dates, create_datetime;

update PP_BO_ABSENCE_DESCRIPTION_LKUP set incentive_flag='Y' where adl_id in (
select adl_id from PP_BO_ABSENCE_DESCRIPTION_LKUP where absence_type like 'Incentive%');

  commit;
  
  /
