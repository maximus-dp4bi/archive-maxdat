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
         
 GRANT select on PP_BO_SCORECARD_MONTHLY_SV to MAXDAT_READ_ONLY;          
 
 commit;
 
 /


