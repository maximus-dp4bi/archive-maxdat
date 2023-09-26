/* Get yesterday's NICE VA Enrollment Broker queue stats that originated in Cisco. */
/* NICE PRD DB: 10.150.140.20 */

select 
  cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) as Date,
  q.C_QTAG, 
  e.C_NAME,
  sum(qs.C_ORIGCONTRCVD) as Received,
  sum(qs.C_ORIGHNDLBEFSL) as Handled_Before_Threshold,
  sum(qs.C_ORIGHNDLAFTSL) as Handled_After_Threshold,
  sum(qs.C_ORIGHNDLBEFSL + qs.C_ORIGHNDLAFTSL) as Handled,
  sum(qs.C_ORIGABANDBEFSL) as Abandoned_Before_Threshold,
  sum(qs.C_ORIGABANDAFTSL) as Abandoned_After_Threshold,
  sum(qs.C_ORIGABANDBEFSL + qs.C_ORIGABANDAFTSL) as Abandoned
from nice_wfm_customer1.dbo.R_QUEUESTATS qs
inner join nice_wfm_customer1.dbo.R_QUEUE Q on QS.C_QUEUE = Q.C_OID 
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Cisco Enterprise'
inner join nice_wfm_customer1.dbo.R_ENTITY E on Q.C_OID = E.C_OID and E.C_TYPE = 'Q'
where
  cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) = cast(dateadd(DAY,-1,getDate()) as date)
  and cast(e.C_ID as varchar) like '45%%%'
  and e.C_DTIME is null
group by 
  q.C_QTAG,
  e.C_NAME,
  cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date),
  qs.C_QUEUE
order by 1,2,3;


