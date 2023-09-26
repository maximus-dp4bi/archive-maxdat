/* Get yesterday's Cisco NC UICC queue stats. */
/* Cisco Enterprise PRD DB: 10.150.114.40 */

/* Get list of queues from NICE db to add into this query. */
/* NICE PRD DB: 10.150.140.20 */
/*
select substring(q.C_QTAG,2,4) + ','
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Cisco Enterprise'  
where 
  cast(e.C_ID as varchar) like '95%%%'
  and e.C_DTIME is null
order by 1;
*/

select
  cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) as Date,
  pq.PrecisionQueueID,
  pq.EnterpriseName as QName,
  sum(si.CallsAnswered + si.RouterCallsAbandQ + si.RouterCallsAbandToAgent + si.ShortCalls) Received,
  sum(si.AnsInterval1 + si.AnsInterval2) HandledBeforeThresh, 
  sum(si.CallsHandled - (si.AnsInterval1 + si.AnsInterval2)) HandledAftThresh,
  sum(si.CallsHandled) Handled,
  sum(si.ShortCalls + si.AbandInterval1 + si.AbandInterval2) AbanBeforeThresh, 
  sum(si.AbandInterval3 + si.AbandInterval4 + si.AbandInterval5 + si.AbandInterval6 + si.AbandInterval7 + si.AbandInterval8 + si.AbandInterval9 + si.AbandInterval10) AbanAftThresh,
  sum(si.ShortCalls + si.AbandInterval1 + si.AbandInterval2 + si. AbandInterval3 + si.AbandInterval4 + si.AbandInterval5 + si.AbandInterval6 + si.AbandInterval7 + si.AbandInterval8 + si.AbandInterval9 + si.AbandInterval10) Abandoned
from maxco_awdb.dbo.Call_Type_SG_Interval si
inner join maxco_awdb.dbo.Call_Type_Interval cti on si.DateTime = cti.DateTime and si.CallTypeID = cti.CallTypeID
inner join maxco_awdb.dbo.Precision_Queue pq on si.PrecisionQueueID = pq.PrecisionQueueID
where 
  si.PrecisionQueueID in (5523, 5530, 5542, 5547, 5556, 5566, 5567)
  and cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) = cast(dateadd(DAY,-1,getDate()) as date)
group by 
  cast(switchoffset(todatetimeoffset(si.DateTime, -360), '-04:00') as date),
  pq.EnterpriseName,
  pq.PrecisionQueueID
order by 1,2,3;
