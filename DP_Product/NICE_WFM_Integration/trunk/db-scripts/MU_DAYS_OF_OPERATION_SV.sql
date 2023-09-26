-- DecisionPoint - NICE WFM
-- Management Unit Days of Operation
-- Build MicroStrategy cube from NICE WFM view via MANAGEMENT_UNIT_DATE.
-- Trim MicroStrategy cube not necessary.  All times are local Management Unit.
-- Only live project days are selected.
-- 2016-03-01 is the start of production NICE WFM data.

use nice_wfm_integration
go

create view MU_DAYS_OF_OPERATION_SV as
select
  eeg.C_NAME as ENTERPRISE_GROUP_NAME,
  em.C_NAME as MANAGEMENT_UNIT_NAME,
  cast(d_dates.D_DATE as date) as MANAGEMENT_UNIT_DATE,
  case 
    when 
	  ohd.C_DOW is not null 
	  and h.C_DATE is null 
	  and office_closure.OFFICE_CLOSURE_MU_DATE is null
	  then 'Y'
	else 'N'
    end as IS_DAY_OF_OPERATION,
  case 
    when h.C_DATE is not null then 'Y'
	else 'N'
    end as IS_HOLIDAY,
  case 
    when office_closure.OFFICE_CLOSURE_MU_DATE is not null then 'Y'
	else 'N'
    end as IS_OFFICE_CLOSURE,
  case 
    when h.C_DATE is null and office_closure.OFFICE_CLOSURE_MU_DATE is null then cast(d_dates.D_DATE as datetime) + cast(ohd.C_STIME as datetime)
	else null 
	end as OPEN_START_MU_DATETIME,
  case 
    when h.C_DATE is null and office_closure.OFFICE_CLOSURE_MU_DATE is null then cast(d_dates.D_DATE as datetime) + cast(ohd.C_ETIME as datetime)
	else null 
	end as OPEN_END_MU_DATETIME
from 
  (select 
     top (datediff(day,'2016-03-01',getdate()) + 1)
	 D_DATE = dateadd(day,row_number() over(order by a.object_id) - 1,'2016-03-01')
   from sys.all_objects a
   cross join sys.all_objects b) d_dates /* Generate list of all dates back to date shown. */
cross join nice_wfm_customer1.dbo.R_ENTITY em
inner join nice_wfm_customer1.dbo.R_HIERARCHY heg on em.C_OID = heg.C_CHILD and em.C_TYPE = 'M' and em.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY eeg on heg.C_PARENT = eeg.C_OID and eeg.C_TYPE = 'E' and eeg.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_MU mu on em.C_OID = mu.C_OID
left outer join nice_wfm_customer1.dbo.R_OPENHOURSDTL ohd on mu.C_OPENHOURS = ohd.C_OPENHOURS and datepart(dw,d_dates.D_DATE) = ohd.C_DOW + 1
left outer join nice_wfm_customer1.dbo.R_HOLIDAY h on d_dates.D_DATE = cast(h.C_DATE as date)
left outer join nice_wfm_customer1.dbo.R_MUHOLIDAY mh on mu.C_OID = mh.C_MU and h.C_OID = mh.C_HOLIDAY and mh.C_OPEN = 'F'
left outer join nice_wfm_integration.dbo.ENTERPRISE_GROUP_AMP ega on eeg.C_NAME = ega.ENTERPRISE_GROUP_NAME 
left outer join 
  (select
   	 mr.C_MU,
	 cast(asa.C_DATE as date) as OFFICE_CLOSURE_MU_DATE
   from nice_wfm_customer1.dbo.R_EXCP e 
   inner join nice_wfm_customer1.dbo.R_AGTSCHEDDTLACT asda on e.C_NAME = 'Office Closure' and e.C_OID = asda.C_EXCP
   inner join nice_wfm_customer1.dbo.R_AGTSCHEDACT asa on asda.C_AGTSCHED = asa.C_OID
   inner join nice_wfm_customer1.dbo.R_AGT a on asa.C_AGT = a.C_OID and a.C_ACT = 'A'
   inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and mr.C_ACT = 'A' and asa.C_DATE >= mr.C_SDATE and asa.C_DATE <= coalesce(mr.C_EDATE,cast(mr.C_EDATE as date),dateadd(d,1,sysutcdatetime()))
   group by
     mr.C_MU,
     asa.C_DATE
  ) office_closure on mu.C_OID = office_closure.C_MU and d_dates.D_DATE = office_closure.OFFICE_CLOSURE_MU_DATE
where
  cast(d_dates.D_DATE as date) >= coalesce(ega.NICE_WFM_START_DATE,'2016-03-01')
  and cast(d_dates.D_DATE as date) <= coalesce(ega.NICE_WFM_END_DATE,ega.NICE_WFM_END_DATE,dateadd(d,1,sysutcdatetime()));