/* Identify missing Avaya intervals in the NICE db. */
/* Missing interval times are in the local ACD's time zone. */
/* NICE: 10.150.140.20 */
set nocount on;
select 
  substring(acd.C_OID,5,4) "ACD ID",
  max(acd.C_NAME) "ACD Name",
  max(tzi.C_TZ) "ACD Local Time Zone",
  case 
    when i.NextDateTime is null then
	  convert(varchar(16),dateadd(minute,15,switchoffset(i.C_TIMESTAMP,tzi.C_TZOFFSET)),120)
	else
      convert(varchar(16),dateadd(minute,15,switchoffset(i.PrevDateTime,tzi.C_TZOFFSET)),120) 
	end "Start Missing Interval",
  case 
    when i.NextDateTime is null then
	  null
    else
     convert(varchar(16),switchoffset( i.C_TIMESTAMP,tzi.C_TZOFFSET),120) 
    end "End Missing Interval",
  case 
    when i.NextDateTime is null then
	  round(convert(float,( ((datediff(minute,dateadd(minute,15,i.C_TIMESTAMP),getUtcDate()) / 15) * 15) ) ) / 60 ,2) -- in whole increments of 15 minutes
	else
      round(convert(float,(datediff(minute,dateadd(minute,15,i.PrevDateTime),i.C_TIMESTAMP))) / 60 ,2)
	end "Missing Hours"
  ,count(*) "Num Queues Affected",
  case 
    when count(*) = 1 then
	   max(q.C_QTAG)
    when count(*) = 2 then
	  min(q.C_QTAG) + ', ' + max(q.C_QTAG)
	else
      min(q.C_QTAG) + ', ..., ' + max(q.C_QTAG) 
	end "Queues Affected"
from (
  select -- get all queue intervals for the past N days
    qs.C_QUEUE,
    qs.C_TIMESTAMP,
    lag(qs.C_TIMESTAMP,1,null) over (order by qs.C_QUEUE asc, qs.C_TIMESTAMP asc) PrevDateTime,
	lead(qs.C_TIMESTAMP,1,null) over (order by qs.C_QUEUE asc, qs.C_TIMESTAMP asc) NextDateTime
  from nice_wfm_customer1.dbo.R_QUEUESTATS qs
  where cast(qs.C_TIMESTAMP as date) >= cast(dateadd(day,-10,getDate()) as date)  -- start at 00:00 on SQL Server DB local timezone
  group by
    qs.C_QUEUE,
    qs.C_TIMESTAMP
  ) i
inner join nice_wfm_customer1.dbo.R_QUEUE q on i.C_QUEUE = q.C_OID
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID 
inner join nice_wfm_customer1.dbo.R_TZINFO tzi on acd.C_TZ = tzi.C_TZ and  i.C_TIMESTAMP between tzi.C_BEGIN and tzi.C_END
where 
  acd.C_Name != 'Cisco Enterprise'  -- Cisco db does not store data for intervals where number of calls is 0, so missed intervals cannot be detected using this query
  and 
    (
      (i.PrevDateTime is not null -- checks for past missed intervals not currently in-progress
       and datediff(minute,dateadd(minute,15,i.PrevDateTime), i.C_TIMESTAMP) >= 15) 
      or -- checks for missed intervals currently in-progress
	  (i.NextDateTime is null 
       and datediff(minute,dateadd(minute,15,i.C_TIMESTAMP),getUtcDate()) >= 30)
    )
group by
  acd.C_OID,
  acd.C_NAME,
  tzi.C_TZ,
  tzi.C_TZOFFSET,
  i.PrevDateTime,
  i.C_TIMESTAMP,
  i.NextDateTime
order by 
   acd.C_OID asc,
   i.C_TIMESTAMP desc;