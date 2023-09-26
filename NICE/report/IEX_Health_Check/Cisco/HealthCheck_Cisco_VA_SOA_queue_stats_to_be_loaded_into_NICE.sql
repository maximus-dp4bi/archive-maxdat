/* Get yesterday's Cisco VA SOA Hampton queue stats. */
/* Cisco Enterprise PRD DB: 10.150.102.86 */

/* Get list of queues from NICE db to add into this query. */
/* NICE PRD DB: 10.150.140.20 */
/*
select substring(q.C_QTAG,2,4) + ','
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Cisco Enterprise'  
where 
  cast(e.C_ID as varchar) like '80%%%'
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
  si.PrecisionQueueID in (5087, 5088, 5089, 5090, 5194, 5195, 5202, 5203, 5204, 5205, 5206, 5207, 5208, 5212, 5246, 5247, 5248, 5269, 5270, 5271, 5272, 5273, 5274, 5292, 5293, 5294, 5296, 5297, 5298, 5299, 5300, 5301, 5302, 5303, 5304, 5305,
						  5307, 5308, 5309,5310, 5311, 5312, 5313, 5314, 5315, 5316, 5317, 5318, 5319, -- PAIEB queues
						  5323, 5324, 5326, 5327, 5328, 5329, 5330, 5331, 5332, 5333, 5334, 5342, 5357, 5446, 5447, 5448, 5449, 5450, 5451, 5511, 5512, 5518, 5545, 5546, 5554, 5574, 5575, 5588, 5589, 5601, 5602, 5603, 5644, 5645, 5646, 5647, 5648)	   -- MAMH queues
  and cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) = cast(dateadd(DAY,-1,getDate()) as date)
group by 
  cast(switchoffset(todatetimeoffset(si.DateTime, -360), '-04:00') as date),
  pq.EnterpriseName,
  pq.PrecisionQueueID
order by 1,2,3;
