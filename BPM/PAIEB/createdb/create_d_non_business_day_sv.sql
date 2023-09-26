create or replace view d_non_business_Days_sv as
select d_date d_date, d.business_day_flag, 'N' holiday_flag, d.weekend_flag 
from maxdat_support.bpm_d_dates d
where d_date >= trunc(add_months(sysdate, -13),'YYYY')
and weekend_flag = 'Y'
union
select holiday_date d_date, 'N' business_day_flag, 'Y' holiday_flag, 'N' weekend_flag
from ats.holidays
where holiday_date >= trunc(add_months(sysdate, -13),'YYYY')
order by d_date
;

GRANT SELECT ON MAXDAT_SUPPORT.D_NON_BUSINESS_DAYS_SV TO MAXDAT_REPORTS; 

GRANT SELECT ON MAXDAT_SUPPORT.D_NON_BUSINESS_DAYS_SV TO MAXDATSUPPORT_PFP_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_NON_BUSINESS_DAYS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_NON_BUSINESS_DAYS_SV TO MAXDAT_SUPPORT_READ_ONLY;