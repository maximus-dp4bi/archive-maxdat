-- DecisionPoint - NICE WFM
-- Generate list of all dates for last 3 complete months + with complete week to today + 30 days.
-- Examples:
--		on Tuesday August 20, 2019:  Sunday April 28, 2019 to Thursday September 19, 2019
--		on Tuesday December 16, 2019:  Sunday September 1, 2019 to Thursday January 15, 2020
-- Build MicroStrategy cube from NICE WFM view.

use nice_wfm_integration
go

create view D_DATE_SV as
select
  cast(d_dates.D_DATE as date) as D_DATE
from 
  (select 
     top (datediff(day,dateadd(dd, - datepart(dw,dateadd(mm,datediff(mm,0,getdate()) - 3,0) ) + 1, dateadd(mm,datediff(mm,0,getdate()) - 3,0)),getdate() + 31))
	 D_DATE = dateadd(day,row_number() over(order by a.object_id) - 1,dateadd(dd, - datepart(dw,dateadd(mm,datediff(mm,0,getdate()) - 3,0) ) + 1, dateadd(mm,datediff(mm,0,getdate()) - 3,0)))
   from sys.all_objects a
   cross join sys.all_objects b) d_dates;