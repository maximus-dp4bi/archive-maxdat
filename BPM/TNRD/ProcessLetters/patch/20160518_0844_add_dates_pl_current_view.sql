create or replace view D_PL_CURRENT_SV as
select pl.*,
      (SELECT case_cin FROM app_case_link_stg cls WHERE cls.case_id = pl.case_id
        AND cls.create_ts = (SELECT MAX(cls1.create_ts) FROM app_case_link_stg cls1 WHERE cls.case_id = cls1.case_id)) state_case_id,
      get_business_date(TRUNC(pl.mailed_date),20) after20_busdays,
      CASE WHEN TO_CHAR(pl.mailed_date + 40,'D') IN ('1','7') OR EXISTS(SELECT 1 FROM holidays h WHERE h.holiday_date = TRUNC(pl.mailed_date)) THEN
         get_business_date(TRUNC(pl.mailed_date+40),1) ELSE TRUNC(pl.mailed_date)+40 END after40_caldays   
from D_PL_CURRENT pl
with read only;

grant select on D_PL_CURRENT_SV to MAXDAT_READ_ONLY;