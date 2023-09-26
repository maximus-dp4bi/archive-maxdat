ALTER TABLE pp_bo_scorecard
  DROP COLUMN balance;
  
  
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
       sc.comments,
       sc.sc_id,
       sc.create_datetime
  from staff s
inner join pp_bo_scorecard sc
    on s.STAFF_ID = sc.staff_id
),
sc_all_entries as
(
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       absence_type,
       point_value,
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
       comments,
       sc_id,
       create_datetime
  from sc_entries
order by manager_name, supervisor_name,STAFF_ID,dates, create_datetime
),
sc_all_entries_brt as 
(
select 
       manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       absence_type,
       point_value,
       greatest(0,least(40,sum(coalesce(point_value,0)) over (partition by staff_id order by dates asc, create_datetime asc))) bounded_running_total,
       comments,
       sc_id,
       create_datetime
  from sc_all_entries)
select 
       manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       absence_type,
       greatest(0,least(40,coalesce(point_value,0) + lag(bounded_running_total,1,0) over (partition by staff_id order by dates asc, create_datetime asc))) balance, 
       point_value,
       comments,
       sc_id,
       create_datetime
  from sc_all_entries_brt
  order by
    manager_name asc,
    supervisor_name asc,
    staff_id asc,
    dates asc,
    create_datetime asc;
 
  GRANT select on PP_BO_SCORECARD_SV to MAXDAT_READ_ONLY;  
  GRANT execute ON Update_Scorecard TO MAXDAT_MSTR_TRX_RPT;
  --new entries
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Delete',  0, 15, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +1',  1, 16, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +2',  2, 17, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +3',  3, 18, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +4',  4, 19, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +5',  5, 20, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);
insert into PP_BO_ABSENCE_DESCRIPTION_LKUP values(SEQ_PBSC_ID.Nextval,'Incentive +6',  6, 21, to_date('07/07/2077','mm/dd/yyyy'), 'script', sysdate);

  commit;
  
  /
