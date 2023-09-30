CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUARTERLY_BUSINESS_DAYS_SV
AS
with mths as
( 
select to_char(add_months(sysdate,0),'yyyymm') as dates_Month_num 
	from dual union 
select to_char(add_months(sysdate,-1),'yyyymm') from dual union 
select to_char(add_months(sysdate,-2),'yyyymm') from dual union 
select to_char(add_months(sysdate,-3),'yyyymm') from dual --union 
--select to_char(add_months(sysdate,+1),'yyyymm') from dual union 
--select to_char(add_months(sysdate,+2),'yyyymm') from dual union 
--select to_char(add_months(sysdate,+3),'yyyymm') from dual  
),
qtrs as
(
select  
    mths.dates_month_num,
--   'Q'||to_char(add_months(to_date(mths.dates_month_num,'yyyymm'),+3),'Q')
--    ||' '||
    to_char(add_months(to_date(mths.dates_month_num,'yyyymm'),+3),'YYYY')
    ||'Q'||to_char(add_months(to_date(mths.dates_month_num,'yyyymm'),+3),'Q') as dates_qtr_year
from mths
union
select to_char(trunc(d_date),'YYYYMM'),
    to_char(add_months(trunc(d_date,'MM'),+3),'YYYY')
    ||'Q'||to_char(add_months(trunc(d_date,'MM'),+3),'Q') as dates_qtr_year
from maxdat.bpm_d_dates
),
full_qtrs as
(
select dates_qtr_year, dates_month_num
from qtrs
where dates_qtr_year in 
( select dates_qtr_year from qtrs
    group by dates_qtr_year
 having sum(1) = 3
 )
),
qtr_first_and_last_mth
as
(
select dates_qtr_year, 
    min(dates_month_num) as first_month_of_qtr, 
    max(dates_month_num) as last_month_of_qtr 
from full_qtrs
group by dates_qtr_year
),
bus_days_per_qtr as
(
select  to_char(add_months(trunc(d_date,'MM'),+3),'YYYY')
        ||'Q'||to_char(add_months(trunc(d_date,'MM'),+3),'Q') as dates_qtr_year,
    sum(1) NUM_BUS_DAYS, 
    min(d_date) as first_bus_day,
    max(d_date) as last_bus_day
from maxdat.bpm_d_dates
where business_day_flag = 'Y'
group by --to_char(trunc(d_date),'YYYYMM')
to_char(add_months(trunc(d_date,'MM'),+3),'YYYY')
    ||'Q'||to_char(add_months(trunc(d_date,'MM'),+3),'Q')
)
select F_and_L.dates_qtr_year, 
    F_and_L.first_month_of_qtr, 
    F_and_L.last_month_of_qtr,
    trunc(to_date(F_and_L.first_month_of_qtr,'YYYYMM'),'MM') as first_day_of_qtr,
    last_day(trunc(to_date(F_and_L.last_month_of_qtr,'YYYYMM'),'MM')) as last_day_of_qtr,
    BD.num_bus_days  as BUS_DAYS_IN_QTR,
    BD.first_bus_day    as first_bus_day_of_qtr,
    bd.last_bus_day     AS last_bus_day_OF_QTR
from qtr_first_and_last_mth  F_and_L 
join bus_days_per_qtr BD on BD.dates_qtr_year = F_and_L.dates_qtr_year  
order by 1 desc
/

GRANT SELECT ON DP_SCORECARD.SCORECARD_QUARTERLY_BUSINESS_DAYS_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUARTERLY_BUSINESS_DAYS_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUARTERLY_BUSINESS_DAYS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_QUARTERLY_BUSINESS_DAYS_SV TO DP_SCORECARD_READ_ONLY;