WITH CT_Set_CTE
(c_name
,c_oid
)
AS
(select c_name, c_oid 
 from nice_wfm_customer1.dbo.r_entityset 
 where c_name in 
('CA-FSS CT MCAP'
,'CA-FSS CT MFP'
,'CA-FSS CT MH'
,'CA-HCO CT Callbacks'
,'CA-HCO CT Inbound'
,'IL-CES CT SET GENERAL INBOUND'
,'IL-CES CT SET GENERAL OUTBOUND'
,'IL-CES CT SET INBOUND'
,'IL-CES CT SET OUTBOUND'
,'IL-CES CT SET SPEC INBOUND'
,'IL-CES CT SET SPEC OUTBOUND SET'
,'IL-EEV CT ALL'
,'MA-BOS CT All'
,'MI-APCC CT Set All'
,'MI-EBS CT Set All'
)
)
,
PLAN_CTE 
(CT_Set
,CT
,Interval
,c_origslreqmethod
,c_origslreq
,c_origeffsl
,c_origasareq
,c_origeffasa
,c_origmaxoccreq
,c_tzoffset
)
AS
(
select es.c_name as CT_Set
,e.c_name as CT
--,f.c_gentime as generated_time
,p.c_fcstprd as Interval
,p.c_origslreqmethod
,p.c_origslreq
,p.c_origeffsl
,p.c_origasareq
,p.c_origeffasa
,p.c_origmaxoccreq
,tz.c_tzoffset
from
nice_wfm_customer1.dbo.r_eg eg
inner join nice_wfm_customer1.dbo.r_plan p on p.c_fcst = eg.c_actfcst 
inner join nice_wfm_customer1.dbo.r_ct ct on p.c_ct = ct.c_oid
inner join nice_wfm_customer1.dbo.r_entity e on ct.c_oid = e.c_oid and c_type = 'T'
--inner join nice_wfm_customer1.dbo.r_fcst f on p.c_fcst = f.c_oid
inner join nice_wfm_customer1.dbo.r_entitysetmbr em 
		on e.c_oid = em.c_entity
inner join CT_Set_CTE es 
		on em.c_entityset = es.c_oid
inner join nice_wfm_customer1.dbo.r_tzinfo tz 
		on e.c_tz = tz.c_tz 
		and p.c_fcstprd >= tz.c_begin 
		and p.c_fcstprd < tz.c_end
and Convert(char,Cast(switchoffset(p.c_fcstprd, tz.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -7,23)
and Convert(char,Cast(switchoffset(p.c_fcstprd, tz.c_tzoffset) as date),126) <= convert(varchar, cast(cast(getdate() as varchar(12)) as datetime),23)
)
,
HIERARCHY_CTE (
CT_Set
,CT
,Interval
,c_revconttime
,c_revworktime
,c_revreadytime
,c_tzoffset
)
AS
(
select es.c_name as CT_Set
,e.c_name as CT
,qs.c_timestamp as Interval
,qs.c_revconttime
,qs.c_revworktime
,qs.c_revreadytime
,tz.c_tzoffset
from
nice_wfm_customer1.dbo.r_hierarchy h
join nice_wfm_customer1.dbo.r_entity e 
		on h.c_parent = e.c_oid 
		and h.c_act = 'A' 
		and e.c_act = 'A' 
		and e.c_type = 'T'
join nice_wfm_customer1.dbo.r_queuestats qs 
		on qs.c_queue = h.c_child 
		and qs.c_timestamp >= h.c_sdate  
		and (h.c_edate IS NULL or qs.c_timestamp <= h.c_edate)
join nice_wfm_customer1.dbo.r_ct ct 
		on ct.c_oid = e.c_oid
join nice_wfm_customer1.dbo.r_entitysetmbr em 
		on e.c_oid = em.c_entity
join CT_Set_CTE es 
		on em.c_entityset = es.c_oid
inner join nice_wfm_customer1.dbo.r_tzinfo tz 
		on e.c_tz = tz.c_tz 
		and qs.c_timestamp >= tz.c_begin 
		and qs.c_timestamp < tz.c_end
and Convert(char,Cast(switchoffset(qs.c_timestamp, tz.c_tzoffset) as date), 126) >= convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -7,23)
and Convert(char,Cast(switchoffset(qs.c_timestamp, tz.c_tzoffset) as date), 126) <= convert(varchar, cast(cast(getdate() as varchar(12)) as datetime),23)
)
select ---Main Grid Query 1 
'Main Grid' as Total
,t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date) as Date
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,null as Delta
,null as Pct_Need
from PLAN_CTE t1
  left outer join HIERARCHY_CTE  t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
group by t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)

UNION ALL

select ---Main Grid Query 2 
'Main Grid' as Total
,t1.CT_Set
,'All'
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date) as Date
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,null as Delta
,null as Pct_Need
from PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
group by t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)

UNION ALL

select 'Grand Total - SunSatPrevWk' as Total ---Grand Total Sun - Sat Previous Week Query 1
,fin.CT_Set
,fin.CT
,null Date
,null Interval
,null Orig_Required
,null Est_Staff
,sum(fin.weighted_delta) as Delta
,sum(fin.weighted_pct) as Pct_Need
from
(select tot.CT_Set
,tot.CT
,tot.Interval
,abs(tot.Delta) * Case When sum(Orig_Required) over(partition by tot.CT) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT,tot.Interval)/sum(Orig_Required) over(partition by tot.CT) end as weighted_delta
,abs(tot.Pct_Delta) * Case When sum(Orig_Required) over(partition by tot.CT) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT,tot.Interval)/sum(Orig_Required) over(partition by tot.CT) end as weighted_pct
from (
select t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Delta
,case when round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) = 0 then 0 else (round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2))/round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) end as Pct_Delta
from PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
Where Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -7,23)
and Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) <= convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -1,23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -7,23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) <= convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -1,23)
group by t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)
) tot)fin
group by fin.CT_Set, fin.CT

UNION ALL

select 'Grand Total - SunSatPrevWk' as Total ---Grand Total Sun - Sat Previous Query 2
,fin.CT_Set
,'All'
,null Date
,null Interval
,null Orig_Required
,null Est_Staff
,sum(fin.weighted_delta) as Delta
,sum(fin.weighted_pct) as Pct_Need
from
(select tot.CT_Set
,tot.Interval
,abs(tot.Delta) * Case When sum(Orig_Required) over(partition by tot.CT_Set) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT_Set,tot.Interval)/sum(Orig_Required) over(partition by tot.CT_Set) end as weighted_delta
,abs(tot.Pct_Delta) * Case When sum(Orig_Required) over(partition by tot.CT_Set) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT_Set,tot.Interval)/sum(Orig_Required) over(partition by tot.CT_Set) end as weighted_pct
from (
select t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Delta
,case when round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) = 0 then 0 else (round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2))/round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) end as Pct_Delta
from  PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
Where Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -7,23)
and Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) <= convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -1,23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -7,23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) <= convert(varchar, cast(cast(DATEADD(DD, 1 - DATEPART(DW, GETDATE()), GETDATE()) as varchar(12)) as datetime) -1,23)
group by t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)
) tot)fin
group by fin.CT_Set

UNION ALL

select 'Grand Total - 5DaysPrev' as Total ---Grand Total 5 days previous Query 1
,fin.CT_Set
,fin.CT
,null Date
,null Interval
,null Orig_Required
,null Est_Staff
,sum(fin.weighted_delta) as Delta
,sum(fin.weighted_pct) as Pct_Need
from
(select tot.CT_Set
,tot.CT
,tot.Interval
,abs(tot.Delta) * Case When sum(Orig_Required) over(partition by tot.CT) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT,tot.Interval)/sum(Orig_Required) over(partition by tot.CT) end as weighted_delta
,abs(tot.Pct_Delta) * Case When sum(Orig_Required) over(partition by tot.CT) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT,tot.Interval)/sum(Orig_Required) over(partition by tot.CT) end as weighted_pct
from (
select t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Delta
,case when round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) = 0 then 0 else (round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2))/round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) end as Pct_Delta
from PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
Where Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(getdate()-5 as varchar(12)) as datetime),23)
and Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) <= convert(varchar, cast(cast(getdate()-1 as varchar(12)) as datetime),23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(getdate()-5 as varchar(12)) as datetime),23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) <= convert(varchar, cast(cast(getdate()-1 as varchar(12)) as datetime),23)
group by t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)
) tot)fin
group by fin.CT_Set, fin.CT


UNION ALL

select 'Grand Total - 5DaysPrev' as Total  ---Grand Total 5 days previous Query 2
,fin.CT_Set
,'All'
,null Date
,null Inteval
,null Orig_Required
,null Est_Staff
,sum(fin.weighted_delta) as Delta
,sum(fin.weighted_pct) as Pct_Need
from
(select tot.CT_Set
,tot.Interval
,abs(tot.Delta) * Case When sum(Orig_Required) over(partition by tot.CT_Set) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT_Set,tot.Interval)/sum(Orig_Required) over(partition by tot.CT_Set) end as weighted_delta
,abs(tot.Pct_Delta) * Case When sum(Orig_Required) over(partition by tot.CT_Set) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT_Set,tot.Interval)/sum(Orig_Required) over(partition by tot.CT_Set) end as weighted_pct
from (
select t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Delta
,case when round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) = 0 then 0 else (round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2))/round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) end as Pct_Delta
from  PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
Where Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(getdate()-5 as varchar(12)) as datetime),23)
and Convert(char,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date),126) <= convert(varchar, cast(cast(getdate()-1 as varchar(12)) as datetime),23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) >=  convert(varchar, cast(cast(getdate()-5 as varchar(12)) as datetime),23)
and Convert(char,Cast(switchoffset(t2.Interval, t2.c_tzoffset) as date),126) <= convert(varchar, cast(cast(getdate()-1 as varchar(12)) as datetime),23)
group by t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)
) tot)fin
group by fin.CT_Set

UNION ALL

select 'Weighted Average' as Total ---Weighted Averages - Query 1
,fin.CT_Set
,fin.CT
,fin.Date
,null Interval
,null Orig_Required
,null Est_Staff
,sum(fin.weighted_delta) as Delta
,sum(fin.weighted_pct) as Pct_Need
from
(select tot.CT_Set
,tot.CT
,tot.Interval
,tot.Date
,abs(tot.Delta) * Case When sum(Orig_Required) over(partition by tot.CT,tot.Date) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT,tot.Interval)/sum(Orig_Required) over(partition by tot.CT,tot.Date) end as weighted_delta
,abs(tot.Pct_Delta) * Case When sum(Orig_Required) over(partition by tot.CT,tot.Date) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT,tot.Interval)/sum(Orig_Required) over(partition by tot.CT,tot.Date) end as weighted_pct
from
(select t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date) as Date
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Delta
,case when round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) = 0 then 0 else (round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2))/round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) end as Pct_Delta
from PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
group by t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)) tot)fin
group by fin.CT_Set, fin.CT, fin.Date


UNION ALL

select 'Weighted Average' as Total ---Weighted Averages - Query 2
,fin.CT_Set
,'All'
,fin.Date
,null Interval
,null Orig_Required
,null Est_Staff
,sum(fin.weighted_delta) as Delta
,sum(fin.weighted_pct) as Pct_Need
from
(select tot.CT_Set
,tot.Interval
,tot.Date
,abs(tot.Delta) * Case When sum(Orig_Required) over(partition by tot.CT_Set,tot.Date) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT_Set,tot.Interval)/sum(Orig_Required) over(partition by tot.CT_Set,tot.Date) end as weighted_delta
,abs(tot.Pct_Delta) * Case When sum(Orig_Required) over(partition by tot.CT_Set,tot.Date) = 0 then 0 else 
      sum(tot.Orig_Required) over(partition by tot.CT_Set,tot.Interval)/sum(Orig_Required) over(partition by tot.CT_Set,tot.Date) end as weighted_pct
from
(select t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date) as Date
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) as Delta
,case when round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) = 0 then 0 else (round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
  + cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2)
  - round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2))/round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) end as Pct_Delta
from PLAN_CTE t1
  left outer join HIERARCHY_CTE t2
  on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
group by t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
having (round(sum(Case When t1.c_origslreq is not null then (cast(t1.c_origslreq as float) * cast(t1.c_origeffsl as float)) When t1.c_origasareq is not null
  then (cast(t1.c_origasareq as float) * cast(t1.c_origeffasa as float)) else t1.c_origmaxoccreq end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)) tot)fin
group by fin.CT_Set, fin.Date