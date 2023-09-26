/* Get yesterday's Cisco queue stats. */
/* Cisco Enterprise PRD DB: 10.150.114.40 */

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
  si.PrecisionQueueID in 
    (5001,5004,5005,5006,5007,5008,5009,5010,5011,5012,5013,5014,5015,5016,5017,5018,5019,5020,
     5021,5022,5023,5024,5030,5033,5034,5035,5036,5037,5038,5056,5057,5058,5059)
  and cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) = cast(dateadd(DAY,-1,getDate()) as date)
group by 
  cast(switchoffset(todatetimeoffset(si.DateTime, -360), '-04:00') as date),
  pq.EnterpriseName,
  pq.PrecisionQueueID
order by 1,2,3;
