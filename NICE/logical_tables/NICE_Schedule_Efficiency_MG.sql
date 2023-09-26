select ---Main Grid Query 1 
'Main Grid' as Total
,t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date) as Date
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as time) as IntervalTO
,round(sum(Case WHEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) AND isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0)
WHEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) and isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) 
Else ISNULL(t1.c_revmaxoccreq,0) end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
from 
(
select es.c_name as CT_Set
,e.c_name as CT
,p.c_fcstprd as Interval
,p.c_revslreqmethod
,p.c_revslreq
,p.c_reveffsl
,p.c_revasareq
,p.c_reveffasa
,p.c_revmaxoccreq
,tz.c_tzoffset
FROM nice_wfm_customer1.dbo.r_eg eg
inner join nice_wfm_customer1.dbo.r_plan p on p.c_fcst = eg.c_actfcst 
inner join nice_wfm_customer1.dbo.r_ct ct on p.c_ct = ct.c_oid
inner join nice_wfm_customer1.dbo.r_entity e on ct.c_oid = e.c_oid and c_type = 'T'
inner join nice_wfm_customer1.dbo.r_entitysetmbr em on e.c_oid = em.c_entity
inner join nice_wfm_customer1.dbo.r_entityset es on em.c_entityset = es.c_oid AND es.c_name in 
('CA-FSS CT MCAP','CA-FSS CT MFP','CA-FSS CT MH','CA-FSS CT TN','CA-HCO CT Callbacks','CA-HCO CT Inbound','CA-HCO CT Overall','FL-FHK Inbound','GA-GF Atlanta Inbound','GA-GF Atlanta Outbound','GA-GF LABH Only Inbound','GA-GF LABH Only Outbound','GA-GF LARA Only Inbound','GA-GF Louisiana Only Inbound','GA-GF NH Only','GA-IES All CTs','GA-IES CTC All CTs','GA-IES HelpDesk','IL-CES CT SET GENERAL INBOUND','IL-CES CT SET GENERAL OUTBOUND','IL-CES CT SET INBOUND','IL-CES CT SET OUTBOUND','IL-CES CT SET SPEC INBOUND','IL-CES CT SET SPEC OUTBOUND SET','IL-EEV CT ALL','MA-BOS CT All','MBSHCC CT Set All','MD-HBE All','MD-HBE Glendale','MD-HBE Lord Baltimore','MI-APCC CT Set All','MI-CSCC CT Set All','MI-EBS CT Set All','MI-MSS CT Set','MI-PSSCC CT Set All','MO-CS All CTs','PA-EAP Inbound','SOA Custom CT Set','VA-EBS CT Set All','VA-SOA GA-GF ALL','VA-SOA LARA All','VA-SOA MAH ALL','VT-VHC Inbound','MI-WR CT Set All')
inner join nice_wfm_customer1.dbo.r_tzinfo tz on e.c_tz = tz.c_tz and p.c_fcstprd >= tz.c_begin and p.c_fcstprd < tz.c_end
and Convert(char,Cast(switchoffset(p.c_fcstprd, tz.c_tzoffset) as date),126) = convert(varchar, cast(cast(DATEADD(DD, 0, GETDATE()) as varchar(12)) as datetime) -1,23)
) t1
  left outer join (
select es.c_name as CT_Set
,e.c_name as CT
,qs.c_timestamp as Interval
,qs.c_revconttime
,qs.c_revworktime
,qs.c_revreadytime
,tz.c_tzoffset
from
nice_wfm_customer1.dbo.r_hierarchy h
join nice_wfm_customer1.dbo.r_entity e 	on h.c_parent = e.c_oid and h.c_act = 'A' and e.c_act = 'A' and e.c_type = 'T'
join nice_wfm_customer1.dbo.r_queuestats qs on qs.c_queue = h.c_child and qs.c_timestamp >= h.c_sdate  and (h.c_edate IS NULL or qs.c_timestamp <= h.c_edate)
join nice_wfm_customer1.dbo.r_ct ct on ct.c_oid = e.c_oid
join nice_wfm_customer1.dbo.r_entitysetmbr em on e.c_oid = em.c_entity
inner join nice_wfm_customer1.dbo.r_entityset es on em.c_entityset = es.c_oid AND es.c_name in 
('CA-FSS CT MCAP','CA-FSS CT MFP','CA-FSS CT MH','CA-FSS CT TN','CA-HCO CT Callbacks','CA-HCO CT Inbound','CA-HCO CT Overall','FL-FHK Inbound','GA-GF Atlanta Inbound','GA-GF Atlanta Outbound','GA-GF LABH Only Inbound','GA-GF LABH Only Outbound','GA-GF LARA Only Inbound','GA-GF Louisiana Only Inbound','GA-GF NH Only','GA-IES All CTs','GA-IES CTC All CTs','GA-IES HelpDesk','IL-CES CT SET GENERAL INBOUND','IL-CES CT SET GENERAL OUTBOUND','IL-CES CT SET INBOUND','IL-CES CT SET OUTBOUND','IL-CES CT SET SPEC INBOUND','IL-CES CT SET SPEC OUTBOUND SET','IL-EEV CT ALL','MA-BOS CT All','MBSHCC CT Set All','MD-HBE All','MD-HBE Glendale','MD-HBE Lord Baltimore','MI-APCC CT Set All','MI-CSCC CT Set All','MI-EBS CT Set All','MI-MSS CT Set','MI-PSSCC CT Set All','MO-CS All CTs','PA-EAP Inbound','SOA Custom CT Set','VA-EBS CT Set All','VA-SOA GA-GF ALL','VA-SOA LARA All','VA-SOA MAH ALL','VT-VHC Inbound','MI-WR CT Set All')
inner join nice_wfm_customer1.dbo.r_tzinfo tz on e.c_tz = tz.c_tz and qs.c_timestamp >= tz.c_begin and qs.c_timestamp < tz.c_end
and Convert(char,Cast(switchoffset(qs.c_timestamp, tz.c_tzoffset) as date), 126) = convert(varchar, cast(cast(DATEADD(DD, 0, GETDATE()) as varchar(12)) as datetime) -1,23)
) t2 on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
group by t1.CT_Set
,t1.CT
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as time)
having (round(sum(Case WHEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) AND isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0)
WHEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) and isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) 
Else ISNULL(t1.c_revmaxoccreq,0) end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)
UNION ALL
select ---Main Grid Query 2 
'Main Grid' as Total
,t1.CT_Set
,'All'
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date) as Date
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime) as Interval
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as time) as IntervalTO
,round(sum(Case WHEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) AND isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0)
WHEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) and isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) 
Else ISNULL(t1.c_revmaxoccreq,0) end),2) as Orig_Required
,round(Coalesce(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,0),2) as Est_Staff
from (
select es.c_name as CT_Set
,e.c_name as CT
,p.c_fcstprd as Interval
,p.c_revslreqmethod
,p.c_revslreq
,p.c_reveffsl
,p.c_revasareq
,p.c_reveffasa
,p.c_revmaxoccreq
,tz.c_tzoffset
from
nice_wfm_customer1.dbo.r_eg eg
inner join nice_wfm_customer1.dbo.r_plan p on p.c_fcst = eg.c_actfcst 
inner join nice_wfm_customer1.dbo.r_ct ct on p.c_ct = ct.c_oid
inner join nice_wfm_customer1.dbo.r_entity e on ct.c_oid = e.c_oid and c_type = 'T'
inner join nice_wfm_customer1.dbo.r_entitysetmbr em on e.c_oid = em.c_entity
inner join nice_wfm_customer1.dbo.r_entityset es on em.c_entityset = es.c_oid AND es.c_name in 
('CA-FSS CT MCAP','CA-FSS CT MFP','CA-FSS CT MH','CA-FSS CT TN','CA-HCO CT Callbacks','CA-HCO CT Inbound','CA-HCO CT Overall','FL-FHK Inbound','GA-GF Atlanta Inbound','GA-GF Atlanta Outbound','GA-GF LABH Only Inbound','GA-GF LABH Only Outbound','GA-GF LARA Only Inbound','GA-GF Louisiana Only Inbound','GA-GF NH Only','GA-IES All CTs','GA-IES CTC All CTs','GA-IES HelpDesk','IL-CES CT SET GENERAL INBOUND','IL-CES CT SET GENERAL OUTBOUND','IL-CES CT SET INBOUND','IL-CES CT SET OUTBOUND','IL-CES CT SET SPEC INBOUND','IL-CES CT SET SPEC OUTBOUND SET','IL-EEV CT ALL','MA-BOS CT All','MBSHCC CT Set All','MD-HBE All','MD-HBE Glendale','MD-HBE Lord Baltimore','MI-APCC CT Set All','MI-CSCC CT Set All','MI-EBS CT Set All','MI-MSS CT Set','MI-PSSCC CT Set All','MO-CS All CTs','PA-EAP Inbound','SOA Custom CT Set','VA-EBS CT Set All','VA-SOA GA-GF ALL','VA-SOA LARA All','VA-SOA MAH ALL','VT-VHC Inbound','MI-WR CT Set All')
inner join nice_wfm_customer1.dbo.r_tzinfo tz on e.c_tz = tz.c_tz and p.c_fcstprd >= tz.c_begin and p.c_fcstprd < tz.c_end
and Convert(char,Cast(switchoffset(p.c_fcstprd, tz.c_tzoffset) as date),126) =  convert(varchar, cast(cast(DATEADD(DD, 0, GETDATE()) as varchar(12)) as datetime) -1,23)
) t1 left outer join (
select es.c_name as CT_Set
,e.c_name as CT
,qs.c_timestamp as Interval
,qs.c_revconttime
,qs.c_revworktime
,qs.c_revreadytime
,tz.c_tzoffset
from
nice_wfm_customer1.dbo.r_hierarchy h
join nice_wfm_customer1.dbo.r_entity e on h.c_parent = e.c_oid and h.c_act = 'A' and e.c_act = 'A' and e.c_type = 'T'
join nice_wfm_customer1.dbo.r_queuestats qs on qs.c_queue = h.c_child and qs.c_timestamp >= h.c_sdate  and (h.c_edate IS NULL or qs.c_timestamp <= h.c_edate)
join nice_wfm_customer1.dbo.r_ct ct on ct.c_oid = e.c_oid
join nice_wfm_customer1.dbo.r_entitysetmbr em on e.c_oid = em.c_entity
inner join nice_wfm_customer1.dbo.r_entityset es on em.c_entityset = es.c_oid  AND es.c_name in 
('CA-FSS CT MCAP','CA-FSS CT MFP','CA-FSS CT MH','CA-FSS CT TN','CA-HCO CT Callbacks','CA-HCO CT Inbound','CA-HCO CT Overall','FL-FHK Inbound','GA-GF Atlanta Inbound','GA-GF Atlanta Outbound','GA-GF LABH Only Inbound','GA-GF LABH Only Outbound','GA-GF LARA Only Inbound','GA-GF Louisiana Only Inbound','GA-GF NH Only','GA-IES All CTs','GA-IES CTC All CTs','GA-IES HelpDesk','IL-CES CT SET GENERAL INBOUND','IL-CES CT SET GENERAL OUTBOUND','IL-CES CT SET INBOUND','IL-CES CT SET OUTBOUND','IL-CES CT SET SPEC INBOUND','IL-CES CT SET SPEC OUTBOUND SET','IL-EEV CT ALL','MA-BOS CT All','MBSHCC CT Set All','MD-HBE All','MD-HBE Glendale','MD-HBE Lord Baltimore','MI-APCC CT Set All','MI-CSCC CT Set All','MI-EBS CT Set All','MI-MSS CT Set','MI-PSSCC CT Set All','MO-CS All CTs','PA-EAP Inbound','SOA Custom CT Set','VA-EBS CT Set All','VA-SOA GA-GF ALL','VA-SOA LARA All','VA-SOA MAH ALL','VT-VHC Inbound','MI-WR CT Set All')
inner join nice_wfm_customer1.dbo.r_tzinfo tz 	on e.c_tz = tz.c_tz and qs.c_timestamp >= tz.c_begin and qs.c_timestamp < tz.c_end
and Convert(char,Cast(switchoffset(qs.c_timestamp, tz.c_tzoffset) as date), 126) = convert(varchar, cast(cast(DATEADD(DD, 0, GETDATE()) as varchar(12)) as datetime) -1,23)
) t2 on t1.CT_Set = t2.CT_Set and t1.CT = t2.CT and t1.Interval = t2.Interval 
group by t1.CT_Set
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as date)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as datetime)
,Cast(switchoffset(t1.Interval, t1.c_tzoffset) as time)
having (round(sum(Case WHEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) AND isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0)
WHEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull((cast(t1.c_revslreq as float) * cast(t1.c_reveffsl as float)),0) and isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) > isnull(t1.c_revmaxoccreq,0) THEN isnull((cast(t1.c_revasareq as float) * cast(t1.c_reveffasa as float)),0) 
Else ISNULL(t1.c_revmaxoccreq,0) end),2) > 0 or round(sum(cast((Left(t2.c_revconttime,4)*86400)+(substring(t2.c_revconttime,6,2)*3600)+(substring(t2.c_revconttime,9,2)*60)+(cast(substring(t2.c_revconttime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revworktime,4)*86400)+(substring(t2.c_revworktime,6,2)*3600)+(substring(t2.c_revworktime,9,2)*60)+(cast(substring(t2.c_revworktime,12,6)as decimal)) as float)
+ cast((Left(t2.c_revreadytime,4)*86400)+(substring(t2.c_revreadytime,6,2)*3600)+(substring(t2.c_revreadytime,9,2)*60)+(cast(substring(t2.c_revreadytime,12,6)as decimal)) as float))/900.0,2) > 0)