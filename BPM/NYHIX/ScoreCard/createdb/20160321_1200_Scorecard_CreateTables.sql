 show errors;

 ---Tables
 CREATE TABLE PP_BO_SCORECARD
( sc_id                 NUMBER PRIMARY KEY,
  staff_id              NUMBER,
  sc_entry_date         DATE,
  adl_id                NUMBER,
  absence_type          VARCHAR2(150),
  point_value           NUMBER,
  comments              VARCHAR2(200),
  balance               NUMBER,
  incentive_balance     NUMBER,
  total_balance         NUMBER,
  incentive_flag        VARCHAR2(1),
  create_by             VARCHAR2(50),
  create_datetime       DATE
  );
  
 
 CREATE TABLE PP_BO_ABSENCE_DESCRIPTION_LKUP
( adl_id                NUMBER PRIMARY KEY,
  absence_type          VARCHAR2(150),
  point_value           NUMBER,
  display_seq           NUMBER,
  incentive_flag        VARCHAR2(1),
  end_date              DATE,
  create_by             VARCHAR2(50),
  create_datetime       DATE
  );  
  
 ---Index 
  CREATE INDEX ppbo_sc_staff_id ON PP_BO_SCORECARD(staff_id);
  
CREATE TABLE PP_BO_EVENT_TARGET_LKUP 
(event_id NUMBER
 ,name VARCHAR2(512)
 ,target NUMBER
 ,scorecard_flag VARCHAR2(1)
 ,start_date DATE
 ,end_date DATE
 ,create_by VARCHAR2(100)
 ,create_datetime DATE
 ,scorecard_group VARCHAR2(512)) TABLESPACE MAXDAT_DATA;

CREATE INDEX PPBO_EVENTTARGET_EVENT_ID ON PP_BO_EVENT_TARGET_LKUP(event_id) TABLESPACE MAXDAT_INDX;
 
 
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
  

  ---Scorecard Monthly View
CREATE or REPLACE VIEW PP_BO_SCORECARD_MONTHLY_SV AS
with all_recs as
(                   
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       to_char(dates, 'Month') as dates_month,
       to_char(dates, 'YYYYMM') as dates_month_num,
       to_char(dates, 'Month YYYY') as dates_year,
       total_balance,
       sc_id,
       create_datetime,
       rownum as rn
  from pp_bo_scorecard_sv
order by STAFF_ID, dates_month_num, create_datetime
),
ranked as
(
select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates,
       dates_month,
       dates_month_num,
       dates_year,
       total_balance,
       sc_id,
       create_datetime,
       rn
  from (select manager_name,
               supervisor_name,
               STAFF_ID,
               staff_name,
               dates,
               dates_month,
               dates_month_num,
               dates_year,
               total_balance,
               sc_id,
               create_datetime,
               rn,
               rank() over(partition by STAFF_ID, dates_month_num order by rn desc) as rnk
          from all_recs) y
where y.rnk = 1
),
just_months as
(
     SELECT 
      to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0 as total_balance,
      -1 as sc_id,
      0 as rn
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), to_date('01/01/2012','MM/DD/YYYY')) + 1                   
),
combined as
(
select r.manager_name,
       r.supervisor_name,
       r.STAFF_ID,
       r.staff_name,
       jm.dates_month,
       jm.dates_month_num,
       jm.dates_year,
       jm.total_balance,
       jm.sc_id,
       jm.rn from ranked r, just_months jm
       where jm.dates_month_num <> r.dates_month_num
  union
  select manager_name,
       supervisor_name,
       STAFF_ID,
       staff_name,
       dates_month,
       dates_month_num,
       dates_year,
       total_balance,
       sc_id,
       rn 
       from ranked  
       order by STAFF_ID, dates_month_num   
),
lead_balance as
(
select manager_name,
       supervisor_name,
       STAFF_ID,
       to_number(dates_month_num) as dates_month_num,
       total_balance,
       to_number(coalesce(lead (dates_month_num,1) over (partition by STAFF_ID ORDER BY STAFF_ID, dates_month_num ),'207707')) AS end_dates_month_num
from ranked
),
rolled_balances as
(
select c.manager_name,
       c.supervisor_name,
       c.STAFF_ID,
       c.staff_name,
       c.dates_month,
       c.dates_month_num,
       c.dates_year,
       coalesce((select total_balance
                  from lead_balance
                 where staff_id = c.staff_id
                   and (to_number(c.dates_month_num) >= dates_month_num and
                       to_number(c.dates_month_num) < end_dates_month_num)),
                0) as total_balance,
       c.total_balance as original_balance,
       c.sc_id,
       c.rn
  from combined c
 where c.dates_month_num in
       (select to_number(dates_month_num)
          from just_months
         where to_date(dates, 'mm/dd/yyyy') >= trunc(sysdate - 365))
)
select 
       STAFF_ID,
       dates_month,
       dates_month_num,
       dates_year,
       total_balance,
       sc_id,
       staff_name,
       supervisor_name,
       manager_name
       from
       (
          select manager_name,
                 supervisor_name,
                 STAFF_ID,
                 staff_name,
                 dates_month,
                 dates_month_num,
                 dates_year,
                 total_balance,
                 total_balance as original_balance,
                 sc_id,
                 rn,
                 rank() over(partition by STAFF_ID, dates_month_num order by sc_id desc) as rnk
            from rolled_balances
         ) where rnk=1 order by staff_id, dates_month_num;

  
 ---Sequences 
 create sequence SEQ_PBSC_ID
 minvalue 1
 maxvalue 999999999999999999999999999
 start with 1
 increment by 1
 cache 20;
 
 create sequence SEQ_PBADL_ID
 minvalue 1
 maxvalue 999999999999999999999999999
 start with 1
 increment by 1
 cache 20; 
  
  commit;
  
  /
  
